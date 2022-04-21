import 'package:data_state_mobx/data_state.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart' show Color;
import 'package:mobx/mobx.dart';

part 'reloadable_controller.g.dart';

class ReloadableController = _ReloadableControllerBase
    with _$ReloadableController;

abstract class _ReloadableControllerBase with Store {
  final dataState = DataState<List<Color>>();

  Future<void> fetchData() async {
    dataState.setLoadingState();
    try {
      final data = await Future.delayed(const Duration(seconds: 2)).then((_) =>
          List.generate(
              15,
              (_) => Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0)));
      dataState.setSuccessState([...?dataState.data, ...data]);
    } catch (e) {
      dataState.setErrorState(e);
    }
  }
}
