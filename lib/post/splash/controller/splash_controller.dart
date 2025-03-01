import 'dart:async';
import 'package:get/get.dart';
import 'package:long_register_flutter/App_route/route_App.dart';
import 'package:long_register_flutter/repository/post/login_repositories.dart';

class SplashController extends GetxController {
  final LoginRepositories _loginRepositories = LoginRepositories();
  Timer? _timer;

  @override
  void onInit() {
    _startPeriodicLoginCheck();
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Stop the timer when controller is closed
    super.onClose();
  }

  void _startPeriodicLoginCheck() {
    // Periodically check login status every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (_) async {
      await checkUserLogin();
    });
  }

  Future<void> checkUserLogin() async {
    var user = await _loginRepositories.getUserLocal();
    if (user.accessToken != null) {
      _timer?.cancel(); // Stop checking once logged in
      Get.offAllNamed(Route_App.home);
    } else {
      Get.offAllNamed(Route_App.home);
    }
  }
}
