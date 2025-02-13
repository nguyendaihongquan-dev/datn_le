import 'package:flutter/material.dart';


class HeaderButton extends StatelessWidget {
  final String? icon;
  final void Function()? onPressed;
  final Widget? childWidget;
  final double? iconWidth;
  final double? iconHeight;
  final bool? mini;
  final Color? iconColor;
  final Color? backGroundColor;

  const HeaderButton(
      {super.key,
      this.icon,
      required this.onPressed,
      this.childWidget,
       this.iconWidth,
       this.iconHeight,
      this.mini,
      this.iconColor,
      this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: mini ?? false,
      heroTag: null,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      backgroundColor: backGroundColor ?? Colors.transparent,
      onPressed: onPressed,
      child: Container(
        child: icon == null
            ? childWidget
            : Image.asset(
                icon!,
                color: iconColor,
                width: iconWidth,
                height: iconHeight,
              ),
      ),
    );
  }
}
