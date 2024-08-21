import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/core/constants/color.dart';
import 'package:yuvix/features/homepage/view/widgets/filter_dialog.dart';
import 'package:yuvix/features/inventory/controller/product_services.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider =
          Provider.of<ProductService>(context, listen: false);
      productProvider.searchProducts('');
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductService>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstC.getColor(AppColor.appBar),
        elevation: 0,
        iconTheme: IconThemeData(color: ConstC.getColor(AppColor.icon1)),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      productProvider.searchProducts('');
                    },
                  )
                : null,
          ),
          style: TextStyle(
            fontSize: 18.0,
          ),
          onChanged: (query) {
            productProvider.searchProducts(query);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: Consumer<ProductService>(
        builder: (context, provider, child) {
          if (provider.filteredProducts.isEmpty) {
            return Center(
              child: Text(
                _searchController.text.isNotEmpty
                    ? 'No results found'
                    : 'No Product Found',
                style: TextStyle(fontSize: 18.0),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: provider.filteredProducts.length,
              itemBuilder: (context, index) {
                final product = provider.filteredProducts[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          product.image != null && product.image!.isNotEmpty
                              ? FileImage(File(product.image!))
                              : AssetImage('assets/placeholder.png')
                                  as ImageProvider,
                    ),
                    title: Text(
                      product.productName,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Price: ₹${product.price}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog();
      },
    );
  }
}
