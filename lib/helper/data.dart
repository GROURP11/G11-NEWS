import 'package:news1/model/category_model.dart';

import 'package:flutter/material.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category =
      [] /* new List<CategoryModel>.empty(growable: true) */;
  CategoryModel categoryModel = new CategoryModel();

  String tmpUrl =
      "https://images.unsplash.com/photo-1548697143-6a9dc9d9d80f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YmxhY2slMjBzb2xpZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60";

  // 1
  categoryModel.categoryName = "Business";
  categoryModel.imageUrl = tmpUrl;
  category.add(categoryModel);

  //2
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryModel.imageUrl = tmpUrl;
  category.add(categoryModel);

  //3
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Health";
  categoryModel.imageUrl = tmpUrl;
  category.add(categoryModel);

  //4
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Science";
  categoryModel.imageUrl = tmpUrl;
  category.add(categoryModel);

  //5
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Sports";
  categoryModel.imageUrl = tmpUrl;
  category.add(categoryModel);

  //6
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryModel.imageUrl = tmpUrl;
  category.add(categoryModel);

  return category;
}
