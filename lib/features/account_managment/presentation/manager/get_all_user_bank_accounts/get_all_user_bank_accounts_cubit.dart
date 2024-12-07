import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/features/account_managment/data/models/BankAccountModel.dart';
import 'package:untitled2/features/account_managment/data/repos/bank_repo.dart';

import '../get_all_banks/banks_cubit.dart';

part 'get_all_user_bank_accounts_state.dart';

class GetAllUserBankAccountsCubit extends Cubit<GetAllUserBankAccountsState> {
  GetAllUserBankAccountsCubit(this.bankRepository)
      : super(GetAllUserBankAccountsInitial());
  BankRepository bankRepository;

  static GetAllUserBankAccountsCubit get(context) => BlocProvider.of(context);

  Future<void> fetchUserBanks() async {

    emit(GetAllUserBankAccountsLoading());
    try {
      final banks = await bankRepository.getAllBankAccounts();

      emit(GetAllUserBankAccountsSuccess(banks));
    } catch (e) {
      if (e is DioException) {
        emit(GetAllUserBankAccountsFailed(
            e.response?.data['message'] ?? e.message));
        print(e.response?.data['message']);
      } else {
        emit(GetAllUserBankAccountsFailed(e.toString()));
      }
    }
  }
}
