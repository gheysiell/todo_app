import 'package:flutter/material.dart';
import 'package:todo_app/utils/palette.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget icon;  

  const AlertDialogWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Palette.white,
      surfaceTintColor: Palette.white,
      actionsPadding: const EdgeInsets.only(right: 10, bottom: 6),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Palette.silver,
        ),
      ),
      content: Text(
        subTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          color: Palette.silver,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => {
            Navigator.pop(context),            
          },
          style: TextButton.styleFrom(foregroundColor: Palette.blueSoft),
          child: const Text(
            'OK',
            style: TextStyle(color: Palette.blue),
          ),
        )
      ],
      icon: icon,
    );
  }
}
