import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:mini_instapay/features/admin/data/models/admin_user_model.dart';
import 'package:mini_instapay/features/admin/data/repo/admin_repo.dart';

part 'ban_users_state.dart';

class BanUsersCubit extends Cubit<BanUsersState> {
  BanUsersCubit(this._adminRepo) : super(BanUsersInitial());

  final AdminRepo _adminRepo;
  static BanUsersCubit get(context) => BlocProvider.of(context);

  Future<void> banUser(AdminUsersModel user) async {
    emit(BanUsersLoading());
    final data = await _adminRepo.banUsers(user);
    data.fold(
      (failure) => emit(BanUsersFailure(error: failure.errMessage)),
      (success) => emit(
        BanUsersSuccess(mssg: success, user: user),
      ),
    );
  }
}
