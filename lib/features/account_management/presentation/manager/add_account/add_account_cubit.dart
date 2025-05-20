import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/features/account_management/data/models/add_account_model.dart';
import 'package:mini_instapay/features/account_management/data/repos/bank_repo.dart';

part 'add_account_state.dart';

class AddAccountCubit extends Cubit<AddAccountState> {
  AddAccountCubit(this._bankRepository) : super(AddAccountInitial());

  final BankRepository _bankRepository;
  static AddAccountCubit get(context) => BlocProvider.of(context);

  Future<void> addAccount(AddAccountModel account) async {
    emit(AddAccountLoading());
    try {
      await _bankRepository.addAccount(account);
      emit(AddAccountSuccess(msg: "added successfully"));
    } catch (e) {
      if (e is DioException) {
        late final String errMessage;
        if (e.response?.data['message'] is List) {
          errMessage = e.response?.data['message'].join('\n') ?? e.message;
        } else {
          errMessage = e.response?.data['message'] ?? e.message;
        }

        emit(AddAccountFailed(errorMessage: errMessage));
      } else {
        emit(AddAccountFailed(errorMessage: e.toString()));
      }
    }
  }
}
