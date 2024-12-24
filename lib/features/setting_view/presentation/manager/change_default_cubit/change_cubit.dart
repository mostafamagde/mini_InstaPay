import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/features/setting_view/data/repos/setting_repo.dart';

part 'change_state.dart';

class ChangeDefaultAccCubit extends Cubit<ChangeState> {
  ChangeDefaultAccCubit(this._settingRepo) : super(ChangeInitial());
  final SettingRepo _settingRepo;

  static ChangeDefaultAccCubit get(context) => BlocProvider.of(context);

  Future<void> changeDefault(String id) async {
    emit(ChangeLoading());
    final response = await _settingRepo.changeDefault(id);
    response.fold(
      (failure) => emit(ChangeFailed(message: failure.errMessage)),
      (message) => emit(
        ChangeSuccess(Id: id),
      ),
    );
  }
}
