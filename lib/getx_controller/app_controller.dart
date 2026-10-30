import 'package:barq_app/screen/on_boarding/on_boarding_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/api_settings.dart';
import '../api/dio_client.dart';
import '../model/app_config.dart';

/// مسؤول عن تحميل إعدادات المشروع وبيانات المتجر، وفحص تسجيل الدخول.
class AppGetxController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rxn<ProjectInfo> store = Rxn<ProjectInfo>();
  final RxString errorMessage = ''.obs;
  /// هل لازم المستخدم يحدّث التطبيق؟ (رد السيرفر 426)
  final RxBool updateRequired = false.obs;
  /// اللون الأساسي للتطبيق (قيمة افتراضية لحد ما توصل من السيرفر).
  final Rx<Color> primary = const Color(0xFFFA6400).obs;
  final GetStorage box = GetStorage();
  /// بتشتغل أوتوماتيك أول ما تنفتح شاشة السبلاش.
  @override
  void onReady() {
    super.onReady();
    start();
  }

  /// الخطوات: تحميل المتجر ← فحص تسجيل الدخول ← التوجيه.
  /// بنناديها كمان من زر إعادة المحاولة.
  Future<void> start() async {
    isLoading.value = true;
    errorMessage.value = '';
    updateRequired.value = false;

    try {
      // تحميل المتجر + انتظار ثانيتين كحد أدنى عشان السبلاش ما تختفي بسرعة.
      await Future.wait([
        fetchStore(),
        Future.delayed(const Duration(seconds: 2)),
      ]);

      // إذا فشل التحميل أو لازم تحديث، بنوقف هون.
      if (errorMessage.value.isNotEmpty || updateRequired.value) return;

      await checkLogin();
    } finally {
      isLoading.value = false;
    }
  }

  /// تحميل إعدادات المتجر من API.
  Future<void> fetchStore() async {
    try {
      final response = await DioClient.dio.get(
        ApiSettings.appConfig,
        queryParameters: {'app': 'user'},
      );

      final Map<String, dynamic> body =
      Map<String, dynamic>.from(response.data);

      // الرد بيجي بهالشكل: { success, message, data: {...} }
      final bool success = body['success'] == true;
      final dynamic data = body['data'];

      if (success && data is Map) {
        // الموديل بيتبني من data فقط.
        final config = AppConfig.fromJson(Map<String, dynamic>.from(data));

        // حفظ بيانات المشروع.
        store.value = config.project;
        debugPrint('Store name: ${store.value?.name}');
        debugPrint('Logo URL: ${store.value?.logoUrl}');

        // تحديث اللون الأساسي من إعدادات المشروع.
        final String? hexColor = config.project.colors['primary'];

        if (hexColor != null &&
            RegExp(r'^#[0-9A-Fa-f]{6}$').hasMatch(hexColor)) {
          primary.value = Color(
            int.parse(hexColor.substring(1), radix: 16) | 0xFF000000,
          );
        }

        debugPrint('Primary color: ${primary.value}');
      } else {
        errorMessage.value =
            body['message']?.toString() ?? 'تعذر تحميل بيانات المتجر';
        debugPrint('Response: $body');
      }
    } on DioException catch (e) {
      // 426 = التطبيق قديم.
      if (e.response?.statusCode == 426) {
        updateRequired.value = true;
      } else {
        errorMessage.value = DioClient.errorMessage(e);
      }
      debugPrint('Fetch Store Error: ${e.message}');
    } catch (e, stackTrace) {
      errorMessage.value = 'حدث خطأ غير متوقع';
      debugPrint('Fetch Store Error: $e');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  /// فحص تسجيل الدخول والتوجيه للشاشة المناسبة.

  Future<void> checkLogin() async {
    // هل المستخدم يدخل التطبيق لأول مرة؟
    final bool isFirstTime = box.read<bool>('isFirstTime') ?? true;

    // إذا كانت أول مرة، نعرض شاشات التعريف
    if (isFirstTime) {
      Get.offAll(OnBoardingScreen());
      return;
    }

    // فحص تسجيل الدخول
    final String? token = box.read<String>('token');

    if (token == null || token.isEmpty) {
      Get.offAllNamed('/login');
      return;
    }

    try {
      await DioClient.dio.get(ApiSettings.me);

      Get.offAllNamed('/home');
    } on DioException catch (e) {
      final int? code = e.response?.statusCode;

      if (code == 401) {
        await box.remove('token');
        Get.offAllNamed('/login');
      } else if (code == 426) {
        updateRequired.value = true;
      } else {
        errorMessage.value = DioClient.errorMessage(e);
      }

      debugPrint('Check Login Error: ${e.message}');
    } catch (e, stackTrace) {
      errorMessage.value = 'حدث خطأ غير متوقع';
      debugPrint('Check Login Error: $e');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

}