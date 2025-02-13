import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../app/dimens/app_dimens.dart';
import '../res/fonts/app_fonts.dart';
import '../theme/app_colors.dart';
import 'app_button.dart';

class WarningDialog extends StatelessWidget {
  final String? content;
  final String? textRightButton;
  final void Function() onDelete;

  const WarningDialog({
    super.key,
    required this.content,
    required this.onDelete,
    this.textRightButton,
  });

  static Future<void> show(BuildContext context, String? content, void Function() onDelete, {String? textRightButton}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => WarningDialog(
        content: content,
        onDelete: onDelete,
        textRightButton: textRightButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      backgroundColor: Colors.white,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.negative,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.warning,
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
      actionsPadding: const EdgeInsets.all(20),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                  text: 'Huỷ',
                  type: ButtonType.secondary,
                  onPressed: () => Navigator.of(context, rootNavigator: true).pop()),
            ),
            const Gap(20),
            Expanded(
              child: AppButton(
                text: textRightButton ?? 'Xoá',
                type: ButtonType.primary,
                onPressed: onDelete,
              ),
            ),
          ],
        )
      ],
    );
  }
}
