import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recipe_haven/main.dart';
import 'package:recipe_haven/services/RecipeApi.dart';

class HomeController extends GetxController {
  RxMap<dynamic, dynamic> Products = {}.obs;
  RxBool loading = false.obs;
  RxList MyFavorites = [].obs;
  RxBool IsDark = false.obs;
  RxBool dietBalanced = false.obs;
  RxBool dietHighFiber = false.obs;
  RxBool dietHighProtein = false.obs;
  RxBool dietLowCarb = false.obs;
  RxBool dietLowFat = false.obs;
  RxBool dietLowSodium = false.obs;

  RxBool healthFreeAlcohol = false.obs;
  RxBool healthEggFree = false.obs;
  RxBool healthFishFree = false.obs;
  RxBool healthGlutenFree = false.obs;
  RxBool healthNoOil = false.obs;
  RxBool healthVegetarian = false.obs;

  TextEditingController textEditingController = TextEditingController();
  RxList Categories = [
    {
      'name': "arabic",
      "image-url":
          "https://media.istockphoto.com/id/1175505781/photo/arabic-and-middle-eastern-dinner-table-hummus-tabbouleh-salad-fattoush-salad-pita-meat-kebab.webp?b=1&s=170667a&w=0&k=20&c=jJcxIb1PSbQ6pH3RjQVd4luCe4ixYqRM9HSriJfWaZc="
    },
    {
      'name': "german",
      "image-url":
          "https://blog.wego.com/wp-content/uploads/Schnitzel_qfryve.jpg"
    },
    {
      'name': "burgers",
      "image-url":
          "https://www.tastingtable.com/img/gallery/what-makes-restaurant-burgers-taste-different-from-homemade-burgers-upgrade/l-intro-1662064407.jpg"
    },
    {
      'name': "pizza",
      "image-url":
          "https://hips.hearstapps.com/hmg-prod/images/classic-cheese-pizza-recipe-2-64429a0cb408b.jpg?crop=0.6666666666666667xw:1xh;center,top&resize=1200:*"
    },
    {
      'name': "sandwich",
      "image-url":
          "https://food-images.files.bbci.co.uk/food/recipes/tiktok_breakfast_42301_16x9.jpg"
    },
    {
      'name': "indian",
      "image-url":
          "https://sandinmysuitcase.com/wp-content/uploads/2021/01/Popular-Indian-Food-Dishes.jpg.webp"
    },
    {
      'name': "Turkish",
      "image-url":
          "https://www.bodrumnyc.com/hubfs/Imported_Blog_Media/Turkish-Food.jpg"
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();

    loading.value = true;

    GetStorage().read("isdark") == null
        ? IsDark.value = false
        : IsDark.value = GetStorage().read("isdark");

    var f = GetStorage().read("favorites");

    if (f != null) {
      MyFavorites.value = f;
    }

    var dietsettings = GetStorage().read("DietSettings");

    if (dietsettings == null) {
      GetStorage().write("DietSettings", {
        "balanced": false,
        "HighFiber": false,
        "HighProtein": false,
        "LowCarb": false,
        "LowFat": false,
        "LowSodium": false
      });
    } else {
      dietBalanced.value = dietsettings['balanced'];
      dietHighFiber.value = dietsettings['HighFiber'];
      dietHighProtein.value = dietsettings['HighProtein'];
      dietLowCarb.value = dietsettings['LowCarb'];
      dietLowFat.value = dietsettings['LowFat'];
      dietLowSodium.value = dietsettings['LowSodium'];
    }

    var healthSettings =
        GetStorage().read("healthSettings"); // { "balanced":true,"" }

    if (healthSettings == null) {
      GetStorage().write("healthSettings", {
        "alcoholFree": false,
        "eggFree": false,
        "fishFre": false,
        "glutenFree": false,
        "noOil": false,
        "vegetarian": false
      });
    } else {
      healthFreeAlcohol.value = healthSettings['alcoholFree'];
      healthEggFree.value = healthSettings['eggFree'];
      healthFishFree.value = healthSettings['fishFre'];
      healthGlutenFree.value = healthSettings['glutenFree'];
      healthNoOil.value = healthSettings['noOil'];
      healthVegetarian.value = healthSettings['vegetarian'];
    }
    GetStorage().save();

    GetRandomRecipes().then((value) {
      Products.value = value;
    });

    loading.value = false;
  }

  void RemoveFromStorage(Map<dynamic, dynamic> recipe) {
    MyFavorites.remove(recipe);
    GetStorage().write("favorites", MyFavorites);
    GetStorage().save();
  }

  // ignore: non_constant_identifier_names
  void AddToStorage(Map<dynamic, dynamic> recipe) {
    MyFavorites.add(recipe);
    GetStorage().write("favorites", MyFavorites);
    GetStorage().save();
  }

  void ToggleTheme(bool value) {
    GetStorage().write("isdark", value);
    GetStorage().save();
    Get.changeTheme(
        GetStorage().read('isdark') == true ? myThemeDark : myTheme);
    IsDark.value = value;
    update();

    refresh();
  }

  void SaveSettings() {
    GetStorage().write("DietSettings", {
      "balanced": dietBalanced.value,
      "HighFiber": dietHighFiber.value,
      "HighProtein": dietHighProtein.value,
      "LowCarb": dietLowCarb.value,
      "LowFat": dietLowFat.value,
      "LowSodium": dietLowSodium.value
    });
    GetStorage().write("healthSettings", {
      "alcoholFree": healthFreeAlcohol.value,
      "eggFree": healthEggFree.value,
      "fishFre": healthFishFree.value,
      "glutenFree": healthGlutenFree.value,
      "noOil": healthNoOil.value,
      "vegetarian": healthVegetarian.value
    });
    GetStorage().save();
    Get.showSnackbar(const GetSnackBar(
      duration: Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
      message: "Saved Settings",
    ));

    update();
    refresh();
  }

  Future<void> OnRefresh() {
    loading.value = true;

    GetStorage().read("isdark") == null
        ? IsDark.value = false
        : IsDark.value = GetStorage().read("isdark");

    var f = GetStorage().read("favorites");

    if (f != null) {
      MyFavorites.value = f;
    }

    var dietsettings = GetStorage().read("DietSettings");

    if (dietsettings == null) {
      GetStorage().write("DietSettings", {
        "balanced": false,
        "HighFiber": false,
        "HighProtein": false,
        "LowCarb": false,
        "LowFat": false,
        "LowSodium": false
      });
    } else {
      dietBalanced.value = dietsettings['balanced'];
      dietHighFiber.value = dietsettings['HighFiber'];
      dietHighProtein.value = dietsettings['HighProtein'];
      dietLowCarb.value = dietsettings['LowCarb'];
      dietLowFat.value = dietsettings['LowFat'];
      dietLowSodium.value = dietsettings['LowSodium'];
    }

    var healthSettings =
        GetStorage().read("healthSettings"); // { "balanced":true,"" }

    if (healthSettings == null) {
      GetStorage().write("healthSettings", {
        "alcoholFree": false,
        "eggFree": false,
        "fishFre": false,
        "glutenFree": false,
        "noOil": false,
        "vegetarian": false
      });
    } else {
      healthFreeAlcohol.value = healthSettings['alcoholFree'];
      healthEggFree.value = healthSettings['eggFree'];
      healthFishFree.value = healthSettings['fishFre'];
      healthGlutenFree.value = healthSettings['glutenFree'];
      healthNoOil.value = healthSettings['noOil'];
      healthVegetarian.value = healthSettings['vegetarian'];
    }
    GetStorage().save();

    loading.value = false;

    return GetRandomRecipes().then((value) {
      Products.value = value;
    });
  }
}
