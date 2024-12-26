import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_instapay/features/account_management/data/repos/bank_repo.dart';

part 'get_balance_state.dart';

class GetBalanceCubit extends Cubit<GetBalanceState> {
  GetBalanceCubit(this.bankRepo) : super(GetBalanceInitial());

  final BankRepository bankRepo;
  static GetBalanceCubit get(context) => BlocProvider.of(context);

  Future<void> getBalance(String id, String pin) async {
    emit(GetBalanceLoading());
    try {
      final balance = await bankRepo.getBalance(id, pin);

      emit(GetBalanceSuccess(balance: balance));
    } catch (e) {
      if (e is DioException) {
        emit(GetBalanceFailed(error: e.response?.data["message"] ?? e.message));
      } else {
        emit(GetBalanceFailed(error: "GetBalanceFailed"));
      }
    }
  }
}
