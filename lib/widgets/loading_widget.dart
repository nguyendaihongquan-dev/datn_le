import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: AppColors.black.withOpacity(0.6),
      child: Center(
          child: Stack(
            children: [
              const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.tertiary,
                  )),
              Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(), // them logo
                  )),
            ],
          )),
    );
  }
}
