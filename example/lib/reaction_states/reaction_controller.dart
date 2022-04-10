import 'dart:math' as math;
import 'package:data_state/data_state.dart';
import 'package:mobx/mobx.dart';

part 'reaction_controller.g.dart';

class ReactionController = _ReactionControllerBase with _$ReactionController;

abstract class _ReactionControllerBase with Store {
  final dataState = DataState<int>.startWithSuccess(data: 0);

  Future<void> random() async {
    dataState.setLoadingState();
    try {
      final data = await Future.delayed(const Duration(seconds: 1))
          .then((_) => math.Random().nextInt(100));
      dataState.setSuccessState(data);
    } catch (e) {
      dataState.setErrorState(e);
    }
  }
}
