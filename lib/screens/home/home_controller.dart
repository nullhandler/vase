import 'package:get/get.dart';
import 'package:vase/enums.dart';

class HomeController extends GetxController {
  final Rx<HomeState> currentState = HomeState.transactions.obs;
}
