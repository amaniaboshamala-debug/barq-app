import 'package:barq_app/screen/lunch/lunch_screen.dart';
import 'package:barq_app/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:barq_ui/barq_ui.dart';
import 'package:get_storage/get_storage.dart';

import 'getx_controller/app_controller.dart';
import 'getx_controller/onboarding_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  Get.lazyPut(() => AppGetxController());
  Get.lazyPut(() => OnboardingController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final savedLanguage = box.read<String>('languageCode');
    final deviceLanguage =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode;
    final initialLanguage =
        savedLanguage ?? (deviceLanguage == 'en' ? 'en' : 'ar');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: barqLightTheme(),
      translations: AppTranslations(),
      locale: Locale(initialLanguage),
      fallbackLocale: const Locale('ar'),
      home: const LunchScreen(),
    );
  }
}
