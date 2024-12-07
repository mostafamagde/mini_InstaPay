import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/features/account_managment/data/models/bank_model.dart';

import '../../../data/repos/bank_repo.dart';

part 'banks_state.dart';

class BanksCubit extends Cubit<BanksState> {
  final BankRepository bankRepository;

  BanksCubit({required this.bankRepository}) : super(BanksInitial());

  Future<void> fetchBanks() async {
    emit(BanksLoading());
    try {
      final banks = await bankRepository.getAllBanks();
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
