#include <bnb/glsl.frag>

#define PSI 0.1

#define SOFT_SKIN
#define skinTexturingIntensity 0.12
#define skinSoftIntensity 0.7

#define TEETH_WHITENING
#define teethSharpenIntensity 0.2
#define teethWhiteningCoeff 1.0

#define SHARPEN_EYES
#define EYES_WHITENING
#define eyesSharpenIntensity 0.3
#define eyesWhiteningCoeff 0.5

#define EYES_HIGHLIGHT




BNB_IN(0) vec2 var_uv;
BNB_IN(1) vec2 var_bg_uv;
BNB_IN(2+0) vec4 sp0;
BNB_IN(2+1) vec4 sp1;
BNB_IN(2+2) vec4 sp2;
BNB_IN(2+3) vec4 sp3;





BNB_DECLARE_SAMPLER_2D(0, 1, selection_tex);

BNB_DECLARE_SAMPLER_2D(4, 5, lookupTexEyes);

BNB_DECLARE_SAMPLER_2D(2, 3, lookupTexTeeth);

BNB_DECLARE_SAMPLER_2D(10, 11, glfx_BACKGROUND);

#if defined(EYES_HIGHLIGHT)

BNB_DECLARE_SAMPLER_2D(8, 9, tex_highlight);
#endif

vec4 textureLookup(vec4 originalColor, BNB_DECLARE_SAMPLER_2D_ARGUMENT(lookupTexture))
{
    const float epsilon = 0.000001;
    const float lutSize = 512.0;

    float blueValue = (originalColor.b * 255.0) / 4.0;

    vec2 mulB = clamp(floor(blueValue) + vec2(0.0, 1.0), 0.0, 63.0);
    vec2 row = floor(mulB / 8.0 + epsilon);
    vec4 row_col = vec4(row, mulB - row * 8.0);
    vec4 lookup = originalColor.ggrr * (63.0 / lutSize) + row_col * (64.0 / lutSize) + (0.5 / lutSize);

    float factor = blueValue - mulB.x;

    vec3 sampled1 = BNB_TEXTURE_2D_LOD(BNB_SAMPLER_2D(lookupTexture), lookup.zx, 0.).rgb;
    vec3 sampled2 = BNB_TEXTURE_2D_LOD(BNB_SAMPLER_2D(lookupTexture), lookup.wy, 0.).rgb;

    vec3 res = mix(sampled1, sampled2, factor);
    return vec4(res, originalColor.a);
}

vec4 whitening(vec4 originalColor, float factor, BNB_DECLARE_SAMPLER_2D_ARGUMENT(lookup)) {
    vec4 color = textureLookup(originalColor, BNB_PASS_SAMPLER_ARGUMENT(lookup));
    return mix(originalColor, color, factor);
}

vec4 sharpen(vec4 originalColor, float factor) {
    vec4 total = 5.0 * originalColor - BNB_TEXTURE_2D(BNB_SAMPLER_2D(glfx_BACKGROUND), sp0.zw) - BNB_TEXTURE_2D(BNB_SAMPLER_2D(glfx_BACKGROUND), sp1.zw) - BNB_TEXTURE_2D(BNB_SAMPLER_2D(glfx_BACKGROUND), sp2.zw) - BNB_TEXTURE_2D(BNB_SAMPLER_2D(glfx_BACKGROUND), sp3.zw);
    vec4 result = mix(originalColor, total, factor);
    return clamp(result, 0.0, 1.0);;
}

vec4 getLuminance4(mat4 color) {
    const vec4 rgb2y = vec4(0.299, 0.587, 0.114, 0.0);
    return rgb2y * color;
}

float getLuminance(vec4 color) {
    const vec4 rgb2y = vec4(0.299, 0.587, 0.114, 0.0);
    return dot(color, rgb2y);
}

vec4 getWeight(float intensity, vec4 nextIntensity) {
    vec4 lglg = log(nextIntensity / intensity) * log(nextIntensity / intensity);
    return exp(lglg / (-2.0 *  PSI  *  PSI ));
}

vec4 softSkin(vec4 originalColor, float factor) {
    vec4 screenColor = originalColor;
    float intensity = getLuminance(screenColor);
    float summ = 1.0;
    
    mat4 nextColor;
    nextColor[0] = BNB_TEXTURE_2D(BNB_SAMPLER_2D(glfx_BACKGROUND), sp0.xy);
    nextColor[1] = BNB_TEXTURE_2D(BNB_SAMPLER_2D(glfx_BACKGROUND), sp1.xy);
    nextColor[2] = BNB_TEXTURE_2D(BNB_SAMPLER_2D(glfx_BACKGROUND), sp2.xy);
    nextColor[3] = BNB_TEXTURE_2D(BNB_SAMPLER_2D(glfx_BACKGROUND), sp3.xy);
    vec4 nextIntensity = getLuminance4(nextColor);
    vec4 curr = 0.367 * getWeight(intensity, nextIntensity);
    summ += dot(curr, vec4(1.0));
    screenColor += nextColor * curr;
    screenColor = screenColor / summ;
    
    screenColor = mix(originalColor, screenColor, factor);
    return screenColor;
}


BNB_DECLARE_SAMPLER_2D(6, 7, tex_makeup2);

void main()
{
    vec4 maskColor = BNB_TEXTURE_2D(BNB_SAMPLER_2D(selection_tex), var_uv);
    vec4 res = BNB_TEXTURE_2D(BNB_SAMPLER_2D(glfx_BACKGROUND), var_bg_uv );
    
#ifdef SOFT_SKIN
    res = softSkin(res, maskColor.r * skinSoftIntensity);
#endif
    
#ifdef SKIN_TEXTURING
    vec4 skinTexture = texture(skin_tex, var_uv);
    vec4 diff = abs(skinTexture - res);
    res = mix(res, diff, skinTexturingIntensity);
#endif
    
#ifdef SHARPEN_TEETH
    res = sharpen(res, maskColor.g * teethSharpenIntensity);
#endif
    
#if defined(TEETH_WHITENING)
    res = whitening(res, maskColor.g * teethWhiteningCoeff, BNB_PASS_SAMPLER_ARGUMENT(lookupTexTeeth));
#endif
    
    
#ifdef SHARPEN_EYES
    res = sharpen(res, maskColor.b * eyesSharpenIntensity);
#endif
    
#if defined(EYES_WHITENING)
    res = whitening(res, maskColor.b * eyesWhiteningCoeff, BNB_PASS_SAMPLER_ARGUMENT(lookupTexEyes));
#endif
    
#if defined(EYES_HIGHLIGHT)
    res = res + vec4( BNB_TEXTURE_2D(BNB_SAMPLER_2D(tex_highlight), var_uv ).xyz, 0. );
#endif

    vec2 uvh = var_uv;
    uvh.x = abs(2.0 * (uvh.x - 0.5));

    vec4 makeup2 = BNB_TEXTURE_2D(BNB_SAMPLER_2D(tex_makeup2), uvh );
    res.xyz = mix( res.xyz, makeup2.xyz, makeup2.w );
    bnb_FragColor = vec4(res.xyz, 1.);
}
