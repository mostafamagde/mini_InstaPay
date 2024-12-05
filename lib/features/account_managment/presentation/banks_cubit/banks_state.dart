part of 'banks_cubit.dart';

@immutable
sealed class BanksState {}

final class BanksInitial extends BanksState {}

final class BanksLoading extends BanksState {}

final class BanksLoaded extends BanksState {
  final List<BankModel> banks;
  BanksLoaded(this.banks);
}

final class BanksError extends BanksState {
  final String message;
  BanksError(this.message);
}
