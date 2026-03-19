#include "AgoraMediaBase.h"
#include "iris_engine_base.h"
#include "iris_rtc_rendering_c.h"
#include "iris_rtc_rendering_cxx.h"
#define TEXTURE_RENDER_LOGGER_IMPL
#include "texture_render_logger.h"
#include "vm_util.h"
#include <EGL/egl.h>
#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>
#include <android/log.h>
#include <android/native_window_jni.h>
#include <cmath>
#include <jni.h>
#include <memory>
#include <vector>
#include <time.h>

namespace agora {
namespace iris {
namespace rendering {
#define LOG_TAG "IrisRendering"
#define LOGCATE(...)                                                           \
  __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

#define LOGCATD(...)                                                           \
  __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)

#define CHECK_GL_ERROR(...)                                                    \
  {                                                                            \
    int error = glGetError();                                                  \
    if (error != 0)                                                            \
      LOGCATE("CHECK_GL_ERROR %s glGetError = %d, line = %d, ", __FUNCTION__,  \
              error, __LINE__);                                                \
  }

class GLContext {
 public:
  explicit GLContext(ANativeWindow *window)
      : window_(window), display_(EGL_NO_DISPLAY), surface_(EGL_NO_SURFACE),
        context_(EGL_NO_CONTEXT), share_context_(EGL_NO_CONTEXT),
        is_setup_surface_(false) {}

  ~GLContext() { Terminate(); }

  bool SetupSurface(ANativeWindow *window) {
    if (is_setup_surface_) { return is_setup_surface_; }

    if (!window_) {
      is_setup_surface_ = false;
      return false;
    }

    if (window_ != window && display_ != EGL_NO_DISPLAY
        && surface_ != EGL_NO_SURFACE) {
      eglDestroySurface(display_, surface_);
      CHECK_GL_ERROR()
    }

    window_ = window;

    display_ = eglGetDisplay(EGL_DEFAULT_DISPLAY);
    CHECK_GL_ERROR()

    eglInitialize(display_, 0, 0);
    CHECK_GL_ERROR()

    const EGLint attribs[] = {EGL_RENDERABLE_TYPE,
                              EGL_OPENGL_ES2_BIT,// Request opengl ES2.0
                              EGL_SURFACE_TYPE,
                              EGL_WINDOW_BIT,
                              EGL_BLUE_SIZE,
                              8,
                              EGL_GREEN_SIZE,
                              8,
                              EGL_RED_SIZE,
                              8,
                              EGL_NONE};

    EGLint num_configs = 0;
    eglChooseConfig(display_, attribs, &config_, 1, &num_configs);
    CHECK_GL_ERROR()

    surface_ = eglCreateWindowSurface(display_, config_, window_, nullptr);
    if (surface_ == EGL_NO_SURFACE) {
      CHECK_GL_ERROR()
      is_setup_surface_ = false;
      return false;
    }

    is_setup_surface_ = true;

    return is_setup_surface_;
  }

  bool GLContextMakeCurrent(const void *share_context) {
    // Need recreate context
    if (context_ != EGL_NO_CONTEXT && share_context_ != share_context) {
      eglMakeCurrent(display_, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
      eglDestroyContext(display_, context_);
      context_ = EGL_NO_CONTEXT;
      share_context_ = EGL_NO_CONTEXT;
    }

    if (context_ == EGL_NO_CONTEXT) {
      share_context_ = (EGLContext) share_context;
      const EGLint context_attribs[] = {EGL_CONTEXT_CLIENT_VERSION,
                                        2,// Request opengl ES2.0
                                        EGL_NONE};
      context_ =
          eglCreateContext(display_, config_, share_context_, context_attribs);
      if (context_ == EGL_NO_CONTEXT) {
        CHECK_GL_ERROR()
        return false;
      }
    }

    const auto result =
        EGLMakeCurrentIfNecessary(display_, surface_, surface_, context_)
        == EGL_TRUE;
    if (!result) { CHECK_GL_ERROR() }

    return result;
  }

  void GLContextClearCurrent() {
    if (context_ != EGL_NO_CONTEXT) {
        eglMakeCurrent(display_, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
    }
  }

  EGLint Swap() {
    eglSwapBuffers(display_, surface_);
    CHECK_GL_ERROR()

    return EGL_SUCCESS;
  }

 private:
  static EGLBoolean EGLMakeCurrentIfNecessary(EGLDisplay display,
                                              EGLSurface draw, EGLSurface read,
                                              EGLContext context) {
    if (display != eglGetCurrentDisplay()
        || draw != eglGetCurrentSurface(EGL_DRAW)
        || read != eglGetCurrentSurface(EGL_READ)
        || context != eglGetCurrentContext()) {
      return eglMakeCurrent(display, draw, read, context);
    }
    // The specified context configuration is already current.
    return EGL_TRUE;
  }

  void Terminate() {
    if (display_ != EGL_NO_DISPLAY) {
      eglMakeCurrent(display_, EGL_NO_SURFACE, EGL_NO_SURFACE, EGL_NO_CONTEXT);
      if (context_ != EGL_NO_CONTEXT) { eglDestroyContext(display_, context_); }

      if (surface_ != EGL_NO_SURFACE) { eglDestroySurface(display_, surface_); }
      eglTerminate(display_);
    }

    display_ = EGL_NO_DISPLAY;
    context_ = EGL_NO_CONTEXT;
    share_context_ = EGL_NO_CONTEXT;
    surface_ = EGL_NO_SURFACE;
    window_ = nullptr;
    is_setup_surface_ = false;
  }

 private:
  // EGL configurations
  ANativeWindow *window_;
  EGLDisplay display_;
  EGLSurface surface_;
  EGLContext context_;
  EGLContext share_context_{};
  EGLConfig config_{};

  bool is_setup_surface_;
};

class ScopedShader {

 public:
  ScopedShader(const char *vertexShader, const char *fragmentShader) {
    this->vertex_shader_ = vertexShader;
    this->fragment_shader_ = fragmentShader;

    program_ = CreateProgram();
  }

  ~ScopedShader() { Release(); }

  const GLuint &GetProgram() const { return program_; }

 private:
  GLuint program_;
  const char *vertex_shader_;
  const char *fragment_shader_;

  static GLuint initShader(const char *source, int type) {
    GLuint sh = glCreateShader(type);
    if (sh == 0) {
      LOGCATE("glCreateShader %d failed", type);

      return 0;
    }
    glShaderSource(sh,
                   1,
                   &source, 0);
    CHECK_GL_ERROR()

    glCompileShader(sh);
    CHECK_GL_ERROR()

    GLint status;
    glGetShaderiv(sh, GL_COMPILE_STATUS, &status);
    if (status == 0) {
      LOGCATE("glCompileShader %d failed", type);
      LOGCATE("source %s", source);
      auto *infoLog = new GLchar[2048];
      GLsizei length;
      glGetShaderInfoLog(sh, 2048, &length, infoLog);
      LOGCATE("ERROR::SHADER::VERTEX::COMPILATION_FAILED %s", infoLog);

      delete[] infoLog;
      return 0;
    }

    return sh;
  }

  GLuint CreateProgram() {
    GLuint vsh = initShader(vertex_shader_, GL_VERTEX_SHADER);
    GLuint fsh = initShader(fragment_shader_, GL_FRAGMENT_SHADER);

    GLuint program = glCreateProgram();
    if (program == 0) {
      LOGCATE("glCreateProgram failed");
      return 0;
    }

    glAttachShader(program, vsh);
    CHECK_GL_ERROR()
    glAttachShader(program, fsh);
    CHECK_GL_ERROR()

    glLinkProgram(program);
    CHECK_GL_ERROR()
    GLint status = 0;
    glGetProgramiv(program, GL_LINK_STATUS, &status);
    CHECK_GL_ERROR()
    if (status == 0) {
      LOGCATE("glLinkProgram failed");
      return 0;
    }

    glDeleteShader(vsh);
    CHECK_GL_ERROR()
    glDeleteShader(fsh);
    CHECK_GL_ERROR()
    glUseProgram(program);
    CHECK_GL_ERROR()
    return program;
  }

  void Release() const { glDeleteProgram(program_); }
};

class RenderingOp {
 public:
  explicit RenderingOp(std::shared_ptr<GLContext> &gl_context)
      : gl_context_(gl_context) {}
  virtual ~RenderingOp() = default;
  virtual void Rendering(const agora::media::base::VideoFrame *video_frame) = 0;

  virtual agora::media::base::VIDEO_PIXEL_FORMAT Format() = 0;

 protected:
  std::shared_ptr<GLContext> gl_context_;
};

class Texture2DRendering final : public RenderingOp {
public:
    explicit Texture2DRendering(std::shared_ptr<GLContext> &gl_context)
            : RenderingOp(gl_context) {
        LOGCATD("Rendering with Texture2DRendering");
        shader_ = std::make_unique<ScopedShader>(vertex_shader_tex_2d_, frag_shader_tex_2d_);
        GLuint program = shader_->GetProgram();

        aPositionLoc_ = glGetAttribLocation(program, "a_Position");
        texCoordLoc_ = glGetAttribLocation(program, "a_TexCoord");
        texSamplerLoc_ = glGetUniformLocation(program, "s_texture");
        texMatrixLoc_ = glGetUniformLocation(program, "u_texMatrix");
    }
    ~Texture2DRendering() override {
        LOGCATD("Destroy Texture2DRendering");
        shader_.reset();
    }

    void Rendering(const agora::media::base::VideoFrame *video_frame) final {
        int textureId = video_frame->textureId;
        const float *texMatrix = video_frame->matrix;

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
        CHECK_GL_ERROR()
        glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
        CHECK_GL_ERROR()
        glViewport(0, 0, video_frame->width, video_frame->height);
        CHECK_GL_ERROR()

        // Bind 2D texture
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, textureId);
        glUniform1i(texSamplerLoc_, 0);

        glVertexAttribPointer(aPositionLoc_, 2, GL_FLOAT, false, 0, vertices);
        glEnableVertexAttribArray(aPositionLoc_);

        glVertexAttribPointer(texCoordLoc_, 2, GL_FLOAT, false, 0, texCoords);
        glEnableVertexAttribArray(texCoordLoc_);

        // Copy the texture transformation matrix over.
        glUniformMatrix4fv(texMatrixLoc_, 1, GL_FALSE, texMatrix);

        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, indices);

        gl_context_->Swap();

        // Clean up
        glDisableVertexAttribArray(aPositionLoc_);
        glDisableVertexAttribArray(texCoordLoc_);
        glBindTexture(GL_TEXTURE_2D, 0);
    }

    agora::media::base::VIDEO_PIXEL_FORMAT Format() final {
        return agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_TEXTURE_2D;
    }

private:
    const GLchar *vertex_shader_tex_2d_ =
            "attribute vec4 a_Position;\n"
            "attribute vec2 a_TexCoord;\n"
            "varying vec2 v_TexCoord;\n"
            "uniform mat4 u_texMatrix;   \n"
            "void main() {\n"
            "  gl_Position = a_Position;\n"
            "  vec2 tmpTexCoord = vec2(a_TexCoord.x, 1.0 - a_TexCoord.y);\n"
            "  v_TexCoord = (u_texMatrix * vec4(tmpTexCoord, 0, 1)).xy; \n"
            "}\n";

    const GLchar *frag_shader_tex_2d_ =
            "precision mediump float;\n"
            "varying vec2 v_TexCoord;\n"
            "uniform sampler2D s_texture;\n"
            "void main() {\n"
            "  gl_FragColor = texture2D(s_texture, v_TexCoord);\n"
            "}\n";

    // clang-format off
    const GLfloat vertices[8] = {
            -1.0f, 1.0f,
            -1.0f, -1.0f,
            1.0f,  -1.0f,
            1.0f,  1.0f
    };

    const GLfloat texCoords[8] = {
            0.0f, 0.0f,
            0.0f, 1.0f,
            1.0f, 1.0f,
            1.0f, 0.0f
    };

    const GLushort indices[6] = {
            0, 1, 2,
            0, 2, 3
    };// draw in this order: 0,1,2; 0,2,3

    // clang-format on

    GLint aPositionLoc_;
    GLint texCoordLoc_;
    GLint texMatrixLoc_;
    GLint texSamplerLoc_;
    std::unique_ptr<ScopedShader> shader_;
};


class OESTextureRendering final : public RenderingOp {
public:
    explicit OESTextureRendering(std::shared_ptr<GLContext> &gl_context)
            : RenderingOp(gl_context) {
        LOGCATE("Rendering with OESTextureRendering");
        shader_ = std::make_unique<ScopedShader>(vertex_shader_tex_oes_,
                                                 frag_shader_tex_oes_);
        GLuint program = shader_->GetProgram();

        aPositionLoc_ = glGetAttribLocation(program, "a_Position");
        texCoordLoc_ = glGetAttribLocation(program, "a_TexCoord");
        texSamplerLoc_ = glGetUniformLocation(program, "s_texture");
        texMatrixLoc_ = glGetUniformLocation(program, "u_texMatrix");
    }
    ~OESTextureRendering() override {
        LOGCATD("Destroy OESTextureRendering");
        shader_.reset();
    }

    void Rendering(const agora::media::base::VideoFrame *video_frame) final {
        int textureId = video_frame->textureId;
        const float *texMatrix = video_frame->matrix;

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
        CHECK_GL_ERROR()
        glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
        CHECK_GL_ERROR()
        glViewport(0, 0, video_frame->width, video_frame->height);
        CHECK_GL_ERROR()

        // Bind external oes texture
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_EXTERNAL_OES, textureId);
        glUniform1i(texSamplerLoc_, 0);

        glVertexAttribPointer(aPositionLoc_, 2, GL_FLOAT, false, 0, vertices);
        glEnableVertexAttribArray(aPositionLoc_);

        glVertexAttribPointer(texCoordLoc_, 2, GL_FLOAT, false, 0, texCoords);
        glEnableVertexAttribArray(texCoordLoc_);

        // Copy the texture transformation matrix over.
        glUniformMatrix4fv(texMatrixLoc_, 1, GL_FALSE, texMatrix);

        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, indices);

        gl_context_->Swap();

        // Clean up
        glDisableVertexAttribArray(aPositionLoc_);
        glDisableVertexAttribArray(texCoordLoc_);
        glBindTexture(GL_TEXTURE_EXTERNAL_OES, 0);
    }

    agora::media::base::VIDEO_PIXEL_FORMAT Format() final {
        return agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_TEXTURE_OES;
    }

private:
    const GLchar *vertex_shader_tex_oes_ =
            "attribute vec4 a_Position;\n"
            "attribute vec2 a_TexCoord;\n"
            "varying vec2 v_TexCoord;\n"
            "uniform mat4 u_texMatrix;   \n"
            "void main() {\n"
            "  gl_Position = a_Position;\n"
            "  vec2 tmpTexCoord = vec2(a_TexCoord.x, 1.0 - a_TexCoord.y);\n"
            "  v_TexCoord = (u_texMatrix * vec4(tmpTexCoord, 0, 1)).xy; \n"
            "}\n";

    const GLchar *frag_shader_tex_oes_ =
            "#extension GL_OES_EGL_image_external : require\n"
            "precision mediump float;\n"
            "varying vec2 v_TexCoord;\n"
            "uniform samplerExternalOES s_texture;\n"
            "void main() {\n"
            "  gl_FragColor = texture2D(s_texture, v_TexCoord);\n"
            "}\n";

    // clang-format off
    const GLfloat vertices[8] = {
            -1.0f, 1.0f,
            -1.0f, -1.0f,
            1.0f,  -1.0f,
            1.0f,  1.0f
    };

    const GLfloat texCoords[8] = {
            0.0f, 0.0f,
            0.0f, 1.0f,
            1.0f, 1.0f,
            1.0f, 0.0f
    };

    const GLushort indices[6] = {
            0, 1, 2,
            0, 2, 3
    };// draw in this order: 0,1,2; 0,2,3

    // clang-format on

    GLint aPositionLoc_;
    GLint texCoordLoc_;
    GLint texMatrixLoc_;
    GLint texSamplerLoc_;
    std::unique_ptr<ScopedShader> shader_;
};

class YUVRendering final : public RenderingOp {

 public:
  explicit YUVRendering(std::shared_ptr<GLContext> &gl_context)
      : RenderingOp(gl_context), frame_count_(0) {
    LOGCATD("Rendering with YUVRendering");
    shader_ =
        std::make_unique<ScopedShader>(vertex_shader_yuv_, frag_shader_yuv_);
    GLuint program = shader_->GetProgram();
    aPositionLoc_ = glGetAttribLocation(program, "aPosition");
    texCoordLoc_ = glGetAttribLocation(program, "aTextCoord");

    yTextureLoc_ = glGetUniformLocation(program, "yTexture");
    uTextureLoc_ = glGetUniformLocation(program, "uTexture");
    vTextureLoc_ = glGetUniformLocation(program, "vTexture");
    colorRangeLoc_ = glGetUniformLocation(program, "u_colorRange");

    LOGCATD("YUVRendering initialized - colorRangeLoc_: %d", colorRangeLoc_);

    glGenTextures(3, texs_);
    CHECK_GL_ERROR()
  }
  ~YUVRendering() override {
    LOGCATD("Destroy YUVRendering");
    shader_.reset();
    glDeleteTextures(3, texs_);
  }
  void Rendering(const agora::media::base::VideoFrame *video_frame) final {
    CHECK_GL_ERROR()

    int width = video_frame->width;
    int height = video_frame->height;
    uint8_t *yBuffer = video_frame->yBuffer;
    uint8_t *uBuffer = video_frame->uBuffer;
    uint8_t *vBuffer = video_frame->vBuffer;
    int yStride = video_frame->yStride;
    int uStride = video_frame->uStride;
    int vStride = video_frame->vStride;

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);
    CHECK_GL_ERROR()
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    CHECK_GL_ERROR()
    glViewport(0, 0, width, height);
    CHECK_GL_ERROR()

    // Ensure that the unpack alignment is set to 1 byte to avoid any alignment issues with YUV data.
    glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
    CHECK_GL_ERROR()

    glEnableVertexAttribArray(aPositionLoc_);
    CHECK_GL_ERROR()

    glVertexAttribPointer(aPositionLoc_, 3, GL_FLOAT, GL_FALSE,
                          3 * sizeof(float), vertices_);
    CHECK_GL_ERROR()

    // Adjust the tex coords to avoid green edge issue
    float sFactor = 1.0f;
    if (width != yStride) {
      sFactor = (float) width / (float) yStride - 0.02f;
    }

    float fragment[] = {sFactor, 0.0f, 0.0f, 0.0f, sFactor, 1.0f, 0.0f, 1.0f};

    glEnableVertexAttribArray(texCoordLoc_);
    CHECK_GL_ERROR()

    glVertexAttribPointer(texCoordLoc_, 2, GL_FLOAT, GL_FALSE,
                          2 * sizeof(float), fragment);
    CHECK_GL_ERROR()

    // Set color range: 0 = limited range (default), 1 = full range
    // TODO: Read from video_frame->metaInfo if available in the future
    int colorRange = 1; // ⚡ TESTING: Use full range
    glUniform1i(colorRangeLoc_, colorRange);
    CHECK_GL_ERROR()

    // Log color range info every 30 frames for debugging
    frame_count_++;
    if (frame_count_ % 30 == 0) {
      LOGCATD("YUV Rendering [Frame %d]: ColorRange=%d (0=Limited, 1=Full)", 
              frame_count_, colorRange);
    }

    // y buffer texture
    glActiveTexture(GL_TEXTURE0);
    CHECK_GL_ERROR()
    glBindTexture(GL_TEXTURE_2D, texs_[0]);
    CHECK_GL_ERROR()
    glUniform1i(yTextureLoc_, 0);
    CHECK_GL_ERROR()
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    CHECK_GL_ERROR()
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    CHECK_GL_ERROR()
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    CHECK_GL_ERROR()
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    CHECK_GL_ERROR()
    glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE, yStride, height, 0,
                 GL_LUMINANCE, GL_UNSIGNED_BYTE, yBuffer);
    CHECK_GL_ERROR()

    // u buffer texture
    glActiveTexture(GL_TEXTURE1);
    CHECK_GL_ERROR()
    glBindTexture(GL_TEXTURE_2D, texs_[1]);
    CHECK_GL_ERROR()
    glUniform1i(uTextureLoc_, 1);
    CHECK_GL_ERROR()
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    CHECK_GL_ERROR()
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    CHECK_GL_ERROR()
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    CHECK_GL_ERROR()
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    CHECK_GL_ERROR()
    glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE, uStride, height / 2, 0,
                 GL_LUMINANCE, GL_UNSIGNED_BYTE, uBuffer);
    CHECK_GL_ERROR()

    // v buffer texture
    glActiveTexture(GL_TEXTURE2);
    CHECK_GL_ERROR()
    glBindTexture(GL_TEXTURE_2D, texs_[2]);
    CHECK_GL_ERROR()
    glUniform1i(vTextureLoc_, 2);
    CHECK_GL_ERROR()
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    CHECK_GL_ERROR()
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    CHECK_GL_ERROR()
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    CHECK_GL_ERROR()
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    CHECK_GL_ERROR()
    glTexImage2D(GL_TEXTURE_2D, 0, GL_LUMINANCE, vStride, height / 2, 0,
                 GL_LUMINANCE, GL_UNSIGNED_BYTE, vBuffer);
    CHECK_GL_ERROR()

    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    CHECK_GL_ERROR()

    // Unbind textures explicitly
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, 0);
    glActiveTexture(GL_TEXTURE1); 
    glBindTexture(GL_TEXTURE_2D, 0);
    glActiveTexture(GL_TEXTURE2);
    glBindTexture(GL_TEXTURE_2D, 0);
    CHECK_GL_ERROR()

    gl_context_->Swap();

    glFinish(); // Add sync point
    gl_context_->GLContextClearCurrent();
  }

  agora::media::base::VIDEO_PIXEL_FORMAT Format() override {
    return agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_PIXEL_I420;
  }

 private:
  const char *vertex_shader_yuv_ =
      "attribute vec4 aPosition;\n"
      "attribute vec2 aTextCoord;\n"
      "varying vec2 vTextCoord;\n"
      "void main() {\n"
      "    vTextCoord = vec2(aTextCoord.x, 1.0 - aTextCoord.y);\n"
      "    gl_Position = aPosition;\n"
      "}\n";

  const char *frag_shader_yuv_ =
      "precision mediump float;\n"
      "varying vec2 vTextCoord;\n"
      "uniform sampler2D yTexture;\n"
      "uniform sampler2D uTexture;\n"
      "uniform sampler2D vTexture;\n"
      "uniform int u_colorRange;\n"
      "void main() {\n"
      "    float y = texture2D(yTexture, vTextCoord).r;\n"
      "    float u = texture2D(uTexture, vTextCoord).r;\n"
      "    float v = texture2D(vTexture, vTextCoord).r;\n"
      "    \n"
      "    // Apply color range conversion\n"
      "    if (u_colorRange == 0) {\n"
      "        // Limited range (16-235 for Y, 16-240 for UV)\n"
      "        y = (y - 0.0625) * 1.164;\n"
      "        u = u - 0.5;\n"
      "        v = v - 0.5;\n"
      "    } else {\n"
      "        // Full range (0-255)\n"
      "        u = u - 0.5;\n"
      "        v = v - 0.5;\n"
      "    }\n"
      "    \n"
      "    // BT.601 conversion matrix\n"
      "    vec3 rgb;\n"
      "    rgb.r = y + 1.402 * v;\n"
      "    rgb.g = y - 0.344136 * u - 0.714136 * v;\n"
      "    rgb.b = y + 1.772 * u;\n"
      "    \n"
      "    gl_FragColor = vec4(rgb, 1.0);\n"
      "}\n";

  // clang-format off
  const float vertices_[12] = {
          1.0f, -1.0f, 0.0f,
          -1.0f, -1.0f, 0.0f,
          1.0f, 1.0f,  0.0f,
          -1.0f, 1.0f,  0.0f
  };
  // clang-format on

  GLuint texs_[3] = {0};

  GLint aPositionLoc_;
  GLint texCoordLoc_;

  GLint yTextureLoc_;
  GLint uTextureLoc_;
  GLint vTextureLoc_;
  GLint colorRangeLoc_;

  int frame_count_;

  std::unique_ptr<ScopedShader> shader_;
};

/// Statistics window for periodic summary logging (Android).
struct FrameStatsAndroid {
  int64_t frame_count = 0;
  int64_t out_of_order_count = 0;
  int64_t stutter_count = 0;
  int64_t burst_count = 0;
  int64_t gl_error_count = 0;
  double min_interval_ms = 1e9;
  double max_interval_ms = 0;
  double sum_interval_ms = 0;
  int64_t first_render_time_ms = 0;
  int64_t last_render_time_ms = 0;
  uint64_t window_start_ns = 0;

  void reset(uint64_t now_ns) {
    frame_count = 0;
    out_of_order_count = 0;
    stutter_count = 0;
    burst_count = 0;
    gl_error_count = 0;
    min_interval_ms = 1e9;
    max_interval_ms = 0;
    sum_interval_ms = 0;
    first_render_time_ms = 0;
    last_render_time_ms = 0;
    window_start_ns = now_ns;
  }
};

class NativeTextureRenderer final
    : public agora::iris::VideoFrameObserverDelegate {
 public:
  explicit NativeTextureRenderer(
      JNIEnv *env, jobject j_iris_renderer_obj, jobject surface_jni,
      agora::iris::IrisRtcRendering *iris_rtc_rendering, unsigned int uid,
      const char *channel_id, int video_source_type, int video_view_setup_mode)
      : jvm_(nullptr), iris_rtc_rendering_(iris_rtc_rendering), width_(0),
        height_(0), last_frame_time_ms_(0), total_frame_count_(0),
        last_receive_time_ns_(0), uid_(uid) {
    struct timespec ts_init;
    clock_gettime(CLOCK_MONOTONIC, &ts_init);
    stats_.reset((uint64_t)ts_init.tv_sec * 1000000000ULL + ts_init.tv_nsec);

    env->GetJavaVM(&jvm_);
    j_iris_renderer_obj_ = env->NewGlobalRef(j_iris_renderer_obj);
    jclass j_caller_class = env->GetObjectClass(j_iris_renderer_obj_);
    j_on_size_changed_method_ =
        env->GetMethodID(j_caller_class, "onSizeChanged", "(II)V");
    env->DeleteLocalRef(j_caller_class);

    native_windows_ = ANativeWindow_fromSurface(env, surface_jni);

    IrisRtcVideoFrameConfig config;
    config.uid = uid;
    config.video_source_type = video_source_type;
    config.video_frame_format =
        agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_PIXEL_DEFAULT;
    if (channel_id) {
      strcpy(config.channelId, channel_id);
    } else {
      strcpy(config.channelId, "");
    }
    config.video_view_setup_mode = video_view_setup_mode;
    config.observed_frame_position = agora::media::base::VIDEO_MODULE_POSITION::POSITION_POST_CAPTURER
            | agora::media::base::VIDEO_MODULE_POSITION::POSITION_PRE_RENDERER;

    if (iris_rtc_rendering_) {
      delegate_id_ =
          iris_rtc_rendering_->AddVideoFrameObserverDelegate(config, this);
    }
  }

  ~NativeTextureRenderer() final {}

  void OnVideoFrameReceived(const void *videoFrame,
                            const IrisRtcVideoFrameConfig &config,
                            bool resize) override {
    if (!native_windows_) { return; }

    const auto *video_frame =
        static_cast<const agora::media::base::VideoFrame *>(videoFrame);

    if (video_frame->width == 0 || video_frame->height == 0) { return; }

    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    uint64_t now_ns = (uint64_t)ts.tv_sec * 1000000000ULL + ts.tv_nsec;

    // --- Anomaly: out-of-order renderTimeMs ---
    if (video_frame->renderTimeMs < last_frame_time_ms_) {
      stats_.out_of_order_count++;
      LOGCATE("Frame dropped: current time %lld ms, last frame time %lld ms",
              video_frame->renderTimeMs, last_frame_time_ms_);
      TextureRenderLoggerAndroid::Log("NativeRenderer",
          "WARN out_of_order: renderTimeMs=%lld, prev=%lld, "
          "delta=%lldms, total_recv=%lld, uid=%u",
          video_frame->renderTimeMs, last_frame_time_ms_,
          last_frame_time_ms_ - video_frame->renderTimeMs,
          total_frame_count_, uid_);
      return;
    }

    // --- Frame interval tracking ---
    if (last_receive_time_ns_ > 0) {
      double delta_ms = (double)(now_ns - last_receive_time_ns_) / 1e6;
      stats_.sum_interval_ms += delta_ms;
      if (delta_ms < stats_.min_interval_ms) stats_.min_interval_ms = delta_ms;
      if (delta_ms > stats_.max_interval_ms) stats_.max_interval_ms = delta_ms;

      if (delta_ms > 200.0) {
        stats_.stutter_count++;
        TextureRenderLoggerAndroid::Log("NativeRenderer",
            "WARN recv_stutter: interval=%.1fms, renderTimeMs=%lld, "
            "total_recv=%lld, uid=%u",
            delta_ms, video_frame->renderTimeMs, total_frame_count_, uid_);
      } else if (delta_ms < 5.0) {
        stats_.burst_count++;
        TextureRenderLoggerAndroid::Log("NativeRenderer",
            "WARN recv_burst: interval=%.1fms, renderTimeMs=%lld, "
            "total_recv=%lld, uid=%u",
            delta_ms, video_frame->renderTimeMs, total_frame_count_, uid_);
      }
    }
    last_receive_time_ns_ = now_ns;

    last_frame_time_ms_ = video_frame->renderTimeMs;
    total_frame_count_++;
    stats_.frame_count++;
    if (stats_.first_render_time_ms == 0) {
      stats_.first_render_time_ms = video_frame->renderTimeMs;
    }
    stats_.last_render_time_ms = video_frame->renderTimeMs;

    // --- Periodic summary: every 5 seconds ---
    double window_sec = (double)(now_ns - stats_.window_start_ns) / 1e9;
    if (window_sec >= 5.0 && stats_.frame_count > 0) {
      double avg_interval = stats_.frame_count > 1
          ? stats_.sum_interval_ms / (stats_.frame_count - 1) : 0;
      double fps = stats_.frame_count / window_sec;
      const char* type_name = "UNKNOWN";
      switch(video_frame->type) {
        case agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_TEXTURE_2D:
          type_name = "TEXTURE_2D"; break;
        case agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_TEXTURE_OES:
          type_name = "TEXTURE_OES"; break;
        case agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_PIXEL_I420:
          type_name = "I420"; break;
        default: break;
      }
      TextureRenderLoggerAndroid::Log("NativeRenderer",
          "STATS window=%.1fs | "
          "recv: count=%lld fps=%.1f interval_ms(min/avg/max)=%.1f/%.1f/%.1f | "
          "warn: ooo=%lld stutter=%lld burst=%lld gl_err=%lld | "
          "renderTimeMs: first=%lld last=%lld | "
          "type=%s, size=%dx%d, uid=%u, total_recv=%lld",
          window_sec, stats_.frame_count, fps,
          stats_.min_interval_ms, avg_interval, stats_.max_interval_ms,
          stats_.out_of_order_count, stats_.stutter_count,
          stats_.burst_count, stats_.gl_error_count,
          stats_.first_render_time_ms, stats_.last_render_time_ms,
          type_name, video_frame->width, video_frame->height,
          uid_, total_frame_count_);
      stats_.reset(now_ns);
    }

    if (width_ != video_frame->width || height_ != video_frame->height) {
      TextureRenderLoggerAndroid::Log("NativeRenderer",
          "size_changed: %dx%d -> %dx%d, renderTimeMs=%lld, "
          "total_recv=%lld, uid=%u",
          width_, height_, video_frame->width, video_frame->height,
          video_frame->renderTimeMs, total_frame_count_, uid_);

      NotifySizeChangeCallback(video_frame->width, video_frame->height);
      width_ = video_frame->width;
      height_ = video_frame->height;

      rendering_op_.reset();
      gl_context_.reset();
    }

    if (!gl_context_) {
      gl_context_ = std::make_shared<GLContext>(native_windows_);
    }

    if (!gl_context_->SetupSurface(native_windows_)) {
      stats_.gl_error_count++;
      LOGCATE("GLContext#SetupSurface failed ");
      TextureRenderLoggerAndroid::Log("NativeRenderer",
          "WARN gl_setup_surface_failed: total_recv=%lld, uid=%u",
          total_frame_count_, uid_);
      return;
    }

    if (!gl_context_->GLContextMakeCurrent(video_frame->sharedContext)) {
      stats_.gl_error_count++;
      LOGCATE("GLContext#CreateContextAndMakeCurrent failed ");
      TextureRenderLoggerAndroid::Log("NativeRenderer",
          "WARN gl_make_current_failed: total_recv=%lld, uid=%u",
          total_frame_count_, uid_);
      return;
    }

    if (rendering_op_ && rendering_op_->Format() != video_frame->type) {
      rendering_op_.reset();
    }

    if (!rendering_op_) {
      if (video_frame->type == agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_TEXTURE_2D) {
        rendering_op_ = std::make_unique<Texture2DRendering>(gl_context_);
      } else if (video_frame->type
          == agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_TEXTURE_OES) {
        rendering_op_ = std::make_unique<OESTextureRendering>(gl_context_);
      } else if (video_frame->type
                 == agora::media::base::VIDEO_PIXEL_FORMAT::VIDEO_PIXEL_I420) {
        rendering_op_ = std::make_unique<YUVRendering>(gl_context_);
      } else {
        // NOT SUPPORTED.
        LOGCATE("NOT SUPPORTED format: %d", video_frame->type);
        return;
      }
    }

    // Check framebuffer status
    GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    if (status != GL_FRAMEBUFFER_COMPLETE) {
      stats_.gl_error_count++;
      LOGCATE("Framebuffer is not complete: %d", status);
      TextureRenderLoggerAndroid::Log("NativeRenderer",
          "WARN framebuffer_incomplete: status=%d, total_recv=%lld, uid=%u",
          status, total_frame_count_, uid_);
      return;
    }

    rendering_op_->Rendering(video_frame);

    glFinish(); // Add sync point
    gl_context_->GLContextClearCurrent();
  }

  void Dispose() {
    if (iris_rtc_rendering_) {
      iris_rtc_rendering_->RemoveVideoFrameObserverDelegate(delegate_id_);
      iris_rtc_rendering_ = nullptr;
    }

    if (j_iris_renderer_obj_) {
      ::iris::AttachThreadScoped ats(jvm_);
      ats.env()->DeleteGlobalRef(j_iris_renderer_obj_);
      j_iris_renderer_obj_ = nullptr;
    }

    if (native_windows_) {
      ANativeWindow_release(native_windows_);
      native_windows_ = nullptr;
    }

    rendering_op_.reset();
    gl_context_.reset();
  }

  void NotifySizeChangeCallback(int width, int height) {
    if (!j_iris_renderer_obj_) { return; }
    ::iris::AttachThreadScoped ats(jvm_);
    ats.env()->CallVoidMethod(j_iris_renderer_obj_, j_on_size_changed_method_,
                              width, height);
  }

 private:
  JavaVM *jvm_;
  jobject j_iris_renderer_obj_;
  jmethodID j_on_size_changed_method_;

  agora::iris::IrisRtcRendering *iris_rtc_rendering_;
  ANativeWindow *native_windows_;
  int width_;
  int height_;

  int delegate_id_;
  unsigned int uid_;

  int64_t last_frame_time_ms_;
  int64_t total_frame_count_;
  uint64_t last_receive_time_ns_;

  FrameStatsAndroid stats_;

  std::shared_ptr<GLContext> gl_context_;
  std::unique_ptr<RenderingOp> rendering_op_;
};

}// namespace rendering
}// namespace iris
}// namespace agora

using namespace agora::iris::rendering;

extern "C" JNIEXPORT jlong JNICALL
Java_io_agora_agora_1rtc_1ng_IrisRenderer_nativeStartRenderingToSurface(
    JNIEnv *env, jobject thiz, jlong buffer_manager_int_ptr, jobject surface,
    jlong uid, jstring channel_id, jint video_source_type,
    jint video_view_setup_mode) {
  auto *iris_rtc_rendering =
      reinterpret_cast<agora::iris::IrisRtcRendering *>(buffer_manager_int_ptr);

  auto *j_channel_id = env->GetStringUTFChars(channel_id, nullptr);
  auto *renderer = new NativeTextureRenderer(
      env, thiz, surface, iris_rtc_rendering, uid, j_channel_id,
      video_source_type, video_view_setup_mode);
  env->ReleaseStringUTFChars(channel_id, j_channel_id);
  return reinterpret_cast<jlong>(renderer);
}

extern "C" JNIEXPORT void JNICALL
Java_io_agora_agora_1rtc_1ng_IrisRenderer_nativeStopRenderingToSurface(
    JNIEnv *env, jobject thiz, jlong native_renderer_handle) {
  auto *renderer =
      reinterpret_cast<NativeTextureRenderer *>(native_renderer_handle);
  renderer->Dispose();
  delete renderer;
}

extern "C" JNIEXPORT void JNICALL
Java_io_agora_agora_1rtc_1ng_TextureRenderLogger_nativeEnableLogger(
    JNIEnv *env, jclass clazz, jstring log_dir) {
  const char *dir = env->GetStringUTFChars(log_dir, nullptr);
  TextureRenderLoggerAndroid::Enable(dir);
  env->ReleaseStringUTFChars(log_dir, dir);
}

extern "C" JNIEXPORT void JNICALL
Java_io_agora_agora_1rtc_1ng_TextureRenderLogger_nativeDisableLogger(
    JNIEnv *env, jclass clazz) {
  TextureRenderLoggerAndroid::Disable();
}