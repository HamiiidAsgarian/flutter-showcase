// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/features/onboarding/domain/repository/onboarding_repository_i.dart';

enum Stage { messages, end }

//----Event
abstract class OnBoardingEvent {}

class ChangePage extends OnBoardingEvent {
  int newPageIndex;
  bool isTheLastPage;
  ChangePage({required this.newPageIndex, required this.isTheLastPage});
}

class SaveUserOnbordedSuccess extends OnBoardingEvent {
  SaveUserOnbordedSuccess();
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
  OnBoardingBloc({required IOnboardingRepository onboardingRepository})
      : _onboardingRepository = onboardingRepository,
        super(OnBoardingState.initial()) {
    on<ChangePage>(_onChangePage);
    on<SaveUserOnbordedSuccess>(_onSaveUserOnbordedSuccess);
  }
  final IOnboardingRepository _onboardingRepository;
  int pageindex = 0;

  void _onChangePage(
    ChangePage event,
    Emitter<OnBoardingState> emit,
  ) {
    if (event.isTheLastPage) {
      emit(state.copyWith(stage: Stage.end, pageIndex: event.newPageIndex));
    } else {
      pageindex++;
      emit(
        state.copyWith(stage: Stage.messages, pageIndex: event.newPageIndex),
      );
    }
  }

  //----
  Future<void> _onSaveUserOnbordedSuccess(
    SaveUserOnbordedSuccess event,
    Emitter<OnBoardingState> emit,
  ) async {
    await _onboardingRepository.setIsOnboarded(status: true);
  }
}
