import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/features/account_managment/data/models/add_account_model.dart';

part 'add_account_state.dart';

class AddAccountCubit extends Cubit<AddAccountState> {
  AddAccountCubit() : super(AddAccountInitial());

  static AddAccountCubit get(context) => BlocProvider.of(context);

  Future<void> addAccount(AddAccountModel account) async {
    emit(AddAccountLoading());
    try {
      emit(AddAccountSuccess(msg: "added successfully"));
    } catch (e) {
      if (e is DioException) {
        emit(AddAccountFailed(errorMessage: e.response?.data['message'] ?? e.message));
        print(e.response?.data['message']);
      } else {
        emit(AddAccountFailed(errorMessage: e.toString()));
      }
    }
  }
}
