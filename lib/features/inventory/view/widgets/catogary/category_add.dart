import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/core/constants/color.dart';
import '../../../controller/category_Service.dart';
import '../../../models/category_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController categoryNameController = TextEditingController();
  dynamic _image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          _image = result.files.first.bytes;
        });
      } else {
        print('No image selected.');
      }
    } else {
      var pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
  }

  Future<void> addCategory() async {
    if (categoryNameController.text.isEmpty || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Please provide a category name and select an image.')),
      );
      return;
    }
    final newCategory = CategoryModel(
      categoryId: DateTime.now().millisecondsSinceEpoch,
      categoryName: categoryNameController.text,
      image: '',
    );

    dynamic imageData = kIsWeb ? _image : (_image as File).path;
    await Provider.of<CategoryService>(context, listen: false)
        .addCategory(newCategory, imageData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Category Added')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ConstC.getColor(AppColor.textC1),
        backgroundColor: ConstC.getColor(AppColor.appBar),
        title: Text(
          'Add Category',
          style: TextStyle(
            color: ConstC.getColor(AppColor.textC1),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              TextField(
                controller: categoryNameController,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: getImage,
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: ConstC.getColor(AppColor.text)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _image == null
                      ? Center(
                          child: Icon(Icons.add_a_photo,
                              size: 40, color: ConstC.getColor(AppColor.text)),
                        )
                      : kIsWeb
                          ? Image.memory(
                              _image,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _image,
                              fit: BoxFit.cover,
                            ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          ConstC.getColor(AppColor.buttonBackground2),
                      foregroundColor: ConstC.getColor(AppColor.textC1),
                      fixedSize: Size(100, 50),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: addCategory,
                    child: Text('Add'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ConstC.getColor(AppColor.background1),
                      foregroundColor: ConstC.getColor(AppColor.textC1),
                      fixedSize: Size(100, 50),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
