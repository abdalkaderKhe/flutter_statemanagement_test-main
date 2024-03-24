import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/feature/auth/model/user.dart';
import '../notifier/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, bool>(
  (ref) => AuthStateNotifier(ref),
);

final userStateProvider = StateNotifierProvider<UserNotifier, User>(
  (ref) => UserNotifier(),
);
