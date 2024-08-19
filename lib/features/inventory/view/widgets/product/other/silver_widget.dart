
import 'package:flutter/material.dart';
import 'package:yuvix/core/constants/color.dart';
import 'package:yuvix/features/homepage/view/screen/search_filter.dart';
import 'package:yuvix/features/inventory/view/widgets/catogary/add_category_widget.dart';
import 'package:yuvix/features/inventory/view/widgets/product/add_product.dart';
import 'package:yuvix/features/profile/view/Screens/Settings.dart';
import '../../brand/add_brand_card.dart';

Widget buildSliverAppBar(BuildContext context) {
  return SliverAppBar(
    expandedHeight: 300.0,
    flexibleSpace: FlexibleSpaceBar(
      background: Stack(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff281537), Colors.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(27)),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              'UVIX',
              style: TextStyle(
                color: ConstC.getColor(AppColor.textC1),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: Row(
              children: [
                 GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchPage()), 
                    );
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                 SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage('Assets/images/logo.png'),
                    radius: 25,
                  ),
                ),
                
               
              ],
            ),
          ),
          Positioned(
            top: 180,
            left: 17,
            right: 17,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AddCategoryCard(title: 'Category'),
                AddBrandCard(title: 'Brand'),
                AddProductCard(title: 'Product'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
