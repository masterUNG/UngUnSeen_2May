import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungunseen/states/add_post.dart';
import 'package:ungunseen/states/authen.dart';
import 'package:ungunseen/states/my_service.dart';
import 'package:ungunseen/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/myService': (BuildContext context) => MyService(),
  '/addPost': (BuildContext context) => AddPost(),
};

String initialRout;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String user = preferences.getString('user');
  if (user?.isEmpty ?? true) {
    initialRout = '/authen';
    runApp(MyApp());
  } else {
    initialRout = '/myService';
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initialRout,
      // home: MyService(),
    );
  }
}
