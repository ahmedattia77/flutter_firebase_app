import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_app/core/helper/athu_error_handler.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginError(message: AthuErrorHandler.getLoginErrorMessage(e.code)));
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // await credential.user?.updateDisplayName(name);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(
        RegisterError(
          message: AthuErrorHandler.getRegisterErrorMessage(e.code),
        ),
      );
    }
  }
}
