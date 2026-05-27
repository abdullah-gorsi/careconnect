import 'package:get/get.dart';

/// OtpViewModel
/// Simple in-memory OTP validation placeholder.
/// Currently does not talk to a backend, only validates length.
class OtpViewModel extends GetxController {
  /// The entered OTP code.
  final RxString _code = ''.obs;
  
  /// Loading state during verification.
  final RxBool _isVerifying = false.obs;

  String get code => _code.value;
  bool get isVerifying => _isVerifying.value;

  /// Updates the OTP code value.
  void setCode(String value) => _code.value = value;

  /// Dummy verification: returns true if code has 4 digits.
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

