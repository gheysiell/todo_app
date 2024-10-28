import 'package:flutter/material.dart';
import 'package:todo_app/utils/enums.dart';
import 'package:todo_app/utils/palette.dart';
import 'package:todo_app/widgets/alert_dialog.dart';
import 'package:todo_app/widgets/bottom_buttons_dialog.dart';
import 'package:vibration/vibration.dart';

class Functions {
  static Future<void> showGeneralAlertDialog(
    BuildContext context,
    String message,
    TypeMessageDialog typeMessageDialog,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogWidget(
        title: getTitleMessageDialog(typeMessageDialog),
        subTitle: message,
        icon: Icon(
          getIconMessageDialog(typeMessageDialog),
          size: 30,
          color: getColorMessageDialog(typeMessageDialog),
        ),
      ),
    );
  }

  static Future<bool> dialogConfirmationDanger(
    BuildContext context,
    String textContent,
    double? heightOfContent,
    double width,
  ) async {
    bool cancelHandler = false;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Palette.white,
        surfaceTintColor: Palette.white,
        contentPadding: const EdgeInsets.only(top: 12, bottom: 15, right: 20, left: 20),
        insetPadding: width < 340
            ? const EdgeInsets.only(right: 20, left: 20)
            : EdgeInsets.only(right: width * 0.1, left: width * 0.1),
        title: const Text(
          'Atenção',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Palette.silver,
          ),
        ),
        content: SizedBox(
          height: heightOfContent,
          child: Column(
            children: [
              Text(
                textContent,
                style: const TextStyle(
                  fontSize: 16,
                  color: Palette.silverSoft,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          BottomButtonsDialog(
            titleConfirmationButton: 'Confirmar',
            closeDialog: () => Navigator.pop(context),
            confirmationHandler: () {
              Navigator.pop(context);
              cancelHandler = true;
            },
            width: width,
          )
        ],
        actionsPadding: const EdgeInsets.only(bottom: 20),
        icon: const Icon(
          Icons.warning_amber_rounded,
          size: 30,
          color: Palette.yellow,
        ),
      ),
    );
    return cancelHandler;
  }

  static String getTitleMessageDialog(TypeMessageDialog typeOfMessage) {
    return typeOfMessage == TypeMessageDialog.info
        ? 'Olá'
        : typeOfMessage == TypeMessageDialog.warning
            ? 'Atenção'
            : 'Erro';
  }

  static IconData getIconMessageDialog(TypeMessageDialog typeOfMessage) {
    return typeOfMessage == TypeMessageDialog.info
        ? Icons.info_outline_rounded
        : typeOfMessage == TypeMessageDialog.warning
            ? Icons.warning_amber_rounded
            : Icons.error_outline_rounded;
  }

  static Color getColorMessageDialog(TypeMessageDialog typeOfMessage) {
    return typeOfMessage == TypeMessageDialog.info
        ? Palette.blue
        : typeOfMessage == TypeMessageDialog.warning
            ? Palette.yellow
            : Palette.red;
  }

  static Future<void> vibrate() async {
    Vibration.vibrate();
    final hasVibrator = await Vibration.hasVibrator();

    if (hasVibrator != null && hasVibrator) Vibration.vibrate(duration: 50);
  }
}
