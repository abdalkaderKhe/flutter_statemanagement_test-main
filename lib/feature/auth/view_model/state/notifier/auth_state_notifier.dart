import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_management_test/core/cache/locale_manager.dart';
import 'package:state_management_test/feature/auth/model/user.dart';
import '../../../../../core/constants/enums/locale_keys_enum.dart';
import '../../../../../core/router/router_notifier.dart';
import '../../auth_view_model.dart';

final class AuthStateNotifier extends StateNotifier<bool> {
  AuthViewModel authViewModel = AuthViewModel();
  Ref ref;

  AuthStateNotifier(this.ref)
      : super(LocaleManager.instance.getBoolValue(PreferencesKeys.IS_LOGGED));

  Future<void> login(String username) async {
    bool isLogged = await authViewModel.login(username);
    state = isLogged;
    ref.read(routerNotifierProvider).pushHome = isLogged;
  }

  Future<void> singUp(String username) async {
    await authViewModel.saveUser(username);
    ref.read(routerNotifierProvider).pushLogin = true;
  }

  Future<void> logOut() async {
    await authViewModel.logOut();
    state = false;
    ref.read(routerNotifierProvider).pushLogin = true;
  }
}

class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User.initial()) {
    user = User.initial();
    state = user;
  }

  void updateUserName(String value) {
    user.name = value;
    state = user;
  }

  late final User user;
}
