import 'package:flutter/foundation.dart';
import 'package:ungunseen/models/demp_model.dart';

class DemoProdiver with ChangeNotifier {
  // Data
  List<DemoModel> demoModels = [
    DemoModel(name: 'Doramon', amount: 12.34, dateTime: DateTime.now()),
    DemoModel(name: 'Nopita', amount: 1.34, dateTime: DateTime.now()),
  ];

  // Get Data
  List<DemoModel> getDemoProvider() {
    return demoModels;
  }

  // Add Data
  void addDemoProvider(DemoModel demoModel) {
    // demoModels.add(demoModel);

    demoModels.insert(0, demoModel);

    notifyListeners();
  }
}
