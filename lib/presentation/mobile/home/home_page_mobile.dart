

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icso_pos/core/assets/assets.gen.dart';
import 'package:icso_pos/core/constants/colors.dart';
import 'package:icso_pos/presentation/home/bloc/local_product/local_product_bloc.dart';
import 'package:icso_pos/presentation/home/models/product_category.dart';
import 'package:icso_pos/presentation/home/models/product_model.dart';
import 'package:icso_pos/presentation/home/widgets/custom_tab_bar.dart';
import 'package:icso_pos/presentation/home/widgets/product_card.dart';

class HomePageMobile extends StatefulWidget {
    const HomePageMobile({super.key});

    @override
    State<HomePageMobile> createState() => _HomePageMobile();
}

class _HomePageMobile extends State<HomePageMobile> {

  List<ProductModel> searchResults = [];
  final List<ProductModel> products = [
    ProductModel(
          image: Assets.images.menu1.path,
          name: 'Express Bowl Ayam Rica',
          category: ProductCategory.food,
          price: 32000,
          stock: 10
    ),
  ];

  @override
  void initState() {
    // searchResults = products;
    searchResults = products;
    super.initState();
  }

  void onCategoryTap(int index) {
    // searchController.clear();
    if (index == 0) {
      searchResults = products;
    } else {
      searchResults = products
          .where((e) => e.category.index.toString().contains(index.toString()))
          .toList();
    }
    setState(() {});
  }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            title: Container(
              height: 35,
              child: TextField(
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none
                  ),
                  hintText: "Search e.g Software Developers",
                  hintStyle: TextStyle(fontSize: 14),

                ),
              ),
            ),
          ),

        );
    }

}
