import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:mini_instapay/features/account_managment/data/models/bank_model.dart';
import 'package:mini_instapay/features/account_managment/data/repos/bank_list_proxy.dart';

part 'banks_state.dart';

class BanksCubit extends Cubit<BanksState> {
  final BankListProxy bankProxy;

  BanksCubit({required this.bankProxy}) : super(BanksInitial());

  Future<void> fetchBanks() async {
    emit(BanksLoading());
    try {
      final banks = await bankProxy.getAllBanks();
      print(banks);
      emit(BanksLoaded(banks));
    } catch (e) {
      if (e is DioException) {
        emit(BanksError(e.response?.data['message'] ?? e.message));
        print(e.response?.data['message']);
      } else {
        emit(BanksError(e.toString()));
      }
    }
  }
}
