import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(index: 0));

  static NavigationCubit get(context) => BlocProvider.of(context);

  void selectTab(int index) {
    emit(NavigationState(index: index));
  }
}
