import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mini_instapay/features/transaction_module/data/models/receive_model.dart';
import 'package:mini_instapay/features/transaction_module/data/repos/transaction_repo.dart';

part 'receive_state.dart';

class ReceiveCubit extends Cubit<ReceiveState> {
  ReceiveCubit(this.transRepo) : super(ReceiveInitial());
  TransactionRepo transRepo;

  static ReceiveCubit get(context) => BlocProvider.of(context);

  Future<void> receiveMoney(ReceiveModel receive) async {
    emit(ReceiveLoading());
    final Either data = await transRepo.receiveMoney(receive);
    data.fold(
      (failure) => emit(
        ReceiveFailed(errorMessage: failure.errMessage),
      ),
      (message) => emit(
        ReceiveSuccess(message: message),
      ),
    );
  }
}
