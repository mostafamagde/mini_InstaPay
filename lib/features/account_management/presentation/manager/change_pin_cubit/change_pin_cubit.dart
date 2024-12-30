import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mini_instapay/features/account_management/data/repos/bank_repo.dart';

part 'change_pin_state.dart';

class ChangePinCubit extends Cubit<ChangePinState> {
  final BankRepository _bankRepository;
  static ChangePinCubit get(context) => BlocProvider.of(context);

  ChangePinCubit(this._bankRepository) : super(ChangePinInitial());

  Future<void> changePin(String oldPin, String newPin, String accId) async {
    emit(ChangePinLoading());
    final response = await _bankRepository.changePin(oldPin, newPin, accId);
    response.fold(
      (failure) => emit(
        ChangePinFailed(message: failure.errMessage),
      ),
      (success) => emit(
        ChangePinSuccess(message: "Updated Successfully"),
      ),
    );
  }
}
