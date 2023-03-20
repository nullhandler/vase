import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/enums.dart';
import 'package:vase/screens/home/home_screen.dart';
import 'package:vase/widgets/wrapper.dart';

import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ThemeData.dark(useMaterial3: true).colorScheme.copyWith(
              primary: AppColors.accentColor,
            ),
      ),
      title: 'Vase',
      home: GetBuilder<DbController>(
        init: DbController(),
        // initState: (state){
        //   state.controller?.initDB();
        // },
        builder: (dbController) {
          return Obx(() {
            if (dbController.vaseState.value == VaseState.loading) {
              return const ThemeWrapper(
                child:  Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            return const ThemeWrapper(child:  HomeScreen());
          });
        },
        dispose: (dbController) {
          dbController.dispose();
        },
      ),
    );
  }
}
