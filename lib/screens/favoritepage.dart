import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_haven/controllers/HomeController.dart';

class FavoritePage extends StatelessWidget {
  HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    // ignore: sized_box_for_whitespace
    return Obx(() => Container(
          width: _size.width,
          height: _size.height,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _homeController.MyFavorites.isEmpty
                  ? const Center(
                      child: Text("No Favorites"),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15)),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      width: 200,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed("/recipepage",
                              arguments: _homeController.MyFavorites[index]);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(children: [
                              Container(
                                width: double.infinity,
                                height: 250,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      colorFilter: const ColorFilter.mode(
                                          Colors.black26, BlendMode.darken),
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        _homeController.MyFavorites[index]
                                                ['recipe']['images']['REGULAR']
                                            ['url'],
                                      ),
                                    ),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                              ),
                              Positioned(
                                  bottom: 30,
                                  left: 5,
                                  right: 1,
                                  child: Text(
                                      _homeController.MyFavorites[index]
                                                  ['recipe']['label']
                                              .toString()
                                              .contains(":")
                                          ? _homeController.MyFavorites[index]
                                                  ['recipe']['label']
                                              .toString()
                                              .split(": ")[1]
                                          : _homeController.MyFavorites[index]
                                              ['recipe']['label'],
                                      style: context.textTheme.displaySmall!
                                          .copyWith(color: Colors.white))),
                            ]),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 5, left: 5, right: 5),
                              width: double.infinity,
                              height: 90,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "cals : ${_homeController.MyFavorites[index]['recipe']['calories'].toInt()}",
                                    style: context.textTheme.displaySmall!
                                        .copyWith(color: Colors.grey.shade900),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.orange.shade600,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      _homeController.MyFavorites[index]
                                              ['recipe']['dishType'][0]
                                          .toString(),
                                      softWrap: false,
                                      style: context.textTheme.displaySmall!
                                          .copyWith(
                                              fontSize: 16,
                                              color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ));
            },
            itemCount: _homeController.MyFavorites.length,
          ),
        ));
  }
}
