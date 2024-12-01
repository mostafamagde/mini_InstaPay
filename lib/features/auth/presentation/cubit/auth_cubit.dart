import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/features/auth/data/models/otp_model.dart';
import 'package:untitled2/features/auth/data/models/signup_model.dart';
import 'package:untitled2/features/auth/data/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(AuthInitial());
  final AuthRepository _authRepository;


  Future<void> login({required String email,required String password}) async {
    emit(AuthLoading());
    try {
      final otpModel = await _authRepository.login(email, password);
      emit(AuthSuccess(otpModel));
    } catch (e) {
      emit(AuthFail(e.toString()));
    }
  }

  Future<void> signUp(SignUpModel signUpModel) async {
    emit(AuthLoading());
    try {
      final otpModel = await _authRepository.signUp(signUpModel);
      emit(AuthSuccess(otpModel));
    } catch (e) {
      emit(AuthFail(e.toString()));
    }
  }
}
