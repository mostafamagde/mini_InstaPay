import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/features/account_managment/data/models/BankAccountModel.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_repo.dart';

part 'manage_bank_accounts_state.dart';

class ManageBankAccountsCubit extends Cubit<ManageBankAccountsState> {
  ManageBankAccountsCubit(this.bankRepository) : super(ManageBankAccountsInitial());
  BankRepository bankRepository;

  static ManageBankAccountsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchUserBanks() async {
    emit(ManageBankAccountsLoading());
    try {
      final banks = await bankRepository.getAllBankAccounts();

      emit(ManageBankAccountsSuccess(message: "You have ${banks.data?.length} bank accounts"));
    } catch (e) {
      if (e is DioException) {
        emit(ManageBankAccountsFailed(e.response?.data['message'] ?? e.message));
        print(e.response?.data['message']);
      } else {
        emit(ManageBankAccountsFailed(e.toString()));
      }
    }
  }

  Future<void> deleteBankAccount(BankAccountModel model, int index, TextEditingController inputController) async {
    try {
      await bankRepository.deleteBankAccounts(model, index, inputController);

      emit(ManageBankAccountsSuccess(message: "Delete Bank Account"));
    } catch (e) {
      if (e is DioException) {
        emit(ManageBankAccountsDeleteFailed(e.response?.data['message'] ?? e.message));
      } else {
        emit(ManageBankAccountsDeleteFailed("Deleted Successfully"));
      }
    }
  }
}
