// GENERATED CODE - DO NOT MODIFY BY HAND

part of data_state;

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$_DataStateCore<T, E> on _DataStateBase<T, E>, Store {
  final _$_stateAtom = Atom(name: '_DataStateBase._state');

  @override
  StateType get _state {
    _$_stateAtom.reportRead();
    return super._state;
  }

  @override
  set _state(StateType value) {
    _$_stateAtom.reportWrite(value, super._state, () {
      super._state = value;
    });
  }

  final _$_DataStateBaseActionController =
      ActionController(name: '_DataStateBase');

  @override
  void setLoadingState() {
    final _$actionInfo = _$_DataStateBaseActionController.startAction(
        name: '_DataStateBase.setLoadingState');
    try {
      return super.setLoadingState();
    } finally {
      _$_DataStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSuccessState(T data) {
    final _$actionInfo = _$_DataStateBaseActionController.startAction(
        name: '_DataStateBase.setSuccessState');
    try {
      return super.setSuccessState(data);
    } finally {
      _$_DataStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setErrorState(E error) {
    final _$actionInfo = _$_DataStateBaseActionController.startAction(
        name: '_DataStateBase.setErrorState');
    try {
      return super.setErrorState(error);
    } finally {
      _$_DataStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
