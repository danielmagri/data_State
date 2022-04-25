import 'package:data_state_mobx/data_state.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final loginState = DataState<String>.startWithSuccess(data: '');

  Future<void> login(String name, String password) async {
    if (name.isNotEmpty && password.isNotEmpty) {
      loginState.setLoadingState();
      try {
        final data = await Future.delayed(const Duration(seconds: 2))
            .then((_) => 'token');
        loginState.setSuccessState(data);
      } catch (e) {
        loginState.setErrorState(e);
      }
    } else {
      loginState.setErrorState('Name or password is empty.');
    }
  }
}
