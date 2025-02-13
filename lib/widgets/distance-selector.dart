import 'package:flutter/material.dart';

import '../res/fonts/app_fonts.dart';
import '../theme/app_colors.dart';

class DistanceSelector extends StatefulWidget {
  final double initialValue;
  final double min;
  final double max;
  final Function(int) onChanged;

  const DistanceSelector({
    Key? key,
    this.initialValue = 100,
    this.min = 0,
    this.max = 200,
    required this.onChanged,
  }) : super(key: key);

  @override
  _DistanceSelectorState createState() => _DistanceSelectorState();
}

class _DistanceSelectorState extends State<DistanceSelector> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: Text("Khoảng cách ưu tiên", style: AppFonts.be500(12, AppColors.dark3))),
             const SizedBox(width: 8,),
            Text(
              '${_currentValue.round()} km',
                style: AppFonts.be400(14, AppColors.textPrimary)
            ),
          ],
        ),
        const SizedBox(height: 4,),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.primary,
             inactiveTrackColor: Colors.black.withOpacity(0.1),
            thumbColor: Colors.white,
            trackHeight: 2.0,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 8.0,
            ),
            overlayColor: Colors.white.withOpacity(0.2),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: 16.0,
            ),
          ),
          child: Slider(
            value: _currentValue,
            min: widget.min,
            max: widget.max,
            onChanged: (value) {
              setState(() {
                _currentValue = value;
              });
              widget.onChanged(value.round());
            },
          ),
        ),
      ],
    );
  }
}
