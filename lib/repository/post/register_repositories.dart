import 'package:long_register_flutter/data/remote/Network_url_app.dart';
import 'package:long_register_flutter/data/remote/api_url.dart';
import 'package:long_register_flutter/model/login/login_rep.dart';

class RegisterRepositories {
  final _api = NetworkUrlApp();
  Future<LoginRep> register(RegisterLogin, rep)async{
    var response = await _api.register(ApiUrl.postAppLoginRegister, rep.tojson);
    return LoginRep.fromJson(response);
  }
}
