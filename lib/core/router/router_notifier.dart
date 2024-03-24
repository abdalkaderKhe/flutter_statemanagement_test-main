import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerNotifierProvider = Provider<RouterNotifier>(
      (ref) => RouterNotifier(),
);

final class RouterNotifier extends ChangeNotifier
{
  bool _pushHome = false;
  bool _pushLogin = false;
  bool _pushSingUp = false;

  set pushHome(bool value) {
    _pushHome = value;
    _pushLogin = !value;
    _pushSingUp = !value;
    notifyListeners();
  }

  bool get pushHome => _pushHome;

  bool get pushLogin => _pushLogin;

  bool get pushSingUp => _pushSingUp;

  set pushLogin(bool value) {
    _pushLogin = value;
    _pushHome = !value;
    _pushSingUp = !value;
     notifyListeners();
  }

  set pushSingUp(bool value) {
    _pushSingUp = value;
    _pushHome = !value;
    _pushLogin = !value;
    notifyListeners();
  }
}