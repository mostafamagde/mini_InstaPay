import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/credinitials_model.dart';
import '../../../data/repos/setting_repo.dart';

part 'change_credinitials_state.dart';

class ChangeCredinitialsCubit extends Cubit<ChangeCredinitialsState> {
  final SettingRepo _settingRepo;

  ChangeCredinitialsCubit(this._settingRepo)
      : super(ChangeCredinitialsInitial());

  static ChangeCredinitialsCubit get(context) => BlocProvider.of(context);

  Future<void> changeCredinitials(CredinitialsModel model) async {
    emit(ChangeCredinitialsLoading());
    var data = await _settingRepo.changeCredintials(model: model);
    data.fold(
      (failure) => emit(ChangeCredinitialsFailure(failure.errMessage)),
      (message) => emit(
        ChangeCredinitialsSuccess(message),
      ),
    );
  }
}
