import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/product_services.dart';
import '../../../models/product_model.dart';
import '../mobiles/edit.dart';


class EditProductDialog extends StatelessWidget {
  final ProductModel product;

  EditProductDialog({required this.product});

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController(text: product.productName);
    final _priceController = TextEditingController(text: product.price.toString());
    final _categoryController = TextEditingController(text: product.category);
    final _colorController = TextEditingController(text: product.color);
    final _batteryController = TextEditingController(text: product.battery.toString());
    final _quantityController = TextEditingController(text: product.quantity.toString());
    final _brandController = TextEditingController(text: product.brand);
    final _displayController = TextEditingController(text: product.displaySize);
    final _compatibilityController= TextEditingController(text: product.compatibility);
    final _featuresController= TextEditingController(text: product.features);


    return AlertDialog(
      title: Text('Edit Product'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            EditTextField(controller:_nameController, label: 'Product Name'),
            
            EditTextField(controller:_categoryController, label:'Category'),
            EditTextField(controller:_brandController, label:'Brand'),
            EditTextField(controller:_displayController, label:'Display Size'),
            EditTextField(controller:_batteryController, label:'Battery Life (mAh)', keyboardType:TextInputType.number),
            EditTextField(controller:_compatibilityController, label:'Compatibility'),
            EditTextField(controller:_colorController, label:'Color'),
            EditTextField(controller:_featuresController, label:'Features'),
            EditTextField(controller:_priceController, label:'Price', keyboardType:TextInputType.number),
            EditTextField(controller:_quantityController, label:'Quantity', keyboardType:TextInputType.number),
           
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final updatedProduct = ProductModel(
              productId: product.productId,
              productName: _nameController.text,
              category: _categoryController.text,
              brand: _brandController.text,
              image: product.image,
              displaySize: _displayController.text,
              battery: _batteryController.text,
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
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

}