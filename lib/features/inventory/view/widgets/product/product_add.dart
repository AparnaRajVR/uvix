import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/core/constants/color.dart';
import 'package:yuvix/features/inventory/controller/category_Service.dart';
import 'package:yuvix/features/inventory/view/widgets/product/action_button.dart';
import 'package:yuvix/features/inventory/view/widgets/product/brand_drop_doun.dart';
import 'package:yuvix/features/inventory/view/widgets/product/product_dropdown.dart';
import 'package:yuvix/features/inventory/view/widgets/product/product_textfeild.dart';
import '../../../controller/brand_services.dart';
import '../../../controller/product_services.dart';
import '../../../models/brand_model.dart';
import '../../../models/category_model.dart';
import '../../../models/product_model.dart';
import 'product_conditionalfeild.dart';
import 'product_image.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController ramController = TextEditingController();
  final TextEditingController processorController = TextEditingController();
  final TextEditingController cameraController = TextEditingController();
  final TextEditingController batteryController = TextEditingController();
  final TextEditingController storageController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController displaySizeController = TextEditingController();
  final TextEditingController networkConnectivityController =
      TextEditingController();
  final TextEditingController featuresController = TextEditingController();
  final TextEditingController compatibilityController = TextEditingController();
  final TextEditingController materialController = TextEditingController();

  File? _image;
  String? _selectedBrand;
  String? _selectedType;
  late Future<List<CategoryModel>> _categoriesFuture;
  late Future<List<BrandModel>> _brandsFuture;

  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> addProduct() async {
    if (productNameController.text.isEmpty ||
        _image == null ||
        _selectedType == null ||
        _selectedBrand == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please fill all the fields and select an image.')),
      );
      return;
    }

    final newProduct = ProductModel(
      productId: DateTime.now().millisecondsSinceEpoch,
      productName: productNameController.text,
      category: _selectedType!,
      brand: _selectedBrand!,
      image: _image!.path,
      ram: ramController.text,
      processor: processorController.text,
      camera: cameraController.text,
      battery: batteryController.text,
      storage: storageController.text,
      quantity: int.tryParse(quantityController.text) ?? 0,
      price: double.tryParse(priceController.text) ?? 0.0,
      color: colorController.text,
      displaySize: displaySizeController.text,
      networkConnectivity: networkConnectivityController.text,
      features: featuresController.text,
      compatibility: compatibilityController.text,
      material: materialController.text,
    );

    await Provider.of<ProductService>(context, listen: false)
        .addProduct(newProduct);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product Added')),
    );

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryService().getCategories();
    _brandsFuture = BrandService().getBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ConstC.getColor(AppColor.textC1),
        backgroundColor: ConstC.getColor(AppColor.appBar),
        title: Text(
          'Add Product',
          style: TextStyle(
            color: ConstC.getColor(AppColor.textC1),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductTextFieldWidget(
              controller: productNameController,
              labelText: 'Product Name',
              type: false,
            ),
            SizedBox(height: 20),
            CategoryDropdown(
              categoriesFuture: _categoriesFuture,
              selectedType: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
            ),
            SizedBox(height: 20),
            BrandDropdown(
              brandsFuture: _brandsFuture,
              selectedBrand: _selectedBrand,
              onChanged: (value) {
                setState(() {
                  _selectedBrand = value;
                });
              },
            ),
            SizedBox(height: 20),
            ImagePickerWidget(
              image: _image,
              onTap: getImage,
            ),
            SizedBox(height: 20),
            ConditionalFields(
              selectedType: _selectedType,
              ramController: ramController,
              processorController: processorController,
              cameraController: cameraController,
              batteryController: batteryController,
              storageController: storageController,
              displaySizeController: displaySizeController,
              networkConnectivityController: networkConnectivityController,
              featuresController: featuresController,
              compatibilityController: compatibilityController,
              materialController: materialController,
            ),
            SizedBox(height: 20),
            ProductTextFieldWidget(
              type: true,
              controller: quantityController,
              labelText: 'Quantity',
            ),
            SizedBox(height: 20),
            ProductTextFieldWidget(
              type: false,
              controller: colorController,
              labelText: 'Color',
            ),
            SizedBox(height: 20),
            ProductTextFieldWidget(
              controller: priceController,
              labelText: 'Price',
              type: true,
            ),
            SizedBox(height: 20),
            ActionButtons(
                onCancel: () {
                  Navigator.pop(context);
                },
                onAdd: addProduct),
          ],
        ),
      ),
    );
  }
}
