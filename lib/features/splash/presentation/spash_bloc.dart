import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/core/config/endpoints.dart';
import 'package:flutter_showcase/features/auth/domain/models/token.dart';
import 'package:flutter_showcase/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_showcase/features/onboarding/domain/repository/onboarding_repository_i.dart';

enum SplashStage {
  init,
  loading,
  firstTime,

  invalidToken,
  validToken,
}

//----event

abstract class SplashEvent {}

class LoadUserStorage extends SplashEvent {}

class RemoveLocals extends SplashEvent {}

//-----state
class SplashState extends Equatable {
  const SplashState({required this.stage, this.token});

  factory SplashState.init() => const SplashState(stage: SplashStage.init);

  SplashState copyWith({SplashStage? stage, Token? token}) {
    return SplashState(stage: stage ?? this.stage, token: token ?? this.token);
  }

  final SplashStage stage;
  final Token? token;

  @override
  List<Object?> get props => [stage, token];
}

//----bloc
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({
    required IAuthRepository authRepository,
    required IOnboardingRepository onBoardingRepository,
  })  : _onBoardingRepository = onBoardingRepository,
        _authRepository = authRepository,
        super(SplashState.init()) {
    on<LoadUserStorage>(_onLoadUserStorage);
    on<RemoveLocals>(_onRemoveLocals);
  }
  final IAuthRepository _authRepository;
  final IOnboardingRepository _onBoardingRepository;
  Future<void> _onLoadUserStorage(
    LoadUserStorage event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(stage: SplashStage.loading));
    final authTokenRes = await _authRepository.authenticateToken(
      endpoint: Endpoints.tokenValidation,
    );

    final isOnboarded = await _onBoardingRepository.getIsOnboarded();

    await Future<void>.delayed(const Duration(seconds: 1));
    if (authTokenRes != null && authTokenRes.isSuccess) {
      if (authTokenRes.data!.isValid) {
        //if server says the token is valid (lead to the home screen)
        emit(
          state.copyWith(
            stage: SplashStage.validToken,
          ),
        );
      } else {
        //if server says the token is NOT valid (lead to the login screen)

        emit(
          state.copyWith(
            stage: SplashStage.invalidToken,
          ),
        );
      }
    } else {
      if (!isOnboarded) {
        //if user is not onboarded at all (lead to the onboarding screen)
        emit(state.copyWith(stage: SplashStage.firstTime));
      } else {
        //No token found and has onboarded (lead to the login screen)
        emit(
          state.copyWith(
            stage: SplashStage.invalidToken,
          ),
        );
      }
    }
  }

  //----
  Future<void> _onRemoveLocals(
    RemoveLocals event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(stage: SplashStage.loading));
    await _authRepository.removeLocals();
    await Future<void>.delayed(const Duration(seconds: 1));

    emit(state.copyWith(stage: SplashStage.init));
  }
}
