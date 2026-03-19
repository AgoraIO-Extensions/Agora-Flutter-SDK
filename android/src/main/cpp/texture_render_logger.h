#pragma once

#include <cstdio>
#include <cstdarg>
#include <ctime>
#include <pthread.h>
#include <sys/time.h>
#include <string>

/**
 * Lightweight file logger for Android native texture rendering.
 * Writes to the same flutter_texture_render.log file as Java/Dart sides.
 * Disabled by default — zero overhead when off.
 */
class TextureRenderLoggerAndroid {
public:
  static void Enable(const char *logDir) {
    pthread_mutex_lock(&mutex_);
    CloseFileLocked();
    std::string path = std::string(logDir) + "/flutter_texture_render.log";
    log_file_ = fopen(path.c_str(), "a");
    if (log_file_) {
      enabled_ = true;
    }
    pthread_mutex_unlock(&mutex_);
  }

  static void Disable() {
    pthread_mutex_lock(&mutex_);
    CloseFileLocked();
    pthread_mutex_unlock(&mutex_);
  }

  static bool IsEnabled() { return enabled_; }

  static void Log(const char *tag, const char *fmt, ...) {
    if (!enabled_) return;

    va_list args;
    va_start(args, fmt);
    char buf[1024];
    vsnprintf(buf, sizeof(buf), fmt, args);
    va_end(args);

    pthread_mutex_lock(&mutex_);
    if (log_file_) {
      struct timeval tv;
      gettimeofday(&tv, nullptr);
      struct tm tm_info;
      localtime_r(&tv.tv_sec, &tm_info);
      fprintf(log_file_,
              "%04d-%02d-%02dT%02d:%02d:%02d.%03d [Native][%s] %s\n",
              tm_info.tm_year + 1900, tm_info.tm_mon + 1, tm_info.tm_mday,
              tm_info.tm_hour, tm_info.tm_min, tm_info.tm_sec,
              (int)(tv.tv_usec / 1000), tag, buf);
      fflush(log_file_);
    }
    pthread_mutex_unlock(&mutex_);
  }

private:
  static void CloseFileLocked() {
    if (log_file_) {
      fflush(log_file_);
      fclose(log_file_);
      log_file_ = nullptr;
    }
    enabled_ = false;
  }

  static FILE *log_file_;
  static bool enabled_;
  static pthread_mutex_t mutex_;
};

// Static member definitions — use a single compilation unit approach
// to avoid C++17 inline variable requirement
#ifdef TEXTURE_RENDER_LOGGER_IMPL
FILE *TextureRenderLoggerAndroid::log_file_ = nullptr;
bool TextureRenderLoggerAndroid::enabled_ = false;
pthread_mutex_t TextureRenderLoggerAndroid::mutex_ = PTHREAD_MUTEX_INITIALIZER;
#endif
