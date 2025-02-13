import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppCheckBox extends StatelessWidget {
   final bool tap;
   final double? size;
   final Function()? onTap;

  const AppCheckBox (
      {super.key,  this.tap = false, this.onTap, this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ,
      child: Container(
          width:size?? 16,
          height:size?? 16,
          decoration: BoxDecoration(
            color: tap == true ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.fromBorderSide(
              BorderSide(
                  width: 1,
                  color: tap == true
                      ? AppColors.primary
                      : const Color(0xffAFBACA),
                  style: BorderStyle.solid),
            ),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.check,
            size:size!= null? (size!-5) : 12,
            color:Colors.white,
          )),
    );
  }
}
