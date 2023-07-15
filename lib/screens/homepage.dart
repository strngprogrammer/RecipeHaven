import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_haven/controllers/HomeController.dart';

class HomePage extends StatelessWidget {
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () => _homeController.OnRefresh(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                  margin: const EdgeInsets.only(
                      left: 10, bottom: 10, top: 10, right: 15),
                  child: TextField(
                    expands: false,
                    controller: _homeController.textEditingController,
                    onSubmitted: (value) {
                      if (value != "") {
                        Get.toNamed('/searchCategory', arguments: value);
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _homeController.IsDark.value
                                    ? Colors.white
                                    : Colors.black),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 10),
                  child: Text(
                    'Top Ricpes',
                    style: context.textTheme.displayLarge!.copyWith(
                      fontSize: 30,
                      color: _homeController.IsDark.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 360,
                  child: MyListView(),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: context.textTheme.displayLarge!.copyWith(
                          fontSize: 30,
                          color: _homeController.IsDark.value
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/allcategories');
                        },
                        child: Text(
                          "see more",
                          style: context.textTheme.displayLarge!.copyWith(
                            fontSize: 16,
                            color: _homeController.IsDark.value
                                ? Colors.white54
                                : Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                MyCategories()
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget MyCategories() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      height: 200,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed('/searchCategory',
                    arguments: _homeController.Categories[index]['name']);
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
                        style: context.textTheme.displayLarge!.copyWith(
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
          itemCount: _homeController.Categories.length > 5
              ? 5
              : _homeController.Categories.length),
    );
  }

  Widget MyListView() {
    return Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _homeController.loading.value
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15)),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  width: 200,
                  height: 250,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15)),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  width: 200,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed("/recipepage",
                          arguments: _homeController.Products['hits'][index]);
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
                                    _homeController.Products['hits'][index]
                                        ['recipe']['images']['REGULAR']['url'],
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
                                  _homeController.Products['hits'][index]
                                              ['recipe']['label']
                                          .toString()
                                          .contains(":")
                                      ? _homeController.Products['hits'][index]
                                              ['recipe']['label']
                                          .toString()
                                          .split(": ")[1]
                                      : _homeController.Products['hits'][index]
                                          ['recipe']['label'],
                                  style: context.textTheme.displaySmall!
                                      .copyWith(color: Colors.white))),
                        ]),
                        Container(
                          margin:
                              const EdgeInsets.only(top: 5, left: 5, right: 5),
                          width: double.infinity,
                          height: 90,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "cals : ${_homeController.Products['hits'][index]['recipe']['calories'].toInt()}",
                                style: context.textTheme.displaySmall!
                                    .copyWith(color: Colors.grey.shade900),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.orange.shade600,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  _homeController.Products['hits'][index]
                                          ['recipe']['dishType'][0]
                                      .toString(),
                                  softWrap: false,
                                  style: context.textTheme.displaySmall!
                                      .copyWith(
                                          fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
        },
        itemCount: _homeController.loading.value
            ? 5
            : _homeController.Products.length));
  }
}
