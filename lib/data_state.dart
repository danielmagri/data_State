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

enum StateType { success, loading, error }

typedef DataStateCustom<T, E> = DataStateBase<T, E>;
typedef DataState<T> = DataStateBase<T, dynamic>;

class DataStateBase<T, E> extends _DataStateBase<T, E> with _$DataState {
  DataStateBase() : super(initialState: StateType.loading);

  DataStateBase.startWithSuccess({required T data})
      : super(initialState: StateType.success, initialData: data);

  DataStateBase.startWithError({required error})
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

  StateType get state => _state;

  T? _data;
  T? get data => _data;

  E? _error;
  E? get error => _error;

  @action
  void setLoadingState([bool loading = true]) {
    _state = StateType.loading;
  }

  @action
  void setSuccessState(T data) {
    _data = data;
    _state = StateType.success;
  }

  @action
  void setErrorState(E error) {
    _error = error;
    _state = StateType.error;
  }

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
