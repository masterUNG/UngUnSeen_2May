import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungunseen/widgets/information.dart';
import 'package:ungunseen/widgets/show_list_post.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  List<String> titles = ['List Post', 'Information'];
  List<Widget> widgets = [
    ShowListPost(),
    Informaion(),
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[index]),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            buildSignOut(),
            Column(
              children: [
                buildUserAccountsDrawerHeader(),
                buildMenuListPost(context),
                buildMenuInformatin(context),
              ],
            ),
          ],
        ),
      ),
      body: widgets[index],
    );
  }

  ListTile buildMenuListPost(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.filter_1),
      title: Text(titles[0]),
      onTap: () {
        setState(() {
          index = 0;
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildMenuInformatin(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.filter_2),
      title: Text(titles[1]),
      onTap: () {
        setState(() {
          index = 1;
        });
        Navigator.pop(context);
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: null,
      accountEmail: null,
    );
  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear();

            Navigator.pushNamedAndRemoveUntil(
                context, '/authen', (route) => false);
          },
          tileColor: Colors.red.shade500,
          leading: Icon(Icons.exit_to_app),
          title: Text('Sign Out'),
        ),
      ],
    );
  }
}
