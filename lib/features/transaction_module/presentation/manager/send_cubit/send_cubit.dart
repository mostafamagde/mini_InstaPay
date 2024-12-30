import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mini_instapay/features/transaction_module/data/models/send_model.dart';
import 'package:mini_instapay/features/transaction_module/data/repos/transaction_repo.dart';

part 'send_state.dart';

class SendCubit extends Cubit<SendState> {
  SendCubit(this.transactionRepo) : super(SendInitial());
  TransactionRepo transactionRepo;

  static SendCubit get(context) => BlocProvider.of(context);

  Future<void> sendMoney(SendModel send) async {
    emit(SendLoading());
    final Either data = await transactionRepo.sendMoney(send);
    data.fold(
      (failure) => emit(
        SendFailed(error: failure.errMessage),
      ),
      (message) => emit(
        SendSuccess(message: message),
      ),
    );
  }
}
