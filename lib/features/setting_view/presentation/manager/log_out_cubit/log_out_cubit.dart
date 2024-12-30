import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mini_instapay/features/setting_view/data/repos/setting_repo.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit(this._settingRepo) : super(LogOutInitial());
  final SettingRepo _settingRepo;

  static LogOutCubit get(context) => BlocProvider.of(context);

  Future<void> logOut() async {
    emit(LogOutLoading());
    final Either data = await _settingRepo.logOut();
    data.fold(
      (failure) => emit(LogOutFailure(errorMessage: failure.errMessage)),
      (message) => emit(
        LogOutSuccess(
          successMessage: message,
        ),
      ),
    );
  }
}
