import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'app_button.dart';

class DoubleButtonWidget extends StatelessWidget {
  final String textLeft;
  final String textRight;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;

  final void Function()? onTapLeft;
  final void Function()? onTapRight;

  const DoubleButtonWidget({
    super.key,
    required this.textLeft,
    required this.textRight,
    this.borderRadius,
    this.padding,
    this.onTapLeft,
    this.onTapRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: AppColors.textPrimaryInverse,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 16,
            spreadRadius: 0,
            color: const Color(0xffbec9ff).withOpacity(0.25),
          )
        ],
        border:  Border(
          top: BorderSide(
            color: Colors.black.withOpacity(0.05),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              text: textLeft,
              type: ButtonType.secondary,
              onPressed: onTapLeft ?? () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              text: textRight,
              onPressed: onTapRight ?? () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
