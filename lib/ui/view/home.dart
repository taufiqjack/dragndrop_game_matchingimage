import 'package:dragndrop/core/viewmodel/data.dart';
import 'package:dragndrop/ui/resources/string.dart';
import 'package:dragndrop/ui/widget/cardStackWidget.dart';
import 'package:dragndrop/ui/widget/dragTargetWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_BAR_TITLE),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CardStackWidget(),
              Padding(
                padding: EdgeInsets.all(16),
                child: DragTargetWidget(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Provider.of<Data>(context).initializeDraggableList();
            Provider.of<Data>(context).changeSuccesDrop(false);
          },
          elevation: 2,
          label: const Text('Reset')),
    );
  }
}
