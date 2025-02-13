import 'package:flutter/material.dart';
import '../res/fonts/app_fonts.dart';
import '../theme/app_colors.dart';
import 'app_button.dart';


class NormalDialog extends StatelessWidget {
  final String? title;
  final Widget? customTitle;
  final String? textConfirm;
  final String? textCancel;
  final Widget? description;
  final double? sizeImage;
  final String? image;
  final void Function()? onPressConfirm;
  final void Function()? onPressCancel;
  final bool? canScroll;
  final bool? dialogDismiss;
  final bool? hasWhiteConfirm;
  final bool? hasWhiteCancel;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? colorButtonConfirm;

  const NormalDialog(
      {super.key,
        this.title,
        this.onPressConfirm,
        this.canScroll,
        this.dialogDismiss,
        this.description,
        this.textConfirm,
        this.image,
        this.customTitle,
        this.backgroundColor,
        this.textCancel,
        this.onPressCancel,
        this.colorButtonConfirm,
        this.titleColor, this.hasWhiteConfirm, this.hasWhiteCancel, this.sizeImage});

  closePopup(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<bool> onWillPop() {
    return Future.value(dialogDismiss ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>  Navigator.of(context, rootNavigator: true).pop(),
      child: AlertDialog(
        elevation: 0,
        backgroundColor: AppColors.background,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: backgroundColor ?? const Color(0xffFFFFFF),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              title != null ? const SizedBox(height: 10,) : const SizedBox.shrink(),
              title == null
                  ? customTitle == null
                  ? const SizedBox.shrink()
                  : customTitle!
                  : Align(
                alignment: Alignment.center,
                child: Text(
                  title ?? "Thông báo",
                  textAlign: TextAlign.center,
                  style: AppFonts.be500(18, titleColor ?? AppColors.primary),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  image == null
                      ? const SizedBox.shrink()
                      : SizedBox(
                      height: sizeImage ?? 120,
                      child: Image.asset(
                        image!,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(height: image == null ? 0 : 20),
                  (description != null || textConfirm != null || textCancel != null)
                      ? const SizedBox(height: 24)
                      : const SizedBox.shrink(),
                  description == null
                      ? const SizedBox.shrink()
                      : canScroll == true
                      ? Flexible(
                      child: SingleChildScrollView(
                          padding: const EdgeInsets.only(bottom: 24), child: description!))
                      : description!,
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      textCancel == null
                          ? const SizedBox.shrink()
                          : Flexible(
                        child: AppButton(
                          text: textCancel ?? "Hủy",
                          type: ButtonType.secondary,
                          onPressed: onPressCancel ?? () => closePopup(context),
                        ),
                      ),
                      (textConfirm != null && textCancel != null) ? const SizedBox(width: 8) : const SizedBox.shrink(),
                      textConfirm == null
                          ? const SizedBox.shrink()
                          : Flexible(
                        child: AppButton(
                          text: textConfirm ?? "Đồng ý",
                          type: ButtonType.primary,
                          onPressed: onPressConfirm ?? () => closePopup(context),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
