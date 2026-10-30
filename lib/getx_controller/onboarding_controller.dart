import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  final GetStorage box = GetStorage();

  RxInt currentPage = 0.obs;
  RxString currentLanguage = 'ar'.obs;
  @override
  void onInit() {
    super.onInit();
    currentLanguage.value = box.read('languageCode') ?? 'ar';
  }

  void changeLanguageTo(String languageCode) {
    currentLanguage.value = languageCode;
    box.write('languageCode', languageCode);
    Get.updateLocale(Locale(languageCode));
  }
  void changePage(int page) {
    currentPage.value = page;
  }

  bool get isFirstTime => box.read('isFirstTime') ?? true;

  void finishOnboarding() {
    box.write('isFirstTime', false);
  }

}