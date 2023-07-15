import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_haven/controllers/HomeController.dart';

class SettingsPage extends StatelessWidget {
  HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Obx(
      () => ListView(
        children: [
          Container(
            alignment: Alignment.center,
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 50, bottom: 50),
            child: Text(
              "Settings",
              style: context.textTheme.displayLarge!.copyWith(
                  fontSize: 40,
                  color: _homeController.IsDark.value
                      ? Colors.white
                      : Colors.black87),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.all(5),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              tileColor: _homeController.IsDark.value
                  ? Colors.grey.shade800
                  : Colors.grey.shade300,
              title: Text(
                _homeController.IsDark.value
                    ? "change to light mode"
                    : "change to dark mode",
                style: context.textTheme.displayMedium!.copyWith(
                    fontSize: 20,
                    color: _homeController.IsDark.value
                        ? Colors.white
                        : Colors.black),
              ),
              leading: Icon(
                _homeController.IsDark.value
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color:
                    _homeController.IsDark.value ? Colors.white : Colors.black,
              ),
              trailing: Switch(
                value: _homeController.IsDark.value,
                onChanged: (value) {
                  _homeController.ToggleTheme(value);
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: _homeController.IsDark.value
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15)),
            child: ExpansionTile(
              backgroundColor: _homeController.IsDark.value
                  ? Colors.grey.shade800
                  : Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Text(
                "Diet settings",
                style: context.textTheme.displayMedium!.copyWith(
                    fontSize: 20,
                    color: _homeController.IsDark.value
                        ? Colors.white
                        : Colors.black),
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Balanced",
                      style:
                          context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                    ),
                    Checkbox(
                      value: _homeController.dietBalanced.value,
                      onChanged: (value) {
                        _homeController.dietBalanced.value = value!;
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "High Fiber",
                      style:
                          context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                    ),
                    Checkbox(
                      value: _homeController.dietHighFiber.value,
                      onChanged: (value) {
                        _homeController.dietHighFiber.value = value!;
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "High Protein",
                      style:
                          context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                    ),
                    Checkbox(
                      value: _homeController.dietHighProtein.value,
                      onChanged: (value) {
                        _homeController.dietHighProtein.value = value!;
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Low Carb",
                      style:
                          context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                    ),
                    Checkbox(
                      value: _homeController.dietLowCarb.value,
                      onChanged: (value) {
                        _homeController.dietLowCarb.value = value!;
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Low Fat",
                      style:
                          context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                    ),
                    Checkbox(
                      value: _homeController.dietLowFat.value,
                      onChanged: (value) {
                        _homeController.dietLowFat.value = value!;
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Low Sodium",
                      style:
                          context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                    ),
                    Checkbox(
                      value: _homeController.dietLowSodium.value,
                      onChanged: (value) {
                        _homeController.dietLowSodium.value = value!;
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: _homeController.IsDark.value
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15)),
            child: ExpansionTile(
                backgroundColor: _homeController.IsDark.value
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                title: Text(
                  "Health settings",
                  style: context.textTheme.displayMedium!.copyWith(
                      fontSize: 20,
                      color: _homeController.IsDark.value
                          ? Colors.white
                          : Colors.black),
                ),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Alcohol free",
                        style:
                            context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                      ),
                      Checkbox(
                        value: _homeController.healthFreeAlcohol.value,
                        onChanged: (value) {
                          _homeController.healthFreeAlcohol.value = value!;
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Egg free",
                        style:
                            context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                      ),
                      Checkbox(
                        value: _homeController.healthEggFree.value,
                        onChanged: (value) {
                          _homeController.healthEggFree.value = value!;
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Fish free",
                        style:
                            context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                      ),
                      Checkbox(
                        value: _homeController.healthFishFree.value,
                        onChanged: (value) {
                          _homeController.healthFishFree.value = value!;
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Gluten free",
                        style:
                            context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                      ),
                      Checkbox(
                        value: _homeController.healthGlutenFree.value,
                        onChanged: (value) {
                          _homeController.healthGlutenFree.value = value!;
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No Oil",
                        style:
                            context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                      ),
                      Checkbox(
                        value: _homeController.healthNoOil.value,
                        onChanged: (value) {
                          _homeController.healthNoOil.value = value!;
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vegetarian",
                        style:
                            context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                      ),
                      Checkbox(
                        value: _homeController.healthVegetarian.value,
                        onChanged: (value) {
                          _homeController.healthVegetarian.value = value!;
                        },
                      ),
                    ],
                  ),
                ]),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(8))),
                onPressed: () {
                  _homeController.SaveSettings();
                },
                child: Text(
                  "save",
                  style: context.textTheme.displayMedium!
                      .copyWith(color: Colors.white),
                )),
          )
        ],
      ),
    ));
  }
}
