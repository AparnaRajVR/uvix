
import 'package:flutter/material.dart';
import '../widgets/brand/brand_section.dart';
import '../widgets/catogary/category_section.dart';
import '../widgets/product/other/silver_widget.dart';

class InventoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildSliverAppBar(context),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategorySection(),
                    SizedBox(height: 20),
                    BrandSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}