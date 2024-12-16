import 'package:todo_app/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoaderComponent extends StatelessWidget {
  final bool loaderVisible;

  const LoaderComponent({
    super.key,
    required this.loaderVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: loaderVisible,
      child: Positioned(
        right: 0,
        bottom: 0,
        top: 0,
        left: 0,
        child: Container(
          color: Palette.darkBackground,
          child: const Center(
            child: SizedBox(
              height: 130,
              width: 130,
              child: LoadingIndicator(
                  indicatorType: Indicator.ballScaleMultiple,
                  colors: [
                    Palette.secondary,
                  ],
                  strokeWidth: 2),
            ),
          ),
        ),
      ),
    );
  }
}
