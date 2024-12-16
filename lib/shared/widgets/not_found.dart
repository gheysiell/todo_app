import 'package:todo_app/shared/palette.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotFoundComponent extends StatelessWidget {
  final String title;
  final BuildContext contextArg;
  final double? padding;
  final double? heightBody;
  final double? heightPaddingBottom;

  const NotFoundComponent({
    super.key,
    required this.contextArg,
    required this.title,
    this.padding,
    this.heightBody,
    this.heightPaddingBottom,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        height: (heightBody ?? 0) - (padding ?? 0),
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 20 + (heightPaddingBottom ?? 0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              alignment: Alignment.center,
              height: 270,
              child: Lottie.asset(
                './assets/animations/woman_with_box.json',
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Palette.silver,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
