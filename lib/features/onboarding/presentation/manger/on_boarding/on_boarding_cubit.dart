import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());
  final Map<String, dynamic> onBoardingScreens = {
    'firstScreen': {
      'img': 'assets/images/IMG_20241213_215612.jpg',
      'title': 'Welcome to Mini Instapay',
      'subtitle':'With InstaPay you can send and receive money, pay your bills or purchase from merchants instantly 24x7.'
    },
    'secondScreen': {
      'img': 'assets/images/IMG_20241213_215642.jpg',
      'title': 'Send Money',
      'subtitle': 'Send Money instantly from your bank accounts and Meeza Prepaid Cards. Your transactions are processed through IPN secured network.'
    },
    'thirdScreen': {
      'img': 'assets/images/IMG_20241213_215740.jpg',
      'title': 'Financial Services',
      'subtitle': 'You can now check your transactions history and balance through Instapay.'
    },
    'fourthScreen': {
      'img': 'assets/images/IMG_20241213_215815.jpg',
      'title': 'Collect Money',
      'subtitle': 'Collect money from other users by entering their instant payment address or mobile number.'
    },
  };
void changeOnboardingScreen(String screenKey) {
    emit(
      OnBoardingChanging(
     img:  onBoardingScreens[screenKey]['img'],
     subtitle: onBoardingScreens[screenKey]['title'],
     title: onBoardingScreens[screenKey]['subtitle'],
    ));
  }
List<String> screens = ['firstScreen', 'secondScreen', 'thirdScreen'];
}
