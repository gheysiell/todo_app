import 'package:flutter/material.dart';
import 'package:todo_app/utils/palette.dart';

class TextFormFieldStyles {
  static TextStyle textStyle() => const TextStyle(
        decorationThickness: 0,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Palette.silver,
      );

  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: Palette.primary,
    ),
    borderRadius: BorderRadius.circular(6),
  );

  static final OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderSide: const BorderSide(
      width: 1,
      color: Palette.silverSoft,
    ),
    borderRadius: BorderRadius.circular(6),
  );

  static TextStyle errorStyle() => const TextStyle(
        color: Palette.mediumRed,
      );

  static InputBorder? errorBorder() => OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: Palette.mediumRed,
        ),
        borderRadius: BorderRadius.circular(6),
      );

  static InputBorder? focusedErrorBorder() => OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1,
          color: Palette.mediumRed,
        ),
        borderRadius: BorderRadius.circular(6),
      );
}

class ElevatedButtonStyles {
  static ButtonStyle littleButton(String confirmationOrCancel) => ButtonStyle(
        padding: const MaterialStatePropertyAll(EdgeInsets.zero),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevation: const MaterialStatePropertyAll(3),
        backgroundColor:
            MaterialStatePropertyAll(confirmationOrCancel == 'confirmation' ? Palette.blue : Palette.secondaryButtons),
        overlayColor:
            MaterialStatePropertyAll(confirmationOrCancel == 'confirmation' ? Palette.blueSoft : Palette.grey400),
      );
}
