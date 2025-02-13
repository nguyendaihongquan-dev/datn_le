
import 'package:flutter/material.dart';
import '../res/fonts/app_fonts.dart';
import '../theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final ButtonType type;
  final Widget? icon;
  final bool? mini;
  final void Function() onPressed;


  const AppButton({
    super.key,
    this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
    this.mini
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: type == ButtonType.primary ? AppColors.primary : type == ButtonType.secondary ? AppColors.light3 : const Color(0xffFFF2F6),
        ),
        padding: mini == true ? const EdgeInsets.symmetric(horizontal: 16,vertical: 12) : const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ?? const SizedBox.shrink(),
            icon!=null? const SizedBox(width: 8,) : const SizedBox.shrink(),
            Flexible(
               child: Text(text??'', maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppFonts.be500(mini == true? 14: 16, type == ButtonType.primary ? AppColors.background : type == ButtonType.secondary ? AppColors.textPrimary : const Color(0xff6C000B))),
            ),
          ],
        ),
      ),
    );
  }
}

enum ButtonType {
  primary,
  secondary,
  tertiary
}
