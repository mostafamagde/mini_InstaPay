part of 'on_boarding_cubit.dart';

@immutable
sealed class OnBoardingState {}

final class OnBoardingInitial extends OnBoardingState {}

final class OnBoardingChanging extends OnBoardingState {
  final String img, title, subtitle;

  OnBoardingChanging({required this.img, required this.title, required this.subtitle});
}
