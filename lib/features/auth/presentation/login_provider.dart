import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habit_wallet_lite/features/auth/data/auth_repository_impl.dart';
import 'package:habit_wallet_lite/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:habit_wallet_lite/features/auth/domain/auth_repository.dart';

class LoginState {
  final bool loading;
  final bool isLoggedIn;
  final String? error;
  final bool rememberMe;
  final String? email;

  const LoginState({
    this.loading = false, 
    required this.isLoggedIn,
    this.error,
     this.rememberMe = false,
    this.email,
  });

  factory LoginState.initial() => const LoginState(
        loading: false,
        isLoggedIn: false,
        rememberMe: false,
      );

  LoginState copyWith({
    bool? loading,
    bool? isLoggedIn,
    String? error,
    bool? rememberMe,
    String? email,
  }) {
    return LoginState(
      loading: loading ?? this.loading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      error: error,
      rememberMe: rememberMe ?? this.rememberMe,
      email: email ?? this.email,
    );
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthRepository repo;

  LoginNotifier(this.repo) : super(LoginState.initial()) {
    loadSavedCredentials(); 
  }
  Future<void> login(String email, String pin) async {
  state = state.copyWith(loading: true, error: null);

  try {
    final success = await repo.login(email, pin);

    if (success) {
      if (state.rememberMe) {
        await repo.saveCredentials(email, pin);
       }
      // else {
      //   await repo.clearCredentials();
      // }

      state = state.copyWith(
        loading: false,
        isLoggedIn: true, 
        email: email,
      );
    } else {
      state = state.copyWith(
        loading: false,
         isLoggedIn: false,
        error: 'Invalid email or PIN',
      );
    }
  } catch (e) {
    state = state.copyWith(
      loading: false,
      isLoggedIn: false,
      error: 'Something went wrong',
    );
  }
}


  /// Load saved credentials for "Remember me"
  Future<void> loadSavedCredentials() async {
    final savedPin = await repo.getPin();
    final savedEmail = savedPin != null ? await repo.getEmail() : null;

    if (savedEmail != null) {
      state = state.copyWith(
        email: savedEmail,
        rememberMe: true,
      );
    }
  }

  /// Update Remember Me toggle
  void updateRememberMe(bool value) {
    state = state.copyWith(rememberMe: value);
    
  }

  /// Logout
  Future<void> logout() async {
    await repo.clearCredentials();
    state = LoginState.initial();
  }
  void clearError() {
    state = state.copyWith(error: null);
  }
  
}

// FlutterSecureStorage provider
final secureStorageProvider =
    Provider((_) => const FlutterSecureStorage());

// AuthLocalDataSource provider
final authLocalDataSourceProvider = Provider(
  (ref) => AuthLocalDataSource(ref.read(secureStorageProvider)),
);

// AuthRepository provider
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.read(authLocalDataSourceProvider)),
);

// LoginNotifier + LoginState provider
final loginProvider =
    StateNotifierProvider<LoginNotifier, LoginState>(
  (ref) => LoginNotifier(ref.read(authRepositoryProvider)),
);

