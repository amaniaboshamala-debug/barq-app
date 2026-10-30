
import 'package:barq_ui/barq_ui.dart';
import 'package:flutter/material.dart';
class CustomPageIndicator extends StatelessWidget {
  const CustomPageIndicator({
    super.key,
    this.marginEnd=0,
    required this.isCurrentIndex,
  });
  final double marginEnd;
  final bool isCurrentIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: marginEnd),
      width: isCurrentIndex? 25 : 10,
      height: 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:isCurrentIndex
        ? BarqColors.primary
        : BarqColors.border,
      ),
    );
  }
}
