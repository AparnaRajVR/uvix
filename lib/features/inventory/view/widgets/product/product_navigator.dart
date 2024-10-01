import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/features/inventory/view/screens/other_full_details.dart';
import 'package:yuvix/features/inventory/view/widgets/product/product_show_card.dart';

import '../../../../../core/constants/color.dart';
import '../../../controller/product_services.dart';
import '../../../models/product_model.dart';
import '../../screens/accessories_page.dart';
import '../../screens/mobiles_page.dart';
import '../../screens/smartwatch_page.dart';

class ProductNavigator extends StatelessWidget {
  final ProductModel product;

  ProductNavigator({required this.product});

  @override
  Widget build(BuildContext context) {
    return ProductShowCard(
      imageUrl: product.image ?? 'https://via.placeholder.com/150',
      productName: product.productName,
      color: product.color ?? 'Unknown Color',
      price: '₹${product.price.toStringAsFixed(2)}',
      onTap: () {
        if (product.category == 'Mobiles' ||
            product.category == 'Smartphone' ||
            product.category == 'Tablet') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MobilesFullDetailsPage(product: product),
            ),
          );
        } else if (product.category == 'Smartwatch') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SmartwatchPage(
                product: product,
              ),
            ),
          );
        } else if (product.category == 'Accessories') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccessoriesPage(
                product: product,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtherFullDetails(
                product: product,
              ),
            ),
          );
        }
      },
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Delete Product',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text('Are you sure you want to delete this product?'),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Provider.of<ProductService>(context, listen: false)
                              .deleteProduct(product.productId);
                          Navigator.pop(context);
                        },
                        child: Text('Delete'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ConstC.getColor(AppColor.background2)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
