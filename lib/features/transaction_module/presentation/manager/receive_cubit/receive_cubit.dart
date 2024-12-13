import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/receive_model.dart';
import '../../../data/repos/transaction_repo.dart';

part 'receive_state.dart';

class ReceiveCubit extends Cubit<ReceiveState> {
  ReceiveCubit(this.transRepo) : super(ReceiveInitial());
  TransactionRepo transRepo;

  static ReceiveCubit get(context) => BlocProvider.of(context);

  Future<void> receiveMoney(ReceiveModel receive) async {
    emit(ReceiveLoading());
    var data = await transRepo.receiveMoney(receive);
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
