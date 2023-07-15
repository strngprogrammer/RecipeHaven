import 'package:get/get.dart';
import 'package:recipe_haven/controllers/CategorySearchController.dart';
import 'package:recipe_haven/controllers/HomeController.dart';
import 'package:recipe_haven/controllers/RecipeController.dart';

class myBindings implements Bindings {
  void dependencies() {
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => RecipeController(), fenix: true);
    Get.lazyPut(() => CategorySearchController(), fenix: true);
  }
}
