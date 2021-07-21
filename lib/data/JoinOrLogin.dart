import 'package:flutter/material.dart';

class JoinOrLogin extends ChangeNotifier {
  // private 처리의 의의는 해당 객체를 직접 수정해버리는 경우, noti가 가지 않기 때문이다.
  bool _isJoin = false;

  bool get isJoin => _isJoin;

  void toggle() {
    _isJoin = !_isJoin;
    notifyListeners();
  }
}
