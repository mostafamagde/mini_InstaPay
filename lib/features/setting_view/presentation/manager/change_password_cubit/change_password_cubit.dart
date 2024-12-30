import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/features/setting_view/data/repos/setting_repo.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final SettingRepo _settingRepo;

  ChangePasswordCubit(this._settingRepo) : super(ChangePasswordInitial());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  Future<void> changePassword({required String newPass, required oldPass}) async {
    emit(ChangePasswordLoading());
    final Either data = await _settingRepo.changePassword(
      newPass: newPass,
      oldPass: oldPass,
    );
    data.fold(
      (failure) => emit(ChangePasswordFailure(failure.errMessage)),
      (message) => emit(
        ChangePasswordSuccess(message),
      ),
    );
  }
}
