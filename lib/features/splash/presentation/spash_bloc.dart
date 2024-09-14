import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_showcase/features/auth/domain/models/token.dart';
import 'package:flutter_showcase/features/auth/domain/repository/auth_repository.dart';

enum SplashStage {
  init,
  loading,
  noToken,
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
  SplashBloc({required IAuthRepository authRepository})
      : _authRepository = authRepository,
        super(SplashState.init()) {
    on<LoadUserStorage>(_onLoadUserStorage);
    on<RemoveLocals>(_onRemoveLocals);
  }
  final IAuthRepository _authRepository;
  Future<void> _onLoadUserStorage(
    LoadUserStorage event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(stage: SplashStage.loading));
    final localToken = await _authRepository.authenticateToken(
      endpoint: 'api/v1/token/validate',
    );
    await Future<void>.delayed(const Duration(seconds: 1));
    if (localToken != null && localToken.isSuccess) {
      if (localToken.data!.success) {
        emit(
          state.copyWith(
            stage: SplashStage.validToken,
            // token: localToken.data?.token,
          ),
        );
      } else {
        emit(
          state.copyWith(
            stage: SplashStage.invalidToken,
            // token: localToken.data?.token,
          ),
        );
      }
    } else {
      emit(state.copyWith(stage: SplashStage.noToken));
    }
  }

  //----
  Future<void> _onRemoveLocals(
    RemoveLocals event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(stage: SplashStage.loading));
    await _authRepository.removeTokens();
    await Future<void>.delayed(const Duration(seconds: 1));

    emit(state.copyWith(stage: SplashStage.init));
  }
}
