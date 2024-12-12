import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/features/home_view/data/model/transaction_model.dart';
import 'package:untitled2/features/home_view/data/repository/transaction_repo.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final TransactionRepository transactionRepository;
  TransactionCubit(this.transactionRepository) : super(TransactionInitial());
  getTransaction()async{
    try{
    emit(TransactionLoading());
    List<TransactionModel>transactions= await transactionRepository.getAllTransactions();
    emit(TransactionSuccess(transactions: transactions));
    }
    catch(e){
      if(e is DioException){
        emit(TransactionError(error: e.response?.data["message"] ?? e.message));
      }
      else{emit(TransactionError(error: e.toString()));}
    }
  }
}
