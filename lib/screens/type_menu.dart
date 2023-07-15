import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_haven/controllers/CategorySearchController.dart';
import 'package:recipe_haven/controllers/HomeController.dart';

class TypeMenu extends StatelessWidget {
  CategorySearchController _categorySearchController = Get.find();
  HomeController _homeController = Get.find();
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        try {
          _categorySearchController.GetMoreByUri(
              _categorySearchController.MyProducts['_links']['next']['href']);
        } catch (e) {
          Get.showSnackbar(const GetSnackBar(
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3),
            message: "No more items to show!",
          ));
        }
      }
    });
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
            child: Obx(
              () => Column(
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
                          _categorySearchController.GetAgain(value);
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
                    margin:
                        const EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    child: Text(
                      "${_categorySearchController.Title} Recipes",
                      style: context.textTheme.displayLarge!.copyWith(
                        fontSize: 30,
                        color: _homeController.IsDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  !_categorySearchController.loading.value &&
                          _categorySearchController.MyProducts['hits'].length ==
                              0
                      ? Container(
                          margin: const EdgeInsets.only(top: 150),
                          child: Center(
                              child: Text(
                            "No Recipes Found!!",
                            style: context.textTheme.bodyLarge!
                                .copyWith(fontSize: 32),
                          )),
                        )
                      : Expanded(
                          child: GridView.builder(
                          controller: _scrollController,
                          itemCount: _categorySearchController
                                  .MyProducts['hits']?.length ??
                              10,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4.0,
                                  childAspectRatio: 250 / 430,
                                  mainAxisSpacing: 10.0),
                          itemBuilder: (context, index) {
                            return _categorySearchController.loading.value
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    width: 200,
                                    child: const Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.black,
                                    )),
                                  )
                                : LayoutBuilder(
                                    builder: (context, constraints) {
                                      final availableHeight =
                                          constraints.maxHeight;

                                      return Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        width: 200,
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed("/recipepage",
                                                arguments:
                                                    _categorySearchController
                                                            .MyProducts['hits']
                                                        [index]);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    width: double.infinity,
                                                    height: availableHeight *
                                                        0.5, // Adjust the height as needed
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        colorFilter:
                                                            const ColorFilter
                                                                .mode(
                                                          Colors.black26,
                                                          BlendMode.darken,
                                                        ),
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                          _categorySearchController
                                                                          .MyProducts[
                                                                      'hits'][index]
                                                                  [
                                                                  'recipe']['images']
                                                              [
                                                              'REGULAR']['url'],
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topLeft:
                                                            Radius.circular(15),
                                                        topRight:
                                                            Radius.circular(15),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: availableHeight *
                                                        0.1, // Adjust the position as needed
                                                    left: 5,
                                                    right: 1,
                                                    child: Text(
                                                      _categorySearchController
                                                              .MyProducts['hits']
                                                                  [index]
                                                                  ['recipe']
                                                                  ['label']
                                                              .toString()
                                                              .contains(":")
                                                          ? _categorySearchController
                                                              .MyProducts['hits']
                                                                  [index]
                                                                  ['recipe']
                                                                  ['label']
                                                              .toString()
                                                              .split(": ")[1]
                                                          : _categorySearchController
                                                                      .MyProducts['hits']
                                                                  [index]
                                                              ['recipe']['label'],
                                                      style: context.textTheme
                                                          .displaySmall!
                                                          .copyWith(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 5, left: 5, right: 5),
                                                width: double.infinity,
                                                height: availableHeight *
                                                    0.42, // Adjust the height as needed
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "cals : ${_categorySearchController.MyProducts['hits'][index]['recipe']['calories'].toInt()}",
                                                      style: context.textTheme
                                                          .displaySmall!
                                                          .copyWith(
                                                        color: Colors
                                                            .grey.shade900,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .orange.shade600,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Text(
                                                        _categorySearchController
                                                                .MyProducts[
                                                                    'hits']
                                                                    [index]
                                                                    ['recipe']
                                                                    ['dishType']
                                                                    ?[0]
                                                                ?.toString() ??
                                                            "No Dish type",
                                                        softWrap: false,
                                                        style: context.textTheme
                                                            .displaySmall!
                                                            .copyWith(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                          },
                        )),
                ],
              ),
            ),
          ),
        ));
  }
}
