import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungunseen/models/user_model.dart';
import 'package:ungunseen/utility/dialog.dart';
import 'package:ungunseen/utility/my_constant.dart';
import 'package:ungunseen/widgets/show_authen_image.dart';
import 'package:ungunseen/widgets/show_title.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double size;
  String user, password;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  width: size * 0.8,
                  child: ShowAuthenImage(),
                ),
                ShowTitle(
                  title: MyConstant.appName,
                  indexStyle: 0,
                ),
                buildUser(),
                buildPassword(),
                buildLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            print('## user = $user, password = $password');
            cheackAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Future<Null> cheackAuthen() async {
    String urlAPI =
        '${MyConstant.domain}/ungunseen/getUserWhereUser.php?isAdd=true&user=$user';

    await Dio().get(urlAPI).then(
      (value) async {
        print('value = $value');
        if (value.toString() == 'null') {
          normalDialog(context, 'User False !!!', 'No $user in my Database');
        } else {
          for (var map in json.decode(value.data)) {
            UserModel model = UserModel.fromMap(map);
            if (password == model.password) {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setString('user', user);
              preferences.setString('name', model.name);

              Navigator.pushNamedAndRemoveUntil(
                  context, '/myService', (route) => false);
            } else {
              normalDialog(
                  context, 'Password False', 'Please Try Again Password False');
            }
          }
        }
      },
    ).catchError(
      (onError) {},
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        onSaved: (newValue) => user = newValue.trim(),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'User is Null or Empty';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'User :',
          prefixIcon: Icon(Icons.perm_identity),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: size * 0.6,
      child: TextFormField(
        onSaved: (newValue) => password = newValue.trim(),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'Please Fill Password';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Password :',
          prefixIcon: Icon(Icons.lock_outlined),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
