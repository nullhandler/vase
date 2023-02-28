import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/enums.dart';
import 'package:vase/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      title: 'Vase',
      home: GetBuilder<DbController>(
        init: DbController(),
        // initState: (state){
        //   state.controller?.initDB();
        // },
        builder: (dbController) {
          return Obx(() {
            if (dbController.vaseState.value == VaseState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const HomeScreen();
          });
        },
        dispose: (dbController) {
          dbController.dispose();
        },
      ),
    );
  }
}
