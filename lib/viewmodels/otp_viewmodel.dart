import 'package:get/get.dart';

class OtpViewModel extends GetxController {
  final RxString _code = ''.obs;
  final RxBool _isVerifying = false.obs;

  String get code => _code.value;
  bool get isVerifying => _isVerifying.value;

  void setCode(String value) => _code.value = value;

  Future<bool> verify() async {
    if (code.length != 4) {
      Get.snackbar(
        'Invalid code',
        'Please enter the 4-digit code.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    _isVerifying.value = true;
    await Future.delayed(const Duration(milliseconds: 400));
    _isVerifying.value = false;
    return true;
  }
}


