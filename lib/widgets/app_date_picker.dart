
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import '../app/dimens/app_dimens.dart';
import '../res/fonts/app_fonts.dart';
import '../res/images/app_images.dart';
import '../theme/app_colors.dart';
import '../utils/app_functions.dart';


class AppDatePicker extends StatelessWidget {
  final String? hint;
  final DateTime? value;
  final Function(DateTime?) onChange;
  final void Function() onCancel;
  final DateTime? curentTime;
  final bool? timePicker;
  final String? title;
  final bool? isRequired;

  const AppDatePicker({super.key,this.isRequired, this.hint, this.value, required this.onChange, required this.onCancel,this.curentTime, this.timePicker, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       title!=null? RichText(
            text:  TextSpan(
                text: title,
                style: const TextStyle(
                    fontFamily: AppFonts.beVietNamPro, fontWeight: FontWeight.w400, color: AppColors.textTertiary,
                    fontSize: AppDimens.textSizeS),
                children: [
                  TextSpan(
                      text: isRequired == true? ' *':'',
                      style: const TextStyle(
                          fontFamily: AppFonts.beVietNamPro, fontWeight: FontWeight.w500, color: AppColors.primary,
                          fontSize: AppDimens.textSizeM))
                ])) : const SizedBox.shrink(),
        title!=null? const SizedBox(height: 4,) : const SizedBox.shrink(),
        InkWell(
          onTap: () {
            timePicker == true?
            DatePicker.showTime12hPicker(context,
                theme:  const picker.DatePickerTheme(
                  backgroundColor: Colors.white,
                  itemStyle: TextStyle(
                      fontFamily: AppFonts.beVietNamPro, fontWeight: FontWeight.w500, color: AppColors.textSecondary,
                      fontSize: AppDimens.textSizeM),
                  doneStyle: TextStyle(
                      fontFamily: AppFonts.beVietNamPro, fontWeight: FontWeight.w500, color: AppColors.greenText,
                      fontSize: AppDimens.textSizeM),
                  cancelStyle: TextStyle(
                      fontFamily: AppFonts.beVietNamPro, fontWeight: FontWeight.w500, color: AppColors.redText,
                      fontSize: AppDimens.textSizeM),
                ),
                showTitleActions: true,
                //  onChanged: (date) => onChange(date),
                onConfirm: (date) => onChange(date),
                onCancel: onCancel,
                currentTime: curentTime??DateTime.now(),
                locale: LocaleType.vi):
            DatePicker.showDatePicker(context,
                theme: const picker.DatePickerTheme(
                  backgroundColor: Colors.white,
                  itemStyle: TextStyle(
                      fontFamily: AppFonts.beVietNamPro, fontWeight: FontWeight.w500, color: AppColors.textSecondary,
                      fontSize: AppDimens.textSizeM),
                  doneStyle: TextStyle(
                      fontFamily: AppFonts.beVietNamPro, fontWeight: FontWeight.w500, color: AppColors.greenText,
                      fontSize: AppDimens.textSizeM),
                  cancelStyle: TextStyle(
                      fontFamily: AppFonts.beVietNamPro, fontWeight: FontWeight.w500, color: AppColors.redText,
                      fontSize: AppDimens.textSizeM),
                ),
                showTitleActions: true,
                minTime: DateTime(1900),
                maxTime: DateTime.now(),
              //  onChanged: (date) => onChange(date),
                onConfirm: (date) => onChange(date),
                onCancel: onCancel,
                currentTime: curentTime??DateTime.now(),
                locale: LocaleType.vi);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                    color: AppColors.black.withOpacity(0.1),
                     ),),
            child: Row(
              children: [
                Text(
                  (value == null) ? hint ?? "" : ( timePicker == true? AppFunctions.formatTimePick(value!) : AppFunctions.formatDatePick(value!)), maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  style:  TextStyle(
                      fontFamily: AppFonts.beVietNamPro, fontWeight: FontWeight.w400, color: (value == null) ? AppColors.hintText : AppColors.textPrimary,
                      fontSize:14),
                ),
                const Spacer(),
                const SizedBox(width: 6),
                timePicker == true? Image.asset(
                  AppImages.iconClock,
                    height: 16,
                    width: 16,
                  color: AppColors.textSecondary,
                ): Image.asset(
                  AppImages.iconCalender,
                  height: 16,
                  width: 16,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
