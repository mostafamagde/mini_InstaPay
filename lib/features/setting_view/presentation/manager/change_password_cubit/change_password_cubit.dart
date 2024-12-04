import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repos/setting_repo.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final SettingRepo _settingRepo;

  ChangePasswordCubit(this._settingRepo) : super(ChangePasswordInitial());

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  Future<void> changePassword(
      {required String newPass, required oldPass}) async {
    emit(ChangePasswordLoading());
    var data = await _settingRepo.changePassword(
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
