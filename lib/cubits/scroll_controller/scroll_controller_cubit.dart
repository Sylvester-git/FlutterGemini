import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'scroll_controller_state.dart';

class ScrollControllerCubit extends Cubit<ScrollControllerState> {
  ScrollControllerCubit()
      : super(ScrollControllerState(scrollController: ScrollController()));

  void movetoBottom() {
    if (state.scrollController.hasClients) {
      state.scrollController.animateTo(
        state.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
    emit(state);
  }
}
