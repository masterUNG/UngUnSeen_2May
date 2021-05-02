import 'package:flutter/material.dart';
import 'package:ungunseen/utility/my_constant.dart';

class ShowTitle extends StatelessWidget {
  String title;
  int indexStyle;

  ShowTitle({@required this.title, @required this.indexStyle});

  TextStyle h1Style() => TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: MyConstant.dark);
  TextStyle h2Style() => TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: MyConstant.dark);
  TextStyle h3Style() => TextStyle(fontSize: 14, color: MyConstant.dark);

  @override
  Widget build(BuildContext context) {
    List<TextStyle> textStyles = [
      h1Style(),
      h2Style(),
      h3Style(),
    ];
    return Text(
      title,
      style: textStyles[indexStyle],
    );
  }
}
