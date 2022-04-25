// ignore_for_file: unused_element

library data_state;

import 'package:flutter/material.dart' show SizedBox, Widget;
import 'package:mobx/mobx.dart';

part 'data_state.g.dart';

typedef _SuccessStateCallback<T> = Widget Function(T data);
typedef _LoadingStateCallback<T> = Widget Function(T? data);
typedef _SimpleLoadingStateCallback = Widget Function();
typedef _ErrorStateCallback<E> = Widget Function(E error);

typedef _LoadingReactionCallback = void Function(bool loading);
typedef _SuccessReactionCallback<T> = void Function(T data);
typedef _ErrorReactionCallback<E> = void Function(E error);

/// The 3 possibles states, `success`, `loading` and `error`.
enum StateType { success, loading, error }

/// Used when wants to set the success (T) and error (E) type.
typedef DataStateCustom<T, E> = _DataStateCore<T, E>;

/// Used when wants to set the success (T) type. The error will be `dynamic`.
typedef DataState<T> = _DataStateCore<T, dynamic>;

class _DataStateCore<T, E> extends _DataStateBase<T, E> with _$_DataStateCore {
  /// Starts with `loading` state.
  ///
  /// To start with `success` or `error` state use these constructors:
  /// - [DataState.startWithSuccess]
  /// - [DataState.startWithError]
  ///
  /// Use the `DataStateCustom<T, E>` to define a error type too.
  _DataStateCore() : super(initialState: StateType.loading);

  /// Starts with `success` state.
  ///
  /// Set an initial data at [data]
  _DataStateCore.startWithSuccess({required T data})
      : super(initialState: StateType.success, initialData: data);

  /// Starts with `error` state.
  ///
  /// Set an initial error at [error]
  _DataStateCore.startWithError({required error})
      : super(initialState: StateType.error, initialError: error);
}

abstract class _DataStateBase<T, E> with Store {
  _DataStateBase({
    required StateType initialState,
    T? initialData,
    E? initialError,
  })  : _state = initialState,
        _data = initialData,
        _error = initialError;

  @observable
  StateType _state;

  /// The current state.
  ///
  /// Can be used with `Observer` widget.
  @computed
  StateType get state => _state;

  /// An observable getter for when the state is `loading`.
  @computed
  bool get isLoading => _state == StateType.loading;

  /// An observable getter for when the state is `success`.
  @computed
  bool get isSuccess => _state == StateType.success;

  /// An observable getter for when the state is `error`.
  @computed
  bool get isError => _state == StateType.error;

  T? _data;
  T? get data => _data;

  E? _error;
  E? get error => _error;

  /// Set `loading` state
  @action
  void setLoadingState() {
    _state = StateType.loading;
  }

  /// Set `success` state
  @action
  void setSuccessState(T data) {
    _data = data;
    _state = StateType.success;
  }

  /// Set `error` state
  @action
  void setErrorState(E error) {
    _error = error;
    _state = StateType.error;
  }

  /// Set a callback for each state returning the widget desired for the state. Use this method inside the `Observer` widget or similar.
  ///
  /// Use the [handleStateLoadableWithData] if need to use the *data* at loading state, for example on an infinite list.
  ///
  /// If not set a callback for [error] the defaults value is a `SizedBox`.
  /// ```dart
  ///Observer(
  ///   builder: (context) => dataState.handleState(
  ///     loading: () {
  ///       return const Text('Loading');
  ///     },
  ///     success: (data) {
  ///       return const Text(data);
  ///     },
  ///     error: (error) {
  ///       return const Text('Error');
  ///     },
  ///   ),
  ///);
  /// ```
  Widget handleState({
    required _SimpleLoadingStateCallback loading,
    required _SuccessStateCallback<T> success,
    _ErrorStateCallback? error,
  }) {
    switch (_state) {
      case StateType.loading:
        return loading();
      case StateType.error:
        if (error == null) {
          return const SizedBox();
        } else {
          return error(_error as E);
        }
      default:
        return success(_data as T);
    }
  }

  /// Set a callback for each state returning the widget desired for the state, the difference of [handleState] is that the loading state takes *data* as parameter. Use this method inside the `Observer` widget or similar.
  ///
  /// If not set a callback for [error] the defaults value is a `SizedBox`.
  /// ```dart
  ///Observer(
  ///   builder: (context) => dataState.handleStateLoadableWithData(
  ///     loading: (data) {
  ///       return const Text('Loading');
  ///     },
  ///     success: (data) {
  ///       return const Text(data);
  ///     },
  ///     error: (error) {
  ///       return const Text('Error');
  ///     },
  ///   ),
  ///);
  /// ```
  Widget handleStateLoadableWithData({
    required _LoadingStateCallback<T> loading,
    required _SuccessStateCallback<T> success,
    _ErrorStateCallback<E>? error,
  }) {
    switch (_state) {
      case StateType.loading:
        return loading(_data);
      case StateType.error:
        if (error == null) {
          return const SizedBox();
        } else {
          return error(_error as E);
        }
      default:
        return success(_data as T);
    }
  }

  /// Used when wants to handle states outside the build method, like navigate to another page on sucess, show a dilaog, full loading page, etc.
  ///
  /// Call this method on the `initState`, and always remember to dispose it on dispose method.
  ///
  /// ```dart
  ///final dispose = dataState.handleReactionState(
  ///  loading: (loading) {
  ///    //do something
  ///  },
  ///  success: (data) {
  ///    //do something
  ///  },
  ///  error: (error) {
  ///    //do something
  ///  },
  ///);
  ///
  ///dispose();
  /// ```
  ReactionDisposer handleReactionState({
    _LoadingReactionCallback? loading,
    _SuccessReactionCallback<T>? success,
    _ErrorReactionCallback<E>? error,
  }) {
    return reaction((_) => _state, (_) {
      switch (_state) {
        case StateType.loading:
          if (loading != null) loading(true);
          break;
        case StateType.error:
          if (loading != null) loading(false);
          if (error != null) error(_error as E);
          break;
        case StateType.success:
          if (loading != null) loading(false);
          if (success != null) success(_data as T);
          break;
      }
    });
  }
}
