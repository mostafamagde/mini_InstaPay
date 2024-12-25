import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mini_instapay/features/setting_view/data/repos/setting_repo.dart';

part 'change_limit_state.dart';

class ChangeLimitCubit extends Cubit<ChangeLimitState> {
  final SettingRepo _settingsRepo;

  ChangeLimitCubit(this._settingsRepo) : super(ChangeLimitInitial());

  Future<void> changeLimit({
    required double limit,
    required String duration,
    required String accountId,
  }) async {
    emit(ChangeLimitLoading());
    final result = await _settingsRepo.changeLimit(
      limit: limit,
      duration: duration,
      accountId: accountId,
    );

    result.fold(
      (error) => emit(ChangeLimitError(error.errMessage)),
      (successMessage) => emit(ChangeLimitSuccess(successMessage)),
    );
  }
}
