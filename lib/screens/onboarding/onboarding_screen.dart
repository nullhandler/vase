import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vase/colors.dart';
import 'package:vase/screens/home/home_screen.dart';
import 'package:vase/screens/user/user_controller.dart';
import 'package:vase/widgets/focused_layout.dart';
import 'package:vase/widgets/wrapper.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
        child: FocusedLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Text(
              "Vase",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: SvgPicture.asset(
                "assets/img/onboarding.svg",
                height: 280,
                width: 280,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Simplify, track and control \nyour finance',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Vase is a powerful personal expense manager app designed to simplify your financial tracking and give you full control over your expenses.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Get.dialog(AlertDialog(
                      title: const Text("TLDR - Instructions."),
                      content: const Text(
                          "1. Start by adding accounts\n2. Followed by adding a category\n3. You can then add transactions\n4. Simplify , Track and Control :)"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              userController.updateOnboarding();
                              Get.off(()=> const HomeScreen());
                            },
                            child: const Text(
                              "Take me there !!",
                              style: TextStyle(color: AppColors.accentColor),
                            )),
                      ],
                    ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Get Started",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
