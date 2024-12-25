import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_instapay/features/otp/data/repositories/otp_repo.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());

  Future<void> submit(OtpRepository otpRepo, String otp, String token) async {
    try {
      emit(OtpLoading());
      await otpRepo.submitOtp(otp: otp, token: token);

      emit(OtpSuccess());
    } catch (e) {
      emit(OtpError(e.toString()));
    }
  }

  Future<void> resendOtp(OtpRepository otpRepo, String token) async {
    try {
      emit(OtpLoading());
      await otpRepo.resendOtp(token: token);
      emit(OtpResendSuccess());
    } catch (e) {
      emit(OtpError(e.toString()));
    }
  }
}
