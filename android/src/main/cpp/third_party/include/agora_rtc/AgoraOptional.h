// Copyright (c) 2019 Agora.io. All rights reserved

// This program is confidential and proprietary to Agora.io.
// And may not be copied, reproduced, modified, disclosed to others, published
// or used, in whole or in part, without the express prior written permission
// of Agora.io.
#pragma once

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
#include <type_traits>
#endif
#include <utility>

#ifndef CONSTEXPR
#if __cplusplus >= 201103L || (defined(_MSVC_LANG) && _MSVC_LANG >= 201103L)
#define CONSTEXPR constexpr
#else
#define CONSTEXPR
#endif
#endif  // !CONSTEXPR

#ifndef NOEXCEPT
#if __cplusplus >= 201103L || (defined(_MSVC_LANG) && _MSVC_LANG >= 201103L)
#define NOEXCEPT(Expr) noexcept(Expr)
#else
#define NOEXCEPT(Expr)
#endif
#endif  // !NOEXCEPT

namespace agora {

// Specification:
// http://en.cppreference.com/w/cpp/utility/optional/in_place_t
struct in_place_t {};

// Specification:
// http://en.cppreference.com/w/cpp/utility/optional/nullopt_t
struct nullopt_t {
  CONSTEXPR explicit nullopt_t(int) {}
};

// Specification:
// http://en.cppreference.com/w/cpp/utility/optional/in_place
/*CONSTEXPR*/ const in_place_t in_place = {};

// Specification:
// http://en.cppreference.com/w/cpp/utility/optional/nullopt
/*CONSTEXPR*/ const nullopt_t nullopt(0);

// Forward declaration, which is refered by following helpers.
template <typename T>
class Optional;

namespace internal {

template <typename T>
struct OptionalStorageBase {
  // Initializing |empty_| here instead of using default member initializing
  // to avoid errors in g++ 4.8.
  CONSTEXPR OptionalStorageBase() : is_populated_(false), empty_('\0') {}

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  template <class... Args>
  CONSTEXPR explicit OptionalStorageBase(in_place_t, Args&&... args)
      : is_populated_(true), value_(std::forward<Args>(args)...) {}
#else
  CONSTEXPR explicit OptionalStorageBase(in_place_t, const T& _value)
      : is_populated_(true), value_(_value) {}
#endif
  // When T is not trivially destructible we must call its
  // destructor before deallocating its memory.
  // Note that this hides the (implicitly declared) move constructor, which
  // would be used for constexpr move constructor in OptionalStorage<T>.
  // It is needed iff T is trivially move constructible. However, the current
  // is_trivially_{copy,move}_constructible implementation requires
  // is_trivially_destructible (which looks a bug, cf:
  // https://gcc.gnu.org/bugzilla/show_bug.cgi?id=51452 and
  // http://cplusplus.github.io/LWG/lwg-active.html#2116), so it is not
  // necessary for this case at the moment. Please see also the destructor
  // comment in "is_trivially_destructible = true" specialization below.
  ~OptionalStorageBase() {
    if (is_populated_)
      value_.~T();
  }

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  template <class... Args>
  void Init(Args&&... args) {
    ::new (&value_) T(std::forward<Args>(args)...);
    is_populated_ = true;
  }
#else
  void Init(const T& _value) {
    ::new (&value_) T(_value);
    is_populated_ = true;
  }
#endif

  bool is_populated_;

  union {
    // |empty_| exists so that the union will always be initialized, even when
    // it doesn't contain a value. Union members must be initialized for the
    // constructor to be 'constexpr'.
    char empty_;
    T value_;
  };
};

// Implement conditional constexpr copy and move constructors. These are
// constexpr if is_trivially_{copy,move}_constructible<T>::value is true
// respectively. If each is true, the corresponding constructor is defined as
// "= default;", which generates a constexpr constructor (In this case,
// the condition of constexpr-ness is satisfied because the base class also has
// compiler generated constexpr {copy,move} constructors). Note that
// placement-new is prohibited in constexpr.
template <typename T>
struct OptionalStorage : OptionalStorageBase<T> {
  // This is no trivially {copy,move} constructible case. Other cases are
  // defined below as specializations.

  // Accessing the members of template base class requires explicit
  // declaration.
  using OptionalStorageBase<T>::is_populated_;
  using OptionalStorageBase<T>::value_;
  using OptionalStorageBase<T>::Init;

  // Inherit constructors (specifically, the in_place constructor).
  //using OptionalStorageBase<T>::OptionalStorageBase;

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  template <class... Args>
  CONSTEXPR explicit OptionalStorage(in_place_t in_place, Args&&... args)
      : OptionalStorageBase<T>(in_place, std::forward<Args>(args)...) {}
#else
  CONSTEXPR explicit OptionalStorage(in_place_t in_place, const T& _value)
      : OptionalStorageBase<T>(in_place, _value) {}
#endif

  // User defined constructor deletes the default constructor.
  // Define it explicitly.
  OptionalStorage() {}

  OptionalStorage(const OptionalStorage& other) {
    if (other.is_populated_)
      Init(other.value_);
  }

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  OptionalStorage(OptionalStorage&& other) NOEXCEPT(std::is_nothrow_move_constructible<T>::value) {
    if (other.is_populated_)
      Init(std::move(other.value_));
  }
#endif
};

// Base class to support conditionally usable copy-/move- constructors
// and assign operators.
template <typename T>
class OptionalBase {
  // This class provides implementation rather than public API, so everything
  // should be hidden. Often we use composition, but we cannot in this case
  // because of C++ language restriction.
 protected:
  CONSTEXPR OptionalBase() {}
  CONSTEXPR OptionalBase(const OptionalBase& other) : storage_(other.storage_) {}
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  CONSTEXPR OptionalBase(OptionalBase&& other) : storage_(std::move(other.storage_)) {}

  template <class... Args>
  CONSTEXPR explicit OptionalBase(in_place_t, Args&&... args)
      : storage_(in_place, std::forward<Args>(args)...) {}
#else
  CONSTEXPR explicit OptionalBase(in_place_t, const T& _value)
      : storage_(in_place, _value) {}
#endif

  // Implementation of converting constructors.
  template <typename U>
  explicit OptionalBase(const OptionalBase<U>& other) {
    if (other.storage_.is_populated_)
      storage_.Init(other.storage_.value_);
  }

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  template <typename U>
  explicit OptionalBase(OptionalBase<U>&& other) {
    if (other.storage_.is_populated_)
      storage_.Init(std::move(other.storage_.value_));
  }
#endif

  ~OptionalBase() {}

  OptionalBase& operator=(const OptionalBase& other) {
    CopyAssign(other);
    return *this;
  }

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  OptionalBase& operator=(OptionalBase&& other) NOEXCEPT(
      std::is_nothrow_move_assignable<T>::value &&
          std::is_nothrow_move_constructible<T>::value) {
    MoveAssign(std::move(other));
    return *this;
  }
#endif

  template <typename U>
  void CopyAssign(const OptionalBase<U>& other) {
    if (other.storage_.is_populated_)
      InitOrAssign(other.storage_.value_);
    else
      FreeIfNeeded();
  }

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  template <typename U>
  void MoveAssign(OptionalBase<U>&& other) {
    if (other.storage_.is_populated_)
      InitOrAssign(std::move(other.storage_.value_));
    else
      FreeIfNeeded();
  }
#endif

  template <typename U>
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  void InitOrAssign(U&& value) {
    if (storage_.is_populated_)
      storage_.value_ = std::forward<U>(value);
    else
      storage_.Init(std::forward<U>(value));
  }
#else
  void InitOrAssign(const U& value) {
    if (storage_.is_populated_)
      storage_.value_ = value;
    else
      storage_.Init(value);
  }
#endif


  void FreeIfNeeded() {
    if (!storage_.is_populated_)
      return;
    storage_.value_.~T();
    storage_.is_populated_ = false;
  }

  // For implementing conversion, allow access to other typed OptionalBase
  // class.
  template <typename U>
  friend class OptionalBase;

  OptionalStorage<T> storage_;
};

// The following {Copy,Move}{Constructible,Assignable} structs are helpers to
// implement constructor/assign-operator overloading. Specifically, if T is
// is not movable but copyable, Optional<T>'s move constructor should not
// participate in overload resolution. This inheritance trick implements that.
template <bool is_copy_constructible>
struct CopyConstructible {};

template <>
struct CopyConstructible<false> {
  CONSTEXPR CopyConstructible() {}
  CopyConstructible& operator=(const CopyConstructible&) { return *this; }
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  CONSTEXPR CopyConstructible(CopyConstructible&&) {}
  CopyConstructible& operator=(CopyConstructible&&) { return *this; }
#endif
 private:
  CONSTEXPR CopyConstructible(const CopyConstructible&);
};

template <bool is_move_constructible>
struct MoveConstructible {};

template <>
struct MoveConstructible<false> {
  CONSTEXPR MoveConstructible() {}
  CONSTEXPR MoveConstructible(const MoveConstructible&) {}
  MoveConstructible& operator=(const MoveConstructible&) { return *this; }
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  MoveConstructible& operator=(MoveConstructible&&) { return *this; }
 private:
  CONSTEXPR MoveConstructible(MoveConstructible&&);
#endif
};

template <bool is_copy_assignable>
struct CopyAssignable {};

template <>
struct CopyAssignable<false> {
  CONSTEXPR CopyAssignable() {}
  CONSTEXPR CopyAssignable(const CopyAssignable&) {}
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  CONSTEXPR CopyAssignable(CopyAssignable&&) {}
  CopyAssignable& operator=(CopyAssignable&&) { return *this; }
#endif
 private:
  CopyAssignable& operator=(const CopyAssignable&);
};

template <bool is_move_assignable>
struct MoveAssignable {};

template <>
struct MoveAssignable<false> {
  CONSTEXPR MoveAssignable() {}
  CONSTEXPR MoveAssignable(const MoveAssignable&) {}
  MoveAssignable& operator=(const MoveAssignable&) { return *this; }
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  CONSTEXPR MoveAssignable(MoveAssignable&&) {}

 private:
  MoveAssignable& operator=(MoveAssignable&&);
#endif
};

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
// Helper to conditionally enable converting constructors and assign operators.
template <typename T, typename U>
struct IsConvertibleFromOptional
    : std::integral_constant<
          bool,
          std::is_constructible<T, Optional<U>&>::value ||
              std::is_constructible<T, const Optional<U>&>::value ||
              std::is_constructible<T, Optional<U>&&>::value ||
              std::is_constructible<T, const Optional<U>&&>::value ||
              std::is_convertible<Optional<U>&, T>::value ||
              std::is_convertible<const Optional<U>&, T>::value ||
              std::is_convertible<Optional<U>&&, T>::value ||
              std::is_convertible<const Optional<U>&&, T>::value> {};

template <typename T, typename U>
struct IsAssignableFromOptional
    : std::integral_constant<
          bool,
          IsConvertibleFromOptional<T, U>::value ||
              std::is_assignable<T&, Optional<U>&>::value ||
              std::is_assignable<T&, const Optional<U>&>::value ||
              std::is_assignable<T&, Optional<U>&&>::value ||
              std::is_assignable<T&, const Optional<U>&&>::value> {};

// Forward compatibility for C++17.
// Introduce one more deeper nested namespace to avoid leaking using std::swap.
namespace swappable_impl {
using std::swap;

struct IsSwappableImpl {
  // Tests if swap can be called. Check<T&>(0) returns true_type iff swap
  // is available for T. Otherwise, Check's overload resolution falls back
  // to Check(...) declared below thanks to SFINAE, so returns false_type.
  template <typename T>
  static auto Check(int)
      -> decltype(swap(std::declval<T>(), std::declval<T>()), std::true_type());

  template <typename T>
  static std::false_type Check(...);
};
}  // namespace swappable_impl
template <typename T>
struct IsSwappable : decltype(swappable_impl::IsSwappableImpl::Check<T&>(0)) {};
#endif
}  // namespace internal

// On Windows, by default, empty-base class optimization does not work,
// which means even if the base class is empty struct, it still consumes one
// byte for its body. __declspec(empty_bases) enables the optimization.
// cf)
// https://blogs.msdn.microsoft.com/vcblog/2016/03/30/optimizing-the-layout-of-empty-base-classes-in-vs2015-update-2-3/
#if defined(_WIN32)
#define OPTIONAL_DECLSPEC_EMPTY_BASES __declspec(empty_bases)
#else
#define OPTIONAL_DECLSPEC_EMPTY_BASES
#endif

// Optional is a Chromium version of the C++17 optional class:
// std::optional documentation:
// http://en.cppreference.com/w/cpp/utility/optional
// Chromium documentation:
// https://chromium.googlesource.com/chromium/src/+/master/docs/optional.md
//
// These are the differences between the specification and the implementation:
// - Constructors do not use 'constexpr' as it is a C++14 extension.
// - 'constexpr' might be missing in some places for reasons specified locally.
// - No exceptions are thrown, because they are banned from Chromium.
//   Marked noexcept for only move constructor and move assign operators.
// - All the non-members are in the 'base' namespace instead of 'std'.
//
// Note that T cannot have a constructor T(Optional<T>) etc. Optional<T> checks
// T's constructor (specifically via IsConvertibleFromOptional), and in the
// check whether T can be constructible from Optional<T>, which is recursive
// so it does not work. As of Feb 2018, std::optional C++17 implementation in
// both clang and gcc has same limitation. MSVC SFINAE looks to have different
// behavior, but anyway it reports an error, too.
template <typename T>
class OPTIONAL_DECLSPEC_EMPTY_BASES Optional
    : public internal::OptionalBase<T>
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
      , public internal::CopyConstructible<std::is_copy_constructible<T>::value>,
      public internal::MoveConstructible<std::is_move_constructible<T>::value>,
      public internal::CopyAssignable<std::is_copy_constructible<T>::value &&
                                      std::is_copy_assignable<T>::value>,
      public internal::MoveAssignable<std::is_move_constructible<T>::value &&
                                      std::is_move_assignable<T>::value> 
#endif
{
 public:
#undef OPTIONAL_DECLSPEC_EMPTY_BASES

  typedef T value_type;

  // Defer default/copy/move constructor implementation to OptionalBase.
  CONSTEXPR Optional() {}
  CONSTEXPR Optional(const Optional& other) : internal::OptionalBase<T>(other) {}

  CONSTEXPR Optional(nullopt_t) {}  // NOLINT(runtime/explicit)

  // Converting copy constructor. "explicit" only if
  // std::is_convertible<const U&, T>::value is false. It is implemented by
  // declaring two almost same constructors, but that condition in enable_if_t
  // is different, so that either one is chosen, thanks to SFINAE.
  template <typename U>
  Optional(const Optional<U>& other) : internal::OptionalBase<T>(other) {}

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  // Converting move constructor. Similar to converting copy constructor,
  // declaring two (explicit and non-explicit) constructors.
  template <typename U>
  Optional(Optional<U>&& other) : internal::OptionalBase<T>(std::move(other)) {}

  template <class... Args>
  CONSTEXPR explicit Optional(in_place_t, Args&&... args)
      : internal::OptionalBase<T>(in_place, std::forward<Args>(args)...) {}

  template <class U, class... Args>
  CONSTEXPR explicit Optional(in_place_t,
                              std::initializer_list<U> il,
                              Args&&... args)
      : internal::OptionalBase<T>(in_place, il, std::forward<Args>(args)...) {}
#else
  CONSTEXPR explicit Optional(in_place_t, const T& _value)
      : internal::OptionalBase<T>(in_place, _value) {}
  template <class U>
  CONSTEXPR explicit Optional(in_place_t,
                              const U il[],
                              const T& _value)
      : internal::OptionalBase<T>(in_place, il, _value) {}
#endif

  // Forward value constructor. Similar to converting constructors,
  // conditionally explicit.
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  template <typename U = value_type>
  CONSTEXPR Optional(U&& value)
      : internal::OptionalBase<T>(in_place, std::forward<U>(value)) {}
#else
  template <typename U>
  CONSTEXPR Optional(const U& value)
      : internal::OptionalBase<T>(in_place, value) {}
#endif

  ~Optional() {}

  // Defer copy-/move- assign operator implementation to OptionalBase.
  Optional& operator=(const Optional& other) {
    if (&other  == this) {
      return *this;
    }

    internal::OptionalBase<T>::operator=(other);
    return *this;
  }

  Optional& operator=(nullopt_t) {
    FreeIfNeeded();
    return *this;
  }

  // Perfect-forwarded assignment.
  template <typename U>
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  Optional& operator=(U&& value) {
    InitOrAssign(std::forward<U>(value));
    return *this;
  }
#else
  Optional& operator=(const U& value) {
    InitOrAssign(value);
    return *this;
  }
#endif

  // Copy assign the state of other.
  template <typename U>
  Optional& operator=(const Optional<U>& other) {
    CopyAssign(other);
    return *this;
  }

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  // Move assign the state of other.
  template <typename U>
  Optional& operator=(Optional<U>&& other) {
    MoveAssign(std::move(other));
    return *this;
  }
#endif

  const T* operator->() const {
    return &storage_.value_;
  }

  T* operator->() {
    return &storage_.value_;
  }

  const T& operator*() const {
    return storage_.value_;
  }

  T& operator*() {
    return storage_.value_;
  }


#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  CONSTEXPR explicit operator bool() const { return storage_.is_populated_; }
#else
  CONSTEXPR operator bool() const { return storage_.is_populated_; }
#endif

  CONSTEXPR bool has_value() const { return storage_.is_populated_; }

#if 1
  const T& value() const {
    return storage_.value_;
  }

  template <class U>
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  CONSTEXPR T value_or(U&& default_value) const {
    // TODO(mlamouri): add the following assert when possible:
    // static_assert(std::is_copy_constructible<T>::value,
    //               "T must be copy constructible");
    static_assert(std::is_convertible<U, T>::value,
                  "U must be convertible to T");
    return storage_.is_populated_
               ? value()
               : static_cast<T>(std::forward<U>(default_value));
  }
#else
  CONSTEXPR T value_or(const U& default_value) const {
    return storage_.is_populated_
               ? value()
               : static_cast<T>(default_value);
  }
#endif
#else
  const T& value() const & {
    return storage_.value_;
  }

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  const T&& value() const && {
    return std::move(storage_.value_);
  }
#endif

  template <class U>
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  CONSTEXPR T value_or(U&& default_value) const & {
    // TODO(mlamouri): add the following assert when possible:
    // static_assert(std::is_copy_constructible<T>::value,
    //               "T must be copy constructible");
    static_assert(std::is_convertible<U, T>::value,
                  "U must be convertible to T");
    return storage_.is_populated_
               ? value()
               : static_cast<T>(std::forward<U>(default_value));
  }
#else
  CONSTEXPR T value_or(const U& default_value) const & {
    // TODO(mlamouri): add the following assert when possible:
    // static_assert(std::is_copy_constructible<T>::value,
    //               "T must be copy constructible");
    static_assert(std::is_convertible<U, T>::value,
                  "U must be convertible to T");
    return storage_.is_populated_
               ? value()
               : static_cast<T>(default_value);
  }
#endif

  template <class U>
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  CONSTEXPR T value_or(U&& default_value) const && {
    // TODO(mlamouri): add the following assert when possible:
    // static_assert(std::is_move_constructible<T>::value,
    //               "T must be move constructible");
    static_assert(std::is_convertible<U, T>::value,
                  "U must be convertible to T");
    return storage_.is_populated_
               ? std::move(value())
               : static_cast<T>(std::forward<U>(default_value));
  }
#endif
#endif  // 1

  void swap(Optional& other) {
    if (!storage_.is_populated_ && !other.storage_.is_populated_)
      return;

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
    if (storage_.is_populated_ != other.storage_.is_populated_) {
      if (storage_.is_populated_) {
        other.storage_.Init(std::move(storage_.value_));
        FreeIfNeeded();
      } else {
        storage_.Init(std::move(other.storage_.value_));
        other.FreeIfNeeded();
      }
      return;
    }
#endif
    using std::swap;
    swap(**this, *other);
  }

  void reset() { FreeIfNeeded(); }

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  template <class... Args>
  T& emplace(Args&&... args) {
    FreeIfNeeded();
    storage_.Init(std::forward<Args>(args)...);
    return storage_.value_;
  }

  template <class U, class... Args>
  T& emplace(std::initializer_list<U> il, Args&&... args) {
    FreeIfNeeded();
    storage_.Init(il, std::forward<Args>(args)...);
    return storage_.value_;
  }
#else
  T& emplace(const T& _value) {
    FreeIfNeeded();
    storage_.Init(_value);
    return storage_.value_;
  }
  template <class U>
  T& emplace(const U il[], const T& _value) {
    FreeIfNeeded();
    storage_.Init(il, _value);
    return storage_.value_;
  }
#endif

 private:
  // Accessing template base class's protected member needs explicit
  // declaration to do so.
  using internal::OptionalBase<T>::CopyAssign;
  using internal::OptionalBase<T>::FreeIfNeeded;
  using internal::OptionalBase<T>::InitOrAssign;
#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
  using internal::OptionalBase<T>::MoveAssign;
#endif
  using internal::OptionalBase<T>::storage_;
};

// Here after defines comparation operators. The definition follows
// http://en.cppreference.com/w/cpp/utility/optional/operator_cmp
// while bool() casting is replaced by has_value() to meet the chromium
// style guide.
template <class T, class U>
bool operator==(const Optional<T>& lhs, const Optional<U>& rhs) {
  if (lhs.has_value() != rhs.has_value())
    return false;
  if (!lhs.has_value())
    return true;
  return *lhs == *rhs;
}

template <class T, class U>
bool operator!=(const Optional<T>& lhs, const Optional<U>& rhs) {
  if (lhs.has_value() != rhs.has_value())
    return true;
  if (!lhs.has_value())
    return false;
  return *lhs != *rhs;
}

template <class T, class U>
bool operator<(const Optional<T>& lhs, const Optional<U>& rhs) {
  if (!rhs.has_value())
    return false;
  if (!lhs.has_value())
    return true;
  return *lhs < *rhs;
}

template <class T, class U>
bool operator<=(const Optional<T>& lhs, const Optional<U>& rhs) {
  if (!lhs.has_value())
    return true;
  if (!rhs.has_value())
    return false;
  return *lhs <= *rhs;
}

template <class T, class U>
bool operator>(const Optional<T>& lhs, const Optional<U>& rhs) {
  if (!lhs.has_value())
    return false;
  if (!rhs.has_value())
    return true;
  return *lhs > *rhs;
}

template <class T, class U>
bool operator>=(const Optional<T>& lhs, const Optional<U>& rhs) {
  if (!rhs.has_value())
    return true;
  if (!lhs.has_value())
    return false;
  return *lhs >= *rhs;
}

template <class T>
CONSTEXPR bool operator==(const Optional<T>& opt, nullopt_t) {
  return !opt;
}

template <class T>
CONSTEXPR bool operator==(nullopt_t, const Optional<T>& opt) {
  return !opt;
}

template <class T>
CONSTEXPR bool operator!=(const Optional<T>& opt, nullopt_t) {
  return opt.has_value();
}

template <class T>
CONSTEXPR bool operator!=(nullopt_t, const Optional<T>& opt) {
  return opt.has_value();
}

template <class T>
CONSTEXPR bool operator<(const Optional<T>& , nullopt_t) {
  return false;
}

template <class T>
CONSTEXPR bool operator<(nullopt_t, const Optional<T>& opt) {
  return opt.has_value();
}

template <class T>
CONSTEXPR bool operator<=(const Optional<T>& opt, nullopt_t) {
  return !opt;
}

template <class T>
CONSTEXPR bool operator<=(nullopt_t, const Optional<T>& ) {
  return true;
}

template <class T>
CONSTEXPR bool operator>(const Optional<T>& opt, nullopt_t) {
  return opt.has_value();
}

template <class T>
CONSTEXPR bool operator>(nullopt_t, const Optional<T>& ) {
  return false;
}

template <class T>
CONSTEXPR bool operator>=(const Optional<T>& , nullopt_t) {
  return true;
}

template <class T>
CONSTEXPR bool operator>=(nullopt_t, const Optional<T>& opt) {
  return !opt;
}

template <class T, class U>
CONSTEXPR bool operator==(const Optional<T>& opt, const U& value) {
  return opt.has_value() ? *opt == value : false;
}

template <class T, class U>
CONSTEXPR bool operator==(const U& value, const Optional<T>& opt) {
  return opt.has_value() ? value == *opt : false;
}

template <class T, class U>
CONSTEXPR bool operator!=(const Optional<T>& opt, const U& value) {
  return opt.has_value() ? *opt != value : true;
}

template <class T, class U>
CONSTEXPR bool operator!=(const U& value, const Optional<T>& opt) {
  return opt.has_value() ? value != *opt : true;
}

template <class T, class U>
CONSTEXPR bool operator<(const Optional<T>& opt, const U& value) {
  return opt.has_value() ? *opt < value : true;
}

template <class T, class U>
CONSTEXPR bool operator<(const U& value, const Optional<T>& opt) {
  return opt.has_value() ? value < *opt : false;
}

template <class T, class U>
CONSTEXPR bool operator<=(const Optional<T>& opt, const U& value) {
  return opt.has_value() ? *opt <= value : true;
}

template <class T, class U>
CONSTEXPR bool operator<=(const U& value, const Optional<T>& opt) {
  return opt.has_value() ? value <= *opt : false;
}

template <class T, class U>
CONSTEXPR bool operator>(const Optional<T>& opt, const U& value) {
  return opt.has_value() ? *opt > value : false;
}

template <class T, class U>
CONSTEXPR bool operator>(const U& value, const Optional<T>& opt) {
  return opt.has_value() ? value > *opt : true;
}

template <class T, class U>
CONSTEXPR bool operator>=(const Optional<T>& opt, const U& value) {
  return opt.has_value() ? *opt >= value : false;
}

template <class T, class U>
CONSTEXPR bool operator>=(const U& value, const Optional<T>& opt) {
  return opt.has_value() ? value >= *opt : true;
}

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
template <class T, class... Args>
CONSTEXPR Optional<T> make_optional(Args&&... args) {
  return Optional<T>(in_place, std::forward<Args>(args)...);
}

template <class T, class U, class... Args>
CONSTEXPR Optional<T> make_optional(std::initializer_list<U> il,
                                    Args&&... args) {
  return Optional<T>(in_place, il, std::forward<Args>(args)...);
}
#endif

// Partial specialization for a function template is not allowed. Also, it is
// not allowed to add overload function to std namespace, while it is allowed
// to specialize the template in std. Thus, swap() (kind of) overloading is
// defined in base namespace, instead.
template <class T>
void swap(Optional<T>& lhs, Optional<T>& rhs) {
  lhs.swap(rhs);
}

}  // namespace agora

#if __cplusplus >= 201103L || (defined(_MSC_VER) && _MSC_VER >= 1800)
namespace std {
template <class T>
struct hash<agora::Optional<T> > {
  size_t operator()(const agora::Optional<T>& opt) const {
    return opt == agora::nullopt ? 0 : std::hash<T>()(*opt);
  }
};
}  // namespace std
#endif
#undef CONSTEXPR
#undef NOEXCEPT
