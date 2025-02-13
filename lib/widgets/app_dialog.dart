import 'package:flutter/material.dart';
import '../app/dimens/app_dimens.dart';
import '../res/fonts/app_fonts.dart';
import '../theme/app_colors.dart';
import 'double_button_widget.dart';

class AppDialog extends StatelessWidget {
  final String? title;
  final String? textButtonLeft;
  final String? textButtonRight;
  final Widget? content;
  final bool scrollable;
  final bool centerTitle;
  final void Function()? onTapLeft;
  final void Function()? onTapRight;
  final EdgeInsetsGeometry? contentPadding;

  const AppDialog({
    super.key,
    required this.title,
    required this.textButtonLeft,
    required this.textButtonRight,
    required this.content,
    this.scrollable = false,
    this.onTapLeft,
    this.onTapRight,
    this.centerTitle = true,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      title: (title != null)
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xffFFF4F0),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Text(
                title ?? "",
                textAlign: centerTitle ? TextAlign.center : TextAlign.left,
              ),
            )
          : null,
      titleTextStyle:  const TextStyle(
        fontFamily: AppFonts.beVietNamPro,
        fontWeight: FontWeight.w600,
        fontSize: AppDimens.headingXS,
        color: AppColors.textPrimary,
      ),
      scrollable: scrollable,
      backgroundColor: Colors.white,
      content: Container(
        padding: contentPadding ?? const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: content,
      ),
      actionsPadding: const EdgeInsets.all(0),
      actions: [
        DoubleButtonWidget(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
          onTapLeft: onTapLeft,
          onTapRight: onTapRight,
          textLeft: textButtonLeft ?? "Cancel",
          textRight: textButtonRight ?? "Oke",
        ),
      ],
    );
  }
}
