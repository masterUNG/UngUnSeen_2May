import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ungunseen/providers/demp_provider.dart';

class HomeDemoProvider extends StatefulWidget {
  @override
  _HomeDemoProviderState createState() => _HomeDemoProviderState();
}

class _HomeDemoProviderState extends State<HomeDemoProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/formAddProdiver'),
        child: Text('Add'),
      ),
      appBar: AppBar(
        title: Text('Demo Provider'),
      ),
      body: Consumer(
        builder: (context, DemoProdiver demoProdiver, child) =>
            ListView.builder(
          itemCount: demoProdiver.demoModels.length,
          itemBuilder: (context, index) =>
              Text(demoProdiver.getDemoProvider()[index].name),
        ),
      ),
    );
  }
}
