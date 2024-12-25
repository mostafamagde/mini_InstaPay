import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/features/setting_view/data/repos/setting_repo.dart';

part 'change_email_state.dart';

class ChangeEmailCubit extends Cubit<ChangeEmailState> {
  final SettingRepo _settingRepo;

  ChangeEmailCubit(this._settingRepo) : super(ChangeEmailInitial());
  static ChangeEmailCubit get(context) => BlocProvider.of(context);
  Future<void> changeEmail({required String email}) async {
    emit(ChangeEmailLoading());
    final Either data = await _settingRepo.changeEmail(email: email);

    data.fold(
      (failure) => emit(ChangeEmailFailure(failure.errMessage)),
      (message) => emit(
        ChangeEmailSuccess(message),
      ),
    );
  }
}
