import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../app/dimens/app_dimens.dart';
import '../res/fonts/app_fonts.dart';
import '../res/images/app_images.dart';
import '../theme/app_colors.dart';

class SuccessDialog extends StatelessWidget {
  final String? content;

  const SuccessDialog({
    super.key,
    required this.content,
  });

  static Future<void> show(BuildContext context, String? content) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => SuccessDialog(content: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 16,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.white,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Image.asset(
                AppImages.success,
                width: 72,
                height: 72
              ),
            ),
            const Gap(8),
            Text(
              textAlign: TextAlign.center,
              content ?? "Thành công",
              style:  const TextStyle(
                fontFamily: AppFonts.beVietNamPro,
                fontWeight: FontWeight.w600,
                fontSize: AppDimens.textSizeM,
                color: AppColors.success,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
