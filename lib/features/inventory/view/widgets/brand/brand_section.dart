import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/features/inventory/controller/brand_services.dart';
import 'package:yuvix/features/inventory/models/brand_model.dart';
import 'package:yuvix/features/inventory/view/widgets/brand/brand_card.dart';
import 'package:yuvix/features/inventory/view/widgets/brand/brand_grid.dart';
import 'package:yuvix/features/inventory/view/widgets/product/other/build_section_header.dart';

class BrandSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brandService = Provider.of<BrandService>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildSectionHeaderWidget(
          title: "Brand",
          onSeeMore: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BrandGridView()),
            );
          },
        ),
        SizedBox(height: 10),
        FutureBuilder<List<BrandModel>>(
          future: brandService.getBrands(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text('No brands found');
            } else {
              return SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final brand = snapshot.data![index];
                    return BrandCard(brand: brand);
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
