import 'dart:async';

import 'package:flutter_onboarding/utils/network_util.dart';
import 'package:flutter_onboarding/models/user.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "https://varopago-v2-backend-qa.herokuapp.com";
  static final LOGIN_URL = BASE_URL + "/auth/login";
  static final _API_KEY = "";

  Future<User> login(String email, String password) {
    // "token": _API_KEY,
    return _netUtil.post(LOGIN_URL, body: {
      "email": email,
      "password": password
    }).then((dynamic res) {
      print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      return new User.map(res["user"]);
    });
  }
}
