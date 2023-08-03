#ifndef __IRIS_QUEUE_H__
#define __IRIS_QUEUE_H__

#include <assert.h>
#include <mutex>
#include <vector>

template<class T>
class QueueBase {
 public:
  QueueBase() : max_size_(0) {}

  bool add(T *obj) {
    std::lock_guard<std::mutex> lock(mutex_);
    assert(obj != nullptr);
    if (max_size_ != 0 && objects_.size() >= max_size_) { return false; }
    objects_.emplace_back(obj);
    return true;
  }

  bool addUnique(T *obj) {
    std::lock_guard<std::mutex> lock(mutex_);
    assert(obj != nullptr);
    if (max_size_ != 0 && objects_.size() >= max_size_) { return false; }

    for (auto it = objects_.begin(); it != objects_.end(); it++) {
      if (obj == (*it)) { return false; }
    }

    objects_.emplace_back(obj);
    return true;
  }

  bool remove(T *obj) {
    std::lock_guard<std::mutex> lock(mutex_);
    assert(obj != nullptr);
    for (auto it = objects_.begin(); it != objects_.end(); it++) {
      if (obj == (*it)) {
        objects_.erase(it);
        return true;
      }
    }
    return false;
  }

  int count() { return objects_.size(); }

  void set_maxsize(size_t maxsize) { max_size_ = maxsize; }

  T *get(int i) {
    if (objects_.size() > 0) return objects_[i];
    else
      return nullptr;
  }

  void clear() {
    std::lock_guard<std::mutex> lock(mutex_);
    objects_.clear();
  }

 public:
  std::mutex mutex_;

 private:
  std::vector<T *> objects_;
  size_t max_size_;
};

#endif