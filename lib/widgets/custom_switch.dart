
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

typedef OnCheck = Function(bool b);

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key, required this.onCheck,this.height,this.padding,this.initValue});

  final OnCheck onCheck;
  final double? height;
  final double? padding;
  final bool? initValue;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {

  late bool active;

  @override
  void initState() {
    active = widget.initValue ?? false;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.height!=null? 2*(widget.height! - (widget.padding??2)) : 44,
      height: widget.height ?? 24,
      padding:  EdgeInsets.symmetric(horizontal: widget.padding??2),
      decoration: BoxDecoration(
          color: active
              ? AppColors.primary
              : AppColors.textTertiaryInverse,
          borderRadius: BorderRadius.circular(24)),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            setState(() {
              active = !active;
              widget.onCheck.call(active);
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: widget.height!=null? (widget.height! - 2*(widget.padding??2)) : 20,
            height: widget.height!=null? (widget.height! - 2*(widget.padding??2)) : 20,
            margin: EdgeInsets.only(left: active ? (widget.height!=null? (widget.height! - 2*(widget.padding??2)) : 20) : 0),
            decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}
