import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajilo_dokan/config/colors.dart';
import 'package:sajilo_dokan/presentation/pages/Category/category/controller/categories_controller.dart';
import 'package:sajilo_dokan/presentation/pages/Category/category/widgets/category_tile.dart';
import 'package:sajilo_dokan/presentation/widgets/loading_view.dart';

import 'package:sajilo_dokan/presentation/widgets/scaffold.dart';


class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      background: kBackGround,
      hasLeadingIcon: false,
      title: 'Danh mục',
      body: Obx(() {
        return Stack(
          children: [
            if (!controller.isLoadingCategory.value)
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    children: controller.categoriesList.map(
                      (category) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          child: CategoriesTile(
                            onChanged: () {
                              controller.openCategoryProductScreen(category);
                            },
                            category: category,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              )
            else
              Center(
                child: LoadingWidget(),
              ),
          ],
        );
      }),
      bottomMenuIndex: 1,
    );
  }
}
