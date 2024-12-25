import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/features/setting_view/data/repos/setting_repo.dart';

part 'forget_pin_state.dart';

class ForgetPinCubit extends Cubit<ForgetPinState> {
  final SettingRepo _settingRepo;

  ForgetPinCubit(this._settingRepo) : super(ForgetPinInitial());
  static ForgetPinCubit get(context) => BlocProvider.of(context);
  Future<void> forgetPin(String id) async {
    emit(ForgetPinLoading());
    final Either data = await _settingRepo.forgetPin(id);
    data.fold(
      (failure) => emit(ForgetPinFailure(failure.errMessage)),
      (userToken) => emit(
        ForgetPinSuccess(
          userToken,
        ),
      ),
    );
  }
}
