import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void updateCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }
}
