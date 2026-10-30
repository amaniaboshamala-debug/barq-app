
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getx_controller/onboarding_controller.dart';

class LanguageSwitcher extends StatelessWidget {
  LanguageSwitcher({super.key});

  final OnboardingController controller =
  Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isArabic = controller.currentLanguage.value == 'ar';

      return Container(
        width: 100,
        height: 40,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            _languageItem(
              label: 'EN',
              selected: !isArabic,
              onTap: () => controller.changeLanguageTo('en'),
            ),
            _languageItem(
              label: 'ع',
              selected: isArabic,
              onTap: () => controller.changeLanguageTo('ar'),
            ),
          ],
        ),
      );
    });
  }

  Widget _languageItem({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF171717) : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
