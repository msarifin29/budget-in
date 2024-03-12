import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/injection.dart';
import 'package:equatable/equatable.dart';

part 'auth_user_state.dart';

class AuthUserCubit extends Cubit<AuthUserState> {
  AuthUserCubit() : super(AuthUserInitial());
  void tokenIsExist() async {
    final fss = sl<SecureStorageManager>();
    fss.getToken().then((value) {
      if (value != null && value.isNotEmpty) {
        emit(const AuthUserLoaded(isExist: true));
      } else {
        emit(const AuthUserLoaded(isExist: false));
      }
    });
  }
}
