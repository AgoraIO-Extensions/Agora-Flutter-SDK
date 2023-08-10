#ifndef VM_UTIL_H_
#define VM_UTIL_H_

#include <cassert>
#include <jni.h>

namespace iris
{
  class AttachThreadScoped
  {
  public:
    explicit AttachThreadScoped(JavaVM *jvm)
        : attached_(false), jvm_(jvm), env_(nullptr)
    {
      jint ret_val =
          jvm->GetEnv(reinterpret_cast<void **>(&env_), JNI_VERSION_1_6);
      if (ret_val == JNI_EDETACHED)
      {
        // Attach the thread to the Java VM.
        ret_val = jvm_->AttachCurrentThread(&env_, nullptr);
        attached_ = ret_val >= 0;
        assert(attached_);
      }
    }

    ~AttachThreadScoped()
    {
      if (attached_ && (jvm_->DetachCurrentThread() < 0))
      {
        assert(false);
      }
    }

    JNIEnv *env() { return env_; }

  private:
    bool attached_;
    JavaVM *jvm_;
    JNIEnv *env_;
  };
} // namespace iris

#endif // VM_UTIL_H_
