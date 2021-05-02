import 'package:flutter/material.dart';
import 'package:ungunseen/widgets/show_authen_image.dart';

Future<Null> normalDialog(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: ShowAuthenImage(),
        title: Text(title),
        subtitle: Text(message),
      ),children: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
    ),
  );
}
