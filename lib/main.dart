import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_haven/controllers/HomeController.dart';
import 'package:recipe_haven/screens/homepage.dart';
import 'package:recipe_haven/screens/recipepage.dart';
import 'package:recipe_haven/screens/showCategories.dart';
import 'package:recipe_haven/screens/tabPage.dart';
import 'package:recipe_haven/screens/type_menu.dart';
import 'package:recipe_haven/services/bindings.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final bool isdark = GetStorage().read('isdark') ?? false;
  runApp(MyApp(isdark: isdark));
}

final ThemeData myTheme = ThemeData(
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
);

final ThemeData myThemeDark = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
);

class MyApp extends StatelessWidget {
  final bool isdark;
  const MyApp({super.key, required this.isdark});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Recipe Haven',
      theme: isdark ? myThemeDark : myTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      initialBinding: myBindings(),
      getPages: [
        GetPage(
          name: '/',
          page: () => TabPages(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/recipepage',
          page: () => RecipePage(),
        ),
        GetPage(
          name: '/allcategories',
          page: () => AllCategories(),
        ),
        GetPage(
          name: '/searchCategory',
          page: () => TypeMenu(),
        )
      ],
    );
  }
}


// [
//  {},
//  {},
//  {},
//  {}
// ]