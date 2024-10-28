import 'package:flutter/material.dart';
import 'package:todo_app/utils/palette.dart';
import 'package:todo_app/utils/styles.dart';

class BottomButtonsDialog extends StatelessWidget {
  final String titleConfirmationButton;
  final void Function() closeDialog;
  final void Function() confirmationHandler;
  final double width;

  const BottomButtonsDialog({
    super.key,
    required this.titleConfirmationButton,
    required this.closeDialog,
    required this.confirmationHandler,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: width > 300 ? 106 : width * 0.34,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButtonStyles.littleButton('cancel'),
            onPressed: () {
              closeDialog();
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Palette.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          width: width > 300 ? 106 : width * 0.34,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButtonStyles.littleButton('confirmation'),
            onPressed: () {
              confirmationHandler();
            },
            child: Text(
              titleConfirmationButton,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Palette.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
