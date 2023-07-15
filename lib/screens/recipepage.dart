import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:recipe_haven/controllers/HomeController.dart';
import 'package:recipe_haven/controllers/RecipeController.dart';

class RecipePage extends StatelessWidget {
  final RecipeController _recipeController = Get.find();
  final HomeController _homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: _homeController.IsDark.value ? Colors.white : Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Obx(() => Text(
              _recipeController.argumentData['recipe']['label'],
              style: TextStyle(
                  color: _homeController.IsDark.value
                      ? Colors.white
                      : Colors.black,
                  fontSize: 28),
            )),
      ),
      body: SafeArea(
          child: Scrollbar(
              child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              _recipeController.argumentData['recipe']['images']
                                  ['REGULAR']['url']))),
                ),
                Obx(() => Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                          color: _homeController.MyFavorites.contains(
                                  _recipeController.argumentData)
                              ? Colors.deepOrange
                              : Colors.black,
                          icon: const Icon(
                            Icons.favorite,
                            size: 28,
                          ),
                          onPressed: () {
                            _homeController.MyFavorites.contains(
                                    _recipeController.argumentData)
                                ? _homeController.RemoveFromStorage(
                                    _recipeController.argumentData)
                                : _homeController.AddToStorage(
                                    _recipeController.argumentData);
                          },
                        ),
                      ),
                    ))
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 130,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.greenAccent.shade700,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.av_timer,
                            color: Colors.white,
                            size: 32,
                          ),
                          Text(
                            _recipeController.argumentData['recipe']
                                    ['totalTime']
                                .toString(),
                            style: context.textTheme.titleMedium!
                                .copyWith(color: Colors.white, fontSize: 18),
                          )
                        ]),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.greenAccent.shade700,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "meal Type : ",
                            style: context.textTheme.titleMedium!
                                .copyWith(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            _recipeController.argumentData['recipe']['mealType']
                                    [0]
                                .toString(),
                            style: context.textTheme.titleMedium!
                                .copyWith(color: Colors.white, fontSize: 16),
                          )
                        ]),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 15),
              child: Text(
                "Ingredients",
                style: context.textTheme.displayLarge!.copyWith(
                  fontSize: 30,
                  color: _homeController.IsDark.value
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              height: 200,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      child: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        child: Text((index + 1).toString()),
                      ),
                    ),
                    title: Text(
                      _recipeController.argumentData['recipe']
                          ['ingredientLines'][index],
                      style: context.textTheme.displayLarge!.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                itemCount: _recipeController
                    .argumentData['recipe']['ingredientLines'].length,
              ),
            ),
            for (var item in _recipeController.argumentData['recipe']
                ['ingredients'])
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                  height: 300,
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  (_recipeController.argumentData['recipe']
                                                  ['ingredients']
                                              .indexOf(item) +
                                          1)
                                      .toString(),
                                  style:
                                      context.textTheme.displayLarge!.copyWith(
                                    fontSize: 32,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(item['image']))),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10)),
                          margin:
                              const EdgeInsets.only(top: 15, left: 5, right: 5),
                          child: Text(
                            item['text'],
                            style: context.textTheme.displaySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10)),
                          margin:
                              const EdgeInsets.only(top: 15, left: 5, right: 5),
                          child: Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            "Food Type : ${item['food']} ",
                            style: context.textTheme.displaySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.only(
                                top: 15, left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "quantity : ${item['quantity']} ",
                                  style: context.textTheme.displaySmall!
                                      .copyWith(color: Colors.white),
                                ),
                                Text(
                                  "weight : ${item['weight'].toStringAsFixed(2)} ",
                                  style: context.textTheme.displaySmall!
                                      .copyWith(color: Colors.white),
                                ),
                              ],
                            ))
                      ]))
          ],
        ),
      ))),
    );
  }
}
