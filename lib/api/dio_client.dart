import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import 'api_settings.dart';

/// نسخة Dio وحدة للتطبيق كله، بالترويسات الثابتة.
class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      connectTimeout: ApiSettings.timeout,
      receiveTimeout: ApiSettings.timeout,
      headers: {
        'Accept': 'application/json',
        'Accept-Language': 'ar',
        'X-Project-Key': ApiSettings.projectKey,
        'X-App-Version': '1.0.0', // لازم تطابق نسخة pubspec
      },
    ),
  )..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // إذا في توكن محفوظ بنضيفه تلقائياً لكل طلب
        final String? token = GetStorage().read<String>('token');
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ),
  );

  /// يطلع رسالة الخطأ من رد السيرفر، أو رسالة مناسبة لو ما في إنترنت.
  static String errorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    if (e.response == null) {
      return 'تعذر الاتصال بالخادم، تحقق من الإنترنت';
    }
    return 'حدث خطأ غير متوقع';
  }
}