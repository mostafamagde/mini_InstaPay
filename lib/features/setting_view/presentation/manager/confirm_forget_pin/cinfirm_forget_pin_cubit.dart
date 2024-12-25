import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_instapay/features/setting_view/data/repos/setting_repo.dart';

part 'cinfirm_forget_pin_state.dart';

class ConfirmForgetPinCubit extends Cubit<ConfirmForgetPinState> {
  ConfirmForgetPinCubit(this.repo) : super(CinfirmForgetPinInitial());
  SettingRepo repo;
  static ConfirmForgetPinCubit get(context) => BlocProvider.of(context);
  Future<void> updatePin(String pin, String userToken) async {
    emit(CinfirmForgetPinLoading());
    final date = await repo.updatePin(pin, userToken);
    date.fold((fail) => emit(CinfirmForgetPinFailed(errorMessage: fail.errMessage)), (success) => emit(CinfirmForgetPinSuccess(errorMessage: success)));
  }
}
