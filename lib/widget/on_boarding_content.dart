import 'package:barq_ui/barq_ui.dart';
import 'package:flutter/material.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    required this.imageName,
    required this.title,
    required this.subTitle,
    super.key,
  });

  final String imageName;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 80),
        Image.asset(imageName),
        SizedBox(height: 60),

        Text(
          title,
          textAlign: TextAlign.center,
          style:
          TextStyle(
            fontFamily: 'SomarSans',
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: BarqColors.primary,
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 65),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SomarSans',
              fontSize: 15,
              color: BarqColors.primary,
            ),
          ),
        ),
        SizedBox(height: 150),
      ],
    );
  }
}
