import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx_controller/app_controller.dart';

class LunchScreen extends StatelessWidget {
  const LunchScreen({super.key});

  // الألوان المستخرجة من الصورة
  static const Color primaryOrange = Color(0xFFFA6400); // اللون البرتقالي

  @override
  Widget build(BuildContext context) {
    final AppGetxController controller = Get.find<AppGetxController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 33,),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // صورة اللوجو
                  Obx(() {
                    final store = controller.store.value;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //*****************
                        Container(

                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(


                          ),
                          child: (store?.logoUrl != null && store!.logoUrl!.isNotEmpty) ?
                          Image.network(
                            store.logoUrl!,
                            fit: BoxFit.cover,
                            width: 200,
                            webHtmlElementStrategy: WebHtmlElementStrategy.prefer, // ← السطر الجديد
                            errorBuilder: (context, error, stackTrace) {
                              debugPrint('Logo Error: $error');
                              return Container(
                                color: Colors.white,
                                child: const Icon(
                                  Icons.checkroom_rounded,
                                  color: primaryOrange,
                                  size: 48,
                                ),
                              );
                            },
                          )                              : Container(
                                  color: Colors.white,
                                  child: const Icon(
                                    Icons.checkroom_rounded,
                                    color: primaryOrange,
                                    size: 48,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          store?.name ?? 'برق',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primaryOrange,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                      ],
                    );
                  }),
                  const SizedBox(height: 16),
                ],
              ),
            ),


            Obx(() {
              // عم نحمّل
              if (controller.isLoading.value) {
                return const CircularProgressIndicator(color: primaryOrange);
              }

              // لازم تحديث
              if (controller.updateRequired.value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'يوجد تحديث جديد، يرجى تحديث التطبيق للمتابعة',
                    style: TextStyle(color: primaryOrange, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              // ما في خطأ ← ما نعرض شي
              if (controller.errorMessage.value.isEmpty) {
                return const SizedBox.shrink();
              }

              // في خطأ ← الرسالة + زر إعادة المحاولة
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      controller.errorMessage.value,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: controller.start,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    ),
                    child: const Text(
                      'إعادة المحاولة',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
