import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../provider/loading_provider.dart';
import '../widgets/normal_dialog.dart';

class AppFunctions {
  static showLoading(BuildContext context) {
    context.read<LoadingProvider>().showLoading();
  }

  static hideLoading(BuildContext context) {
    context.read<LoadingProvider>().hideLoading();
  }

  static void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void log(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  static bool isNullEmpty(Object o) => "" == o;

//validate-phone
  static bool checkValidPhone(String phone) {
    // Biểu thức chính quy cho số điện thoại Việt Nam
    String pattern =
        r'^(032|033|034|035|036|037|038|039|096|097|098|086|083|084|085|081|082|088|091|094|070|079|077|076|078|090|093|089|056|058|092|059|099)[0-9]{7}$';
    RegExp regExp = RegExp(pattern);

    // Kiểm tra độ dài và đầu số
    if (phone.length == 10) {
      String firstTwoDigits = phone.substring(0, 2);

      // Điều kiện kiểm tra số
      if (RegExp(r'^[0-9]+$').hasMatch(phone) &&
          ['03', '05', '07', '08', '09'].contains(firstTwoDigits)) {
        // Kiểm tra với biểu thức chính quy
        return regExp.hasMatch(phone);
      }
    }
    return false;
  }

//time otp
  static String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = remainingSeconds.toString().padLeft(2, '0');
    return "$formattedMinutes:$formattedSeconds";
  }

  static String formatDatePick(DateTime input) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(input);
    return formatted;
  }

  static String formatTimePick(DateTime dateTime) {
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');

    return "$hour:$minute";
  }

  static int calculateAge(String birthDateString) {
    try {
      // Định dạng chuỗi ngày tháng năm sinh
      DateFormat dateFormat = DateFormat("dd/MM/yyyy");
      DateTime birthDate = dateFormat.parse(birthDateString);

      // Lấy ngày hiện tại
      DateTime today = DateTime.now();

      // Tính số tuổi
      int age = today.year - birthDate.year;

      // Kiểm tra nếu ngày sinh chưa tới trong năm nay
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      return age;
    } catch (e) {
      // Xử lý lỗi nếu chuỗi đầu vào không hợp lệ
      throw FormatException(
          "Chuỗi ngày tháng không hợp lệ. Định dạng phải là dd/MM/yyyy.");
    }
  }

  // static void log(String text) {
  //   final pattern = RegExp('.{1,800}');
  //   pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  // }

  //show dialog
  static void showDialogAlert(BuildContext context,
      {String? title,
      String? textConfirm,
      String? textCancel,
      Widget? description,
      Widget? customTitle,
      String? image,
      void Function()? onPressConfirm,
      void Function()? onPressCancel,
      bool? hideButtonClose,
      bool? canScroll,
      bool? whiteConfirm,
      bool? whiteCancel,
      Color? backgroundColor,
      Color? titleColor,
      bool? dialogDismiss,
      double? sizeImage,
      Color? colorButtonConfirm}) {
    showDialog(
        barrierDismissible: dialogDismiss ?? true,
        context: context,
        builder: (BuildContext context) {
          return NormalDialog(
            title: title,
            textConfirm: textConfirm,
            description: description,
            image: image,
            hasWhiteCancel: whiteCancel,
            hasWhiteConfirm: whiteConfirm,
            onPressConfirm: onPressConfirm,
            customTitle: customTitle,
            dialogDismiss: dialogDismiss,
            backgroundColor: backgroundColor,
            canScroll: canScroll,
            textCancel: textCancel,
            onPressCancel: onPressCancel,
            titleColor: titleColor,
            sizeImage: sizeImage,
            colorButtonConfirm: colorButtonConfirm,
          );
        });
  }
}

extension ListExtension<T> on List<T> {
  List<T> addBetween(T element, {bool bound = false}) {
    if (length <= 1) {
      return this;
    }
    return [
      if (bound) element,
      ...expand((e) {
        if (e != last) {
          return [e, element];
        } else {
          return [e];
        }
      }),
      if (bound) element,
    ];
  }
}
