import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String _photoUrl = '';

  String get photoUrl => _photoUrl;

  void setPhotoUrl(String url) {
    _photoUrl = url;
    notifyListeners();
  }
}