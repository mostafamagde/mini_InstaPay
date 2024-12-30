import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_instapay/features/admin/data/models/admin_user_model.dart';
import 'package:mini_instapay/features/admin/data/repo/admin_repo.dart';

part 'admin_get_users_state.dart';

class AdminGetUsersCubit extends Cubit<AdminGetUsersState> {
  AdminGetUsersCubit(this._adminRepo) : super(AdminGetUsersInitial());

  final AdminRepo _adminRepo;

  static AdminGetUsersCubit get(context) => BlocProvider.of(context);

  Future<void> getAllUsers([String? search]) async {
    emit(AdminGetUsersLoading());
    final usersList = await _adminRepo.getUsers(search);
    usersList.fold(
      (failure) => emit(AdminGetUsersFailure(errorMessage: failure.errMessage)),
      (success) => emit(
        AdminGetUsersSuccess(users: success),
      ),
    );
  }
}
