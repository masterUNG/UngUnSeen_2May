import 'package:flutter/foundation.dart';
import 'package:ungunseen/models/demp_model.dart';

class DemoProdiver with ChangeNotifier {
  List<DemoModel> demoModels = [
    DemoModel(name: 'Doramon', amount: 12.34, dateTime: DateTime.now())
  ];

  List<DemoModel> getDemoProvider() {
    return demoModels;
  }

  void addDemoProvider(DemoModel demoModel) {
    demoModels.add(demoModel);
  }
}
