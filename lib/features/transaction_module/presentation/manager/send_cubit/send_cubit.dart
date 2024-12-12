import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/features/transaction_module/data/models/send_model.dart';

import '../../../data/repos/transaction_repo.dart';

part 'send_state.dart';

class SendCubit extends Cubit<SendState> {
  SendCubit(this.transactionRepo) : super(SendInitial());
  TransactionRepo transactionRepo;

  static SendCubit get(context) => BlocProvider.of(context);

  Future<void> sendMoney(SendModel send) async {
    emit(SendLoading());
    var data = await transactionRepo.sendMoney(send);
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
