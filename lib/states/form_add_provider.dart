import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ungunseen/models/demp_model.dart';
import 'package:ungunseen/providers/demp_provider.dart';
import 'package:ungunseen/utility/dialog.dart';
import 'package:ungunseen/widgets/show_authen_image.dart';

class FormAddProvider extends StatefulWidget {
  @override
  _FormAddProviderState createState() => _FormAddProviderState();
}

class _FormAddProviderState extends State<FormAddProvider> {
  String name, amountString;

  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Add'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildSizedBox(),
              ShowAuthenImage(),
              buildName(),
              buildAmount(),
              buildAdd()
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBox() {
    return SizedBox(
      height: 50,
    );
  }

  Container buildAdd() {
    return Container(
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  name = nameController.text;
                  amountString = amountController.text;

                  DemoModel model = DemoModel(
                    name: name,
                    amount: double.parse(amountString),
                    dateTime: DateTime.now(),
                  );

                  DemoProdiver prodiver =
                      Provider.of<DemoProdiver>(context, listen: false);
                  prodiver.addDemoProvider(model);
                  Navigator.pop(context);
                }
              },
              child: Text('Add')),
        ],
      ),
    );
  }

  Container buildName() {
    return Container(
      width: 250,
      child: TextFormField(
        controller: nameController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Name not Empty';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Name :',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Container buildAmount() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: 250,
      child: TextFormField(
        controller: amountController,
        validator: (value) {
          if (value.isEmpty) {
            return 'Amount not Empty';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Amount :',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
