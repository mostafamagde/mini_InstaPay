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

      emit(ManageBankAccountsSuccess());
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

    late BankAccountModel banks;
    try {
      await bankRepository.deleteBankAccounts(model, index, inputController);



      emit(ManageBankAccountsSuccess( message: "deleted successfully"));
    } catch (e) {
      if (e is DioException) {
        emit(ManageBankAccountsFailed(e.response?.data['message'] ?? e.message));
        print(e.response?.data['message']);
      } else {
        emit(ManageBankAccountsFailed(e.toString()));
      }
    }
  }
}
