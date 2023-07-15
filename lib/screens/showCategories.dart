import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_haven/controllers/HomeController.dart';

class AllCategories extends StatelessWidget {
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: _homeController.IsDark.value ? Colors.white : Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Scrollbar(
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  child: Obx(
                    () => Text(
                      "Categories",
                      style: context.textTheme.displayLarge!.copyWith(
                        fontSize: 30,
                        color: _homeController.IsDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: _homeController.Categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/searchCategory',
                              arguments: _homeController.Categories[index]
                                  ['name']);
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          width: 200,
                          child: Stack(
                            children: [
                              Container(
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black38, BlendMode.darken),
                                        fit: BoxFit.cover,
                                        image: NetworkImage(_homeController
                                            .Categories[index]['image-url']))),
                              ),
                              Center(
                                child: Text(
                                  _homeController.Categories[index]['name'],
                                  style:
                                      context.textTheme.displayLarge!.copyWith(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
