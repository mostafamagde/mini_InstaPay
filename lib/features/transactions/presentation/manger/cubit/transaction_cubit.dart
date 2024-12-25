import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:mini_instapay/core/enums/transaction_status_enum.dart';
import 'package:mini_instapay/features/transactions/data/model/transaction_model.dart';
import 'package:mini_instapay/features/transactions/data/repository/transaction_repo.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository transactionRepository;
  TransactionCubit(this.transactionRepository) : super(TransactionInitial());
  getUserTransaction() async {
    try {
      emit(TransactionLoading());
      List<TransactionModel> transactions = await transactionRepository.getUserTransactions();
      emit(TransactionSuccess(transactions: transactions));
    } catch (e) {
      if (e is DioException) {
        emit(TransactionError(error: e.response?.data["message"] ?? e.message));
      } else {
        emit(TransactionError(error: e.toString()));
      }
    }
  }

  getAllTransaction() async {
    try {
      emit(TransactionLoading());
      List<TransactionModel> transactions = await transactionRepository.getAllTransactions();
      emit(TransactionSuccess(transactions: transactions));
    } catch (e) {
      if (e is DioException) {
        emit(TransactionError(error: e.response?.data["message"] ?? e.message));
      } else {
        emit(TransactionError(error: e.toString()));
      }
    }
  }

  markAsSuspicious(String transactionId) async {
    try {
      emit(ManageTransactionLoading());
      await transactionRepository.markAsSuspicious(transactionId);
      emit(ManageTransactSuccess(massage: "Transaction Marked As Suspicious", transactionStatus: TransactionStatus.Suspicious));
    } catch (e) {
      if (e is DioException) {
        emit(ManageTransactFailed(error: e.response?.data["message"] ?? e.message));
      } else {
        emit(ManageTransactFailed(error: e.toString()));
      }
    }
  }

  requestRefund(String transactionId) async {
    try {
      emit(ManageTransactionLoading());
      await transactionRepository.requestRefund(transactionId);
      emit(ManageTransactSuccess(massage: "Refund Requested", transactionStatus: TransactionStatus.Refunding));
    } catch (e) {
      if (e is DioException) {
        emit(ManageTransactFailed(error: e.response?.data["message"] ?? e.message));
      } else {
        emit(ManageTransactFailed(error: e.toString()));
      }
    }
  }
}
