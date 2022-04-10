import 'package:data_state/data_state.dart';
import 'package:mobx/mobx.dart';

part 'simple_controller.g.dart';

class SimpleController = _SimpleControllerBase with _$SimpleController;

abstract class _SimpleControllerBase with Store {
  final dataState = DataState<List<String>>();

  Future<void> fetchData() async {
    dataState.setLoadingState();
    try {
      final data = await Future.delayed(const Duration(seconds: 2))
          .then((_) => ['String 1', 'String 2', 'String 3']);
      dataState.setSuccessState(data);
    } catch (e) {
      dataState.setErrorState(e);
    }
  }
}
