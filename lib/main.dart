import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/controllers/db_controller.dart';
import 'package:vase/enums.dart';
import 'package:vase/screens/home/home_screen.dart';
import 'package:vase/screens/onboarding/onboarding_screen.dart';
import 'package:vase/widgets/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      if (darkDynamic != null) {
        AppColors.monetColorScheme = darkDynamic;
      }

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppColors.defaultTheme,
        themeMode: ThemeMode.dark,
        darkTheme:
            darkDynamic != null ? AppColors.monetTheme : AppColors.defaultTheme,
        title: 'Vase',
        home: GetBuilder<DbController>(
          init: DbController(),
          // initState: (state){
          //   state.controller?.initDB();
          // },
          builder: (dbController) {
            return Obx(() {
              if (dbController.isNew.value) {
                return  OnBoardingScreen();
              } else {
                if (dbController.vaseState.value == VaseState.loading) {
                  return const ThemeWrapper(
                    child: Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
                return const ThemeWrapper(child: HomeScreen());
              }
            });
          },
          dispose: (dbController) {
            dbController.dispose();
          },
        ),
      );
    });
  }
}
