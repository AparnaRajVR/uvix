// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:yuvix/features/inventory/controller/category_Service.dart';
// import 'package:yuvix/features/inventory/controller/product_services.dart';
// import 'package:yuvix/features/inventory/models/category_model.dart';
// import 'package:yuvix/features/inventory/models/product_model.dart';

// class ProductSelectionBottomSheet extends StatefulWidget {
//   final Function(ProductModel) onProductSelected;

//   ProductSelectionBottomSheet({required this.onProductSelected});

//   @override
//   _ProductSelectionBottomSheetState createState() => _ProductSelectionBottomSheetState();
// }

// class _ProductSelectionBottomSheetState extends State<ProductSelectionBottomSheet> {
//   TextEditingController _searchController = TextEditingController();
//   String? _selectedCategory;
//   late Future<List<CategoryModel>> _categoriesFuture;

//   @override
//   void initState() {
//     super.initState();
//     _categoriesFuture = Provider.of<CategoryService>(context, listen: false).getCategories();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           FutureBuilder<List<CategoryModel>>(
//             future: _categoriesFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 return DropdownButtonFormField<String>(
//                   value: _selectedCategory,
//                   onChanged: (newValue) async {
//                     setState(() {
//                       _selectedCategory = newValue!;
//                     });
//                     if (_selectedCategory != null) {
//                       await Provider.of<ProductService>(context, listen: false)
//                           .filterProductsByCategory(_selectedCategory!, _searchController.text);
//                     }
//                   },
//                   items: snapshot.data!.map((category) {
//                     return DropdownMenuItem<String>(
//                       value: category.categoryName,
//                       child: Text(category.categoryName!),
//                     );
//                   }).toList(),
//                   decoration: InputDecoration(labelText: 'Select Category'),
//                 );
//               }
//             },
//           ),
//           SizedBox(height: 8.0),
//           TextField(
//             controller: _searchController,
//             decoration: InputDecoration(
//               labelText: 'Search Products',
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () async {
//                   if (_selectedCategory != null) {
//                     await Provider.of<ProductService>(context, listen: false)
//                         .filterProductsByCategory(_selectedCategory!, _searchController.text);
//                   }
//                 },
//               ),
//             ),
//           ),
//           SizedBox(height: 8.0),
//           Expanded(
//             child: Consumer<ProductService>(
//               builder: (context, productService, child) {
//                 return ListView.builder(
//                   itemCount: productService.filteredProducts.length,
//                   itemBuilder: (context, index) {
//                     final product = productService.filteredProducts[index];
//                     return ListTile(
//                       title: Text(product.productName),
//                       subtitle: Text('Price: ${product.price}'),
//                       onTap: () {
//                         widget.onProductSelected(product);
//                         Navigator.pop(context);
//                       },
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/features/inventory/controller/category_Service.dart';
import 'package:yuvix/features/inventory/controller/product_services.dart';
import 'package:yuvix/features/inventory/models/category_model.dart';
import 'package:yuvix/features/inventory/models/product_model.dart';
import 'package:yuvix/features/salespage/controller/sales_service.dart';


class ProductSelectionBottomSheet extends StatefulWidget {
  final Function(ProductModel, int) onProductSelected;

  ProductSelectionBottomSheet({required this.onProductSelected});

  @override
  _ProductSelectionBottomSheetState createState() => _ProductSelectionBottomSheetState();
}

class _ProductSelectionBottomSheetState extends State<ProductSelectionBottomSheet> {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  String? _selectedCategory;
  late Future<List<CategoryModel>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = Provider.of<CategoryService>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<CategoryModel>>(
            future: _categoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  onChanged: (newValue) async {
                    setState(() {
                      selectedcat=newValue;
                      _selectedCategory = newValue;
                      _searchController.clear(); // Clear search text when category changes
                      _quantityController.clear(); // Clear quantity field when category changes
                    });
                    if (_selectedCategory != null) {
                      await Provider.of<ProductService>(context, listen: false)
                          .filterProductsByCategory(_selectedCategory!, _searchController.text);
                    }
                  },
                  items: snapshot.data!.map((category) {
                    return DropdownMenuItem<String>(
                      value: category.categoryName,
                      child: Text(category.categoryName!),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Select Category'),
                );
              }
            },
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search Products',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  if (_selectedCategory != null) {
                    await Provider.of<ProductService>(context, listen: false)
                        .filterProductsByCategory(_selectedCategory!, _searchController.text);
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 8.0),
          TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Quantity',
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: Consumer<ProductService>(
              builder: (context, productService, child) {
                return ListView.builder(
                  itemCount: productService.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = productService.filteredProducts[index];
                    return ListTile(
                      title: Text(product.productName),
                      subtitle: Text('Price: ${product.price}'),
                      onTap: () {
                        final quantity = int.tryParse(_quantityController.text) ?? 1;
                        widget.onProductSelected(product, quantity);
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
