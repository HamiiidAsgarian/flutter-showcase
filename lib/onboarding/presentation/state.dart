// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

enum Stage { messages, end }

//----Event
abstract class OnBoardingEvent {}

class ChangePage extends OnBoardingEvent {
  int newPageIndex;
  bool isTheLastPage;
  ChangePage({required this.newPageIndex, required this.isTheLastPage});
}

//----State
class OnBoardingState {
  OnBoardingState({required this.stage, required this.pageIndex});

  factory OnBoardingState.initial() =>
      OnBoardingState(stage: Stage.messages, pageIndex: 0);
  final Stage stage;
  final int pageIndex;

  OnBoardingState copyWith({
    Stage? stage,
    int? pageIndex,
  }) {
    return OnBoardingState(
      stage: stage ?? this.stage,
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}

//----Bloc
class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(OnBoardingState.initial()) {
    on<ChangePage>(onChangePage);
  }
  int pageindex = 0;

  void onChangePage(
    ChangePage event,
    Emitter<OnBoardingState> emit,
  ) {
    final stage = event.isTheLastPage ? Stage.end : Stage.messages;
    pageindex++;
    emit(state.copyWith(stage: stage, pageIndex: event.newPageIndex));
  }
}
