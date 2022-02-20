import 'package:flutter/material.dart';

class WinnerDialog extends StatelessWidget {
  const WinnerDialog({
    Key? key,
    this.Title,
    this.content,
    required this.callback,
    this.actionText = 'reset',
  }) : super(key: key);
  //
  final Title;
  final content;
  final VoidCallback callback;
  final actionText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: callback,
          child: Text(actionText),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        )
      ],
    );
  }
}
