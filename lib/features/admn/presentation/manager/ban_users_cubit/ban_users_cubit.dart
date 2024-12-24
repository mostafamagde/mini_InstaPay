import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/repo/admin_repo.dart';

part 'ban_users_state.dart';

class BanUsersCubit extends Cubit<BanUsersState> {
  BanUsersCubit(this._adminRepo) : super(BanUsersInitial());
  AdminRepo _adminRepo;
static BanUsersCubit get(context)=>BlocProvider.of(context);
  Future<void> banUser(String id) async {
    emit(BanUsersLoading());
    final data = await _adminRepo.banUsers(id);
    data.fold(
      (failure) => emit(BanUsersFailure(error: failure.errMessage)),
      (success) => emit(
        BanUsersSuccess(mssg: success,id: id),
      ),
    );

  }
}
