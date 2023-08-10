
// Copyright (c) 2019 Agora.io. All rights reserved

// This program is confidential and proprietary to Agora.io.
// And may not be copied, reproduced, modified, disclosed to others, published
// or used, in whole or in part, without the express prior written permission
// of Agora.io.

#pragma once

#include <memory>
#if !(__cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800))
#include <cstddef>
#endif
#ifndef OPTIONAL_ENUM_CLASS
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
#define OPTIONAL_ENUM_CLASS enum class
#else
#define OPTIONAL_ENUM_CLASS enum
#endif
#endif

namespace agora {

OPTIONAL_ENUM_CLASS RefCountReleaseStatus { kDroppedLastRef, kOtherRefsRemained };

// Interfaces where refcounting is part of the public api should
// inherit this abstract interface. The implementation of these
// methods is usually provided by the RefCountedObject template class,
// applied as a leaf in the inheritance tree.
class RefCountInterface {
 public:
  virtual void AddRef() const = 0;
  virtual RefCountReleaseStatus Release() const = 0;
  virtual bool HasOneRef() const = 0;

  // Non-public destructor, because Release() has exclusive responsibility for
  // destroying the object.
 protected:
  virtual ~RefCountInterface() {}
};

template <class T>
class agora_refptr {
 public:
  agora_refptr() : ptr_(NULL) {}

  agora_refptr(T* p) : ptr_(p) {
    if (ptr_) ptr_->AddRef();
  }

  template<typename U>
  agora_refptr(U* p) : ptr_(p) {
    if (ptr_) ptr_->AddRef();
  }

  agora_refptr(const agora_refptr<T>& r) : ptr_(r.get()) {
    if (ptr_) ptr_->AddRef();
  }

  template <typename U>
  agora_refptr(const agora_refptr<U>& r) : ptr_(r.get()) {
    if (ptr_) ptr_->AddRef();
  }

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  agora_refptr(agora_refptr<T>&& r) : ptr_(r.move()) {}

  template <typename U>
  agora_refptr(agora_refptr<U>&& r) : ptr_(r.move()) {}
#endif

  ~agora_refptr() {
    reset();
  }

  T* get() const { return ptr_; }
  operator bool() const { return (ptr_ != NULL); }

  T* operator->() const { return  ptr_; }
  T& operator*() const { return *ptr_; }

  // Returns the (possibly null) raw pointer, and makes the agora_refptr hold a
  // null pointer, all without touching the reference count of the underlying
  // pointed-to object. The object is still reference counted, and the caller of
  // move() is now the proud owner of one reference, so it is responsible for
  // calling Release() once on the object when no longer using it.
  T* move() {
    T* retVal = ptr_;
    ptr_ = NULL;
    return retVal;
  }

  agora_refptr<T>& operator=(T* p) {
    if (ptr_ == p) return *this;

    if (p) p->AddRef();
    if (ptr_) ptr_->Release();
    ptr_ = p;
    return *this;
  }

  agora_refptr<T>& operator=(const agora_refptr<T>& r) {
    return *this = r.get();
  }

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  agora_refptr<T>& operator=(agora_refptr<T>&& r) {
    agora_refptr<T>(std::move(r)).swap(*this);
    return *this;
  }

  template <typename U>
  agora_refptr<T>& operator=(agora_refptr<U>&& r) {
    agora_refptr<T>(std::move(r)).swap(*this);
    return *this;
  }
#endif

  // For working with std::find()
  bool operator==(const agora_refptr<T>& r) const { return ptr_ == r.ptr_; }

  // For working with std::set
  bool operator<(const agora_refptr<T>& r) const { return ptr_ < r.ptr_; }

  void swap(T** pp) {
    T* p = ptr_;
    ptr_ = *pp;
    *pp = p;
  }

  void swap(agora_refptr<T>& r) { swap(&r.ptr_); }

  void reset() {
    if (ptr_) {
      ptr_->Release();
      ptr_ = NULL;
    }
  }

 protected:
  T* ptr_;
};

}  // namespace agora

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
namespace std {
template <typename T>
struct hash<agora::agora_refptr<T>> {
  std::size_t operator()(const agora::agora_refptr<T>& k) const {
    return reinterpret_cast<size_t>(k.get());
  }
};
}  // namespace std
#endif