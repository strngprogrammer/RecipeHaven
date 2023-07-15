import 'package:get/get.dart';
import 'package:recipe_haven/services/RecipeApi.dart';

class CategorySearchController extends GetxController {
  dynamic argumentData = Get.arguments; // pizza

  RxBool loading = false.obs;

  RxMap<dynamic, dynamic> MyProducts = {}.obs;

  // ignore: non_constant_identifier_names
  RxString Title = ''.obs;

  @override
  void onInit() {
    super.onInit();

    Title.value = argumentData;

    loading.value = true;

    GetRecipes(argumentData).then((value) {
      MyProducts.value = value;
      loading.value = false;
    });
  }

  void GetMoreByUri(String uri) {
    GetRecipesByUri(uri).then((value) => {
          MyProducts['hits'].addAll(value['hits']),
          MyProducts['_links'] = value['_links'],
        });
  }

  void GetAgain(String f) {
    loading.value = true;

    GetRecipes(f).then((value) {
      Title.value = f;
      MyProducts.value = value;
      loading.value = false;
    });

    Get.reload();
  }

  // ignore: non_constant_identifier_names
}
