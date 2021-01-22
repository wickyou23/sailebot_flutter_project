import 'package:bloc/bloc.dart';
import 'package:sailebot_app/bloc/auth/auth_event.dart';
import 'package:sailebot_app/bloc/auth/auth_state.dart';
import 'package:sailebot_app/data/middleware/authentication_middleware.dart';
import 'package:sailebot_app/data/network_response_state.dart';
import 'package:sailebot_app/data/repository/auth_repository.dart';
import 'package:sailebot_app/models/auth_user.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repo = AuthRepository();

  @override
  AuthState get initialState => AuthInitializeState();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthSignupEvent) {
      yield* _mapToAuthSignupEvent(event);
    } else if (event is AuthSigninEvent) {
      yield* _mapToAuthSigninEvent(event);
    } else if (event is AuthLinkedinEvent) {
      yield* _mapToAuthLinkedinEvent(event);
    }
  }

  @override
  Future<void> close() {
    print('AuthBloc closed');
    return super.close();
  }

  Stream<AuthState> _mapToAuthSignupEvent(AuthSignupEvent event) async* {
    yield AuthProcessingState();
    ResponseState signupRes = await AuthMiddleware().signup(
      email: event.email,
      password: event.password,
    );

    if (signupRes is ResponseSuccessState<AuthUser>) {
      AuthUser user = signupRes.responseData;
      ResponseState profileRes = await AuthMiddleware().updateProfile(
        user: user,
        name: event.userName,
      );

      if (profileRes is ResponseSuccessState<AuthUser>) {
        user = profileRes.responseData;
      }

      await repo.setCurrentUser(user);
      yield AuthSignupSuccessState();
      yield AuthReadyState(user);
    } else if (signupRes is ResponseFailedState) {
      yield AuthSignupFailedState(failedState: signupRes);
    }
  }

  Stream<AuthState> _mapToAuthSigninEvent(AuthSigninEvent event) async* {
    yield AuthProcessingState();
    ResponseState res = await AuthMiddleware().signin(
      email: event.email,
      password: event.password,
    );

    if (res is ResponseSuccessState<AuthUser>) {
      await repo.setCurrentUser(res.responseData);
      yield AuthSigninSuccessState();
      yield AuthReadyState(res.responseData);
    } else if (res is ResponseFailedState) {
      yield AuthSigninFailedState(failedState: res);
    }
  }

  Stream<AuthState> _mapToAuthLinkedinEvent(AuthLinkedinEvent event) async* {
    yield AuthProcessingState();
    ResponseState res = await AuthMiddleware().signinWithLinkedin(event.context);
    if (res is ResponseSuccessState<AuthUser>) {
      await repo.setCurrentUser(res.responseData);
      yield AuthSigninLinkedinSuccessState(res.responseData);
    } else if (res is ResponseFailedState) {
      yield AuthSigninFailedState(failedState: res);
    }
  }
}
