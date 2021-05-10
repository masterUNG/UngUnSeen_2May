import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ungunseen/providers/demp_provider.dart';
import 'package:ungunseen/states/add_post.dart';
import 'package:ungunseen/states/authen.dart';
import 'package:ungunseen/states/form_add_provider.dart';
import 'package:ungunseen/states/home_demo_provider.dart';
import 'package:ungunseen/states/my_service.dart';
import 'package:ungunseen/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/myService': (BuildContext context) => MyService(),
  '/addPost': (BuildContext context) => AddPost(),
  '/demoProvider': (BuildContext context) => HomeDemoProvider(),
  '/formAddProdiver':(BuildContext context)=>FormAddProvider(),
};

String initialRout;

main() {
  initialRout = '/demoProvider';
  runApp(MyApp());
}

// Future<Null> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   String user = preferences.getString('user');
//   if (user?.isEmpty ?? true) {
//     initialRout = '/authen';
//     runApp(MyApp());
//   } else {
//     initialRout = '/myService';
//     runApp(MyApp());
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return DemoProdiver();
          },
        )
      ],
      child: MaterialApp(
        title: MyConstant.appName,
        routes: map,
        initialRoute: initialRout,
        // home: MyService(),
      ),
    );
  }
}
