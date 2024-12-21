import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled2/features/admn/data/models/AdminUsersModel.dart';

import '../../data/repo/admin_repo.dart';

part 'admin_get_users_state.dart';

class AdminGetUsersCubit extends Cubit<AdminGetUsersState> {
  AdminGetUsersCubit(this._adminRepo) : super(AdminGetUsersInitial());
  AdminRepo _adminRepo;

  static AdminGetUsersCubit get(context) => BlocProvider.of(context);

  Future<void> getAllUsers([String? search]) async {
    emit(AdminGetUsersLoading());
    final usersList = await _adminRepo.getUsers(search);
    usersList.fold(
        (failure) =>
            emit(AdminGetUsersFailure(errorMessage: failure.errMessage)),
        (success) => emit(AdminGetUsersSuccess(users: success)));
  }
}
