import 'package:barq_ui/barq_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx_controller/onboarding_controller.dart';
import '../../widget/custom_page_indicator.dart';
import '../../widget/language_switcher.dart';
import '../../widget/on_boarding_content.dart';

class OnBoardingScreen extends StatelessWidget {
  final OnboardingController onboardingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20,),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: LanguageSwitcher(),
          ),
          Expanded(
            child: PageView(
              physics: BouncingScrollPhysics(),
              onPageChanged: (int currentPage) {
                onboardingController.changePage(currentPage);
              },
              children: [
                OnBoardingContent(
                  imageName: 'images/on_boarding1.png',
                  title: 'onboarding_title_1'.tr,
                  subTitle: 'onboarding_subtitle_1'.tr,
                ),
                OnBoardingContent(
                  imageName: 'images/on_boarding2.png',
                  title: 'onboarding_title_2'.tr,
                  subTitle: 'onboarding_subtitle_2'.tr,
                ),
                OnBoardingContent(
                  imageName: 'images/on_boarding3.png',
                  title: 'onboarding_title_3'.tr,
                  subTitle: 'onboarding_subtitle_3'.tr,
                ),
              ],
            ),
          ),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPageIndicator(
                  isCurrentIndex: onboardingController.currentPage.value == 0,
                  marginEnd: 8,
                ),
                CustomPageIndicator(
                  isCurrentIndex: onboardingController.currentPage.value == 1,
                  marginEnd: 8,
                ),
                CustomPageIndicator(
                  isCurrentIndex: onboardingController.currentPage.value == 2,
                ),
              ],
            );
          }),
          SizedBox(height: 72),
          Obx(() {
            final isLastPage =
                onboardingController.currentPage.value == 2;

            return Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
              child: BarqButton(

                label: isLastPage ? 'start_now'.tr : 'next'.tr,
                variant: BarqButtonVariant.primary,
                onPressed: () {
                  if (isLastPage) {
                    onboardingController.finishOnboarding();
                    Get.offAllNamed('/login');
                  } else {
                    // الانتقال للصفحة التالية
                    onboardingController.changePage(
                      onboardingController.currentPage.value + 1,
                    );
                  }
                },
              ),
            );
          }),
          SizedBox(height: 72),

        ],
      ),
    );
  }
}
