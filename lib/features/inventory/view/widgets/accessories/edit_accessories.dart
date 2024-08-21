import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/features/inventory/view/widgets/mobiles/edit.dart';
import '../../../controller/product_services.dart';
import '../../../models/product_model.dart';

class EditAccessories extends StatelessWidget {
  final ProductModel product;

  EditAccessories({required this.product});

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController(text: product.productName);
    final _priceController =
        TextEditingController(text: product.price.toString());
    final _categoryController = TextEditingController(text: product.category);
    final _colorController = TextEditingController(text: product.color);
    final _compatibilityController =
        TextEditingController(text: product.compatibility);
    final _quantityController =
        TextEditingController(text: product.quantity.toString());
    final _brandController = TextEditingController(text: product.brand);
    final _materialController = TextEditingController(text: product.material);
    final _featuresController = TextEditingController(text: product.features);

    return AlertDialog(
      title: Text('Edit Product'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
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
            EditTextField(
                controller: _compatibilityController, label: 'Compatibility'),
            EditTextField(controller: _materialController, label: 'Material'),
            EditTextField(controller: _featuresController, label: 'Features'),
            EditTextField(controller: _colorController, label: 'Color'),
            EditTextField(
                controller: _priceController,
                label: 'Price',
                keyboardType: TextInputType.number),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final updatedProduct = ProductModel(
              productId: product.productId,
              productName: _nameController.text,
              brand: _brandController.text,
              compatibility: _compatibilityController.text,
              material: _materialController.text,
              features: _featuresController.text,
              image: Provider.of<ProductService>(context, listen: false)
                      .imageFile
                      ?.path ??
                  product.image,
              category: _categoryController.text,
              quantity: int.parse(_quantityController.text),
              color: _colorController.text,
              price: double.parse(_priceController.text),
            );

            Provider.of<ProductService>(context, listen: false)
                .updateProduct(updatedProduct);

            Navigator.pop(context);
          },
          child: Text('Update'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, 1);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
