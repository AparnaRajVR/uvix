import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/features/inventory/view/widgets/mobiles/edit.dart';

import '../../../controller/product_services.dart';
import '../../../models/product_model.dart';

class EditProductDialog extends StatelessWidget {
  final ProductModel product;

  EditProductDialog({required this.product});

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController(text: product.productName);
    final _categoryController = TextEditingController(text: product.category);
    final _priceController =
        TextEditingController(text: product.price.toString());

    final _colorController = TextEditingController(text: product.color);
    final _ramController = TextEditingController(text: product.ram.toString());
    final _processorController = TextEditingController(text: product.processor);
    final _cameraController = TextEditingController(text: product.camera);
    final _batteryController =
        TextEditingController(text: product.battery.toString());
    final _storageController =
        TextEditingController(text: product.storage.toString());
    final _quantityController =
        TextEditingController(text: product.quantity.toString());
    final _brandController = TextEditingController(text: product.brand);
    final _displayController = TextEditingController(text: product.displaySize);
    final _networkController =
        TextEditingController(text: product.networkConnectivity);

    return AlertDialog(
      title: Text('Edit Product'),
      content: SingleChildScrollView(
        child: Consumer<ProductService>(
          builder: (context, value, child) => Column(
            children: [
              GestureDetector(
                onTap: () async {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    final imagePath = pickedFile.path;
                    Provider.of<ProductService>(context, listen: false)
                        .editProductImage(File(imagePath));
                  }
                },
                child: product.image != null && product.image!.isNotEmpty
                    ? Image.file(File(product.image!), height: 150, width: 150)
                    : Icon(Icons.add_a_photo, size: 150),
              ),
              EditTextField(controller: _nameController, label: 'Product Name'),
              EditTextField(controller: _categoryController, label: 'Category'),
              EditTextField(controller: _brandController, label: 'Brand'),
              EditTextField(controller: _ramController, label: 'RAM(GB)'),
              EditTextField(
                  controller: _processorController, label: 'Processor'),
              EditTextField(controller: _cameraController, label: 'Camera'),
              EditTextField(
                  controller: _batteryController,
                  label: 'Battery Life (mAh)',
                  keyboardType: TextInputType.number),
              EditTextField(
                  controller: _storageController,
                  label: 'Storage (GB)',
                  keyboardType: TextInputType.number),
              EditTextField(
                  controller: _displayController, label: 'Display Size'),
              EditTextField(
                  controller: _networkController,
                  label: 'Network Connectivity'),
              EditTextField(controller: _colorController, label: 'Color'),
              EditTextField(controller: _quantityController, label: 'Quantity'),
              EditTextField(
                  controller: _priceController,
                  label: 'Price',
                  keyboardType: TextInputType.number),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final productService =
                Provider.of<ProductService>(context, listen: false);
            final updatedProduct = ProductModel(
                productId: product.productId,
                productName: _nameController.text,
                category: _categoryController.text,
                brand: _brandController.text,
                image: Provider.of<ProductService>(context, listen: false)
                        .imageFile
                        ?.path ??
                    product.image,
                displaySize: _displayController.text,
                battery: _batteryController.text,
                quantity: int.parse(_quantityController.text),
                color: _colorController.text,
                price: double.parse(_priceController.text),
                networkConnectivity: _networkController.text,
                processor: _processorController.text,
                camera: _cameraController.text,
                storage: _storageController.text,
                ram: _ramController.text);

            productService.updateProduct(updatedProduct);

            if (product.quantity == 0 && updatedProduct.quantity! > 0) {
              productService.removeFromOutOfStock(updatedProduct);
            }

            Navigator.pop(context);
          },
          child: Text('Update'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
