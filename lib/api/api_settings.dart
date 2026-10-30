
class ApiSettings {
  static const String baseUrl = 'https://masar.toldpath.com/api/v1';
  static const String slag = 'app';
  static const String appConfig = '$baseUrl/$slag/config';


  // استبدلي القيمة بمفتاح مشروع برق الحقيقي
  static const String projectKey = 'pk_test_LorC7wEgkexrrFcPJKhNUlXpA3gZKuJMO7A4cWPI';

  static const Duration timeout = Duration(seconds: 15);

  // إعدادات التطبيق
  static const String appType = 'user';

  static const String uploads = '$baseUrl/v1/uploads';

  static const String sendOtp = '$baseUrl/v1/auth/send-otp';
  static const String verifyOtp = '$baseUrl/v1/auth/verify-otp';
  static const String logout = '$baseUrl/v1/auth/logout';
  static const String me = '$baseUrl/v1/me';
  static const String fcmToken = '$baseUrl/v1/me/fcm-token';

  static const String addresses = '$baseUrl/v1/addresses';

  static String address(int id) => '$baseUrl/v1/addresses/$id';

  static const String categories = '$baseUrl/v1/categories';
  static const String vendors = '$baseUrl/v1/vendors';

  static String vendor(int id) => '$baseUrl/v1/vendors/$id';

  static const String products = '$baseUrl/v1/products';

  static String product(int id) => '$baseUrl/v1/products/$id';

  static const String basketsCompare = '$baseUrl/v1/baskets/compare';
  static const String couponsValidate = '$baseUrl/v1/coupons/validate';

  static const String orders = '$baseUrl/v1/orders';
  static const String ordersQuote = '$baseUrl/v1/orders/quote';
  static const String cancelReasons = '$baseUrl/v1/cancel-reasons';

  static String order(int id) => '$baseUrl/v1/orders/$id';

  static String orderCancel(int id) =>
      '$baseUrl/v1/orders/$id/cancel';

  static String orderEvents(int id) =>
      '$baseUrl/v1/orders/$id/events';

  static String orderOffer(int id) =>
      '$baseUrl/v1/orders/$id/offer';

  static String orderOfferApprove(int id) =>
      '$baseUrl/v1/orders/$id/offer/approve';

  static String orderOfferReject(int id) =>
      '$baseUrl/v1/orders/$id/offer/reject';

  static String orderRate(int id) =>
      '$baseUrl/v1/orders/$id/rate';

  static String orderReceipt(int id) =>
      '$baseUrl/v1/orders/$id/receipt';

  static String orderTracking(int id) =>
      '$baseUrl/v1/orders/$id/tracking';

  static String orderShareLink(int id) =>
      '$baseUrl/v1/orders/$id/share-link';

  static String publicTrack(String token) =>
      '$baseUrl/v1/track/$token';

  static const String notifications = '$baseUrl/v1/notifications';
  static const String notificationsReadAll =
      '$baseUrl/v1/notifications/read-all';

  static String notificationOpened(int id) =>
      '$baseUrl/v1/notifications/$id/opened';

  static const String vendorApplications =
      '$baseUrl/v1/vendor-applications';

  static Map<String, String> headers({
    String? token,
    String lang = 'ar',
    String? appVersion,
  }) {
    return {
      'Accept': 'application/json',
      'Accept-Language': lang,
      'X-Project-Key': projectKey,
      if (appVersion != null) 'X-App-Version': appVersion,
      if (token != null && token.isNotEmpty)
        'Authorization': 'Bearer $token',
    };
  }
}
