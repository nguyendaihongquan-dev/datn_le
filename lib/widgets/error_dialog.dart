import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../app/dimens/app_dimens.dart';
import '../res/fonts/app_fonts.dart';
import '../theme/app_colors.dart';
import '../utils/app_functions.dart';
import 'app_button.dart';

class ErrorDialog extends StatelessWidget {
  final String? content;

  const ErrorDialog({
    super.key,
    required this.content,
  });

  static Future<void> show(BuildContext context, String? content) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ErrorDialog(content: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.white,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.negative.withOpacity(0.8),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error,
              color: AppColors.background,
              size: 80,
            ),
            const Gap(8),
            Text(
              textAlign: TextAlign.center,
              content ?? "Lỗi bất ngờ xảy ra",
              style:  const TextStyle(
                fontFamily: AppFonts.beVietNamPro,
                fontWeight: FontWeight.w600,
                fontSize: AppDimens.textSizeM,
                color: AppColors.background,
              ),
            ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.all(16),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        AppButton(
            text: 'Đóng',
            type: ButtonType.secondary,
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
              AppFunctions.hideKeyboard(context);
            }),
      ],
    );
  }
}
