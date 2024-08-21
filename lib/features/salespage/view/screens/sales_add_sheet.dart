import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/features/inventory/controller/product_services.dart';
import 'package:yuvix/features/inventory/models/product_model.dart';
import 'package:yuvix/features/salespage/controller/sales_service.dart';
import 'package:yuvix/core/constants/color.dart';
import 'package:yuvix/features/salespage/model/sales_item_model.dart';
import 'package:yuvix/features/salespage/view/widget/bottom_sheet.dart';
import 'package:intl/intl.dart';

class SalesAddPage extends StatefulWidget {
  @override
  _SalesAddPageState createState() => _SalesAddPageState();
}

class _SalesAddPageState extends State<SalesAddPage> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _customerNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  String? _selectedProduct;
  List<SalesItemModel> _salesList = [];

  @override
  void initState() {
    super.initState();
    _dateController.text = _formatDate(DateTime.now());
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd.MMM.yyyy').format(date);
  }

  void _clearProductFields() {
    setState(() {
      _selectedProduct = null;
      _quantityController.clear();
      _priceController.clear();
    });
  }

  void _addProduct() {
    final productName = _selectedProduct;
    final quantity = int.tryParse(_quantityController.text) ?? 0;
    final pricePerUnit = double.tryParse(_priceController.text) ?? 0.0;
    final totalPrice = quantity * pricePerUnit;

    if (productName == null || quantity <= 0 || pricePerUnit <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the fields correctly')),
      );
      return;
    }

    final productService = Provider.of<ProductService>(context, listen: false);

    final currentProduct = productService.products.firstWhere(
      (product) => product.productName == productName,
      orElse: () => ProductModel(
          productId: -1,
          productName: productName,
          category: '',
          quantity: 0,
          price: 0,
          color: '',
          brand: ''),
    );

    if (currentProduct.productId == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product not found in inventory')),
      );

      return;
    }

    if (currentProduct.quantity! < quantity) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Not enough quantity in inventory')),
      );
      return;
    }

    final updatedQuantity = currentProduct.quantity! - quantity;

    final updatedProduct = ProductModel(
      productId: currentProduct.productId,
      productName: currentProduct.productName,
      category: currentProduct.category,
      quantity: updatedQuantity,
      price: currentProduct.price,
      color: currentProduct.color,
      brand: currentProduct.brand,
      camera: currentProduct.camera,
      compatibility: currentProduct.compatibility,
      features: currentProduct.features,
      material: currentProduct.material,
      processor: currentProduct.processor,
      ram: currentProduct.ram,
      storage: currentProduct.storage,
      battery: currentProduct.battery,
      networkConnectivity: currentProduct.networkConnectivity,
      displaySize: currentProduct.displaySize,
      image: currentProduct.image,
    );
    productService.updateProduct(updatedProduct);

    setState(() {
      _salesList.add(SalesItemModel(
        productName: productName,
        quantity: quantity,
        pricePerUnit: pricePerUnit,
        totalPrice: totalPrice,
        categoryName: currentProduct.category,
      ));
    });
    _clearProductFields();
  }

  void _submitSales() {
    final date = _dateController.text;
    final customerName = _customerNameController.text;
    final mobileNumber = _mobileNumberController.text;

    if (date.isEmpty || customerName.isEmpty || mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the customer details')),
      );
      return;
    }

    if (_salesList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please add at least one product')),
      );
      return;
    }

    double totalAmount =
        _salesList.fold(0.0, (sum, item) => sum + item.totalPrice);

    Provider.of<SalesProvider>(context, listen: false).saveSales(
      date: date,
      customerName: customerName,
      mobileNumber: mobileNumber,
      totalAmount: totalAmount,
      salesList: _salesList,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sales details saved successfully')),
    );

    setState(() {
      _salesList.clear();
      _customerNameController.clear();
      _mobileNumberController.clear();
      _clearProductFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalAmount =
        _salesList.fold(0.0, (sum, item) => sum + item.totalPrice);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: ConstC.getColor(AppColor.textC1),
        title: Text('Sales Add Page',
            style: TextStyle(color: ConstC.getColor(AppColor.textC1))),
        backgroundColor: ConstC.getColor(AppColor.appBar),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: ConstC.getColor(AppColor.background1),
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          labelStyle: TextStyle(
                              color: ConstC.getColor(AppColor.textC1)),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today,
                                color: ConstC.getColor(AppColor.icon1)),
                            onPressed: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (selectedDate != null) {
                                setState(() {
                                  _dateController.text =
                                      _formatDate(selectedDate);
                                });
                              }
                            },
                          ),
                        ),
                        style:
                            TextStyle(color: ConstC.getColor(AppColor.textC1)),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _customerNameController,
                        decoration: InputDecoration(
                          labelText: 'Customer Name',
                          labelStyle: TextStyle(
                              color: ConstC.getColor(AppColor.textC1)),
                        ),
                        style:
                            TextStyle(color: ConstC.getColor(AppColor.textC1)),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _mobileNumberController,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(
                              color: ConstC.getColor(AppColor.textC1)),
                        ),
                        keyboardType: TextInputType.phone,
                        style:
                            TextStyle(color: ConstC.getColor(AppColor.textC1)),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: ConstC.getColor(AppColor.background1),
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller:
                            TextEditingController(text: _selectedProduct),
                        decoration: InputDecoration(
                          labelText: 'Select Product',
                          labelStyle: TextStyle(
                              color: ConstC.getColor(AppColor.textC1)),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.arrow_drop_down,
                                color: ConstC.getColor(AppColor.icon1)),
                            onPressed: () => _showProductSelectionBottomSheet(),
                          ),
                        ),
                        readOnly: true,
                        style:
                            TextStyle(color: ConstC.getColor(AppColor.textC1)),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          labelStyle: TextStyle(
                              color: ConstC.getColor(AppColor.textC1)),
                        ),
                        keyboardType: TextInputType.number,
                        style:
                            TextStyle(color: ConstC.getColor(AppColor.textC1)),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          labelStyle: TextStyle(
                              color: ConstC.getColor(AppColor.textC1)),
                        ),
                        keyboardType: TextInputType.number,
                        style:
                            TextStyle(color: ConstC.getColor(AppColor.textC1)),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: _addProduct,
                          child: Text('Add Product'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_salesList.isNotEmpty)
                Card(
                  color: ConstC.getColor(AppColor.background1),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _salesList.length,
                          itemBuilder: (context, index) {
                            final sale = _salesList[index];
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Delete Confirmation"),
                                      content: Text(
                                          "Are you sure you want to delete this item?"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: Text("Delete"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              onDismissed: (direction) {
                                setState(() {
                                  _salesList.removeAt(index);

                                  totalAmount = _salesList.fold(
                                      0, (sum, item) => sum + item.totalPrice);
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("${sale.productName} deleted")),
                                );
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      sale.productName,
                                      style: TextStyle(
                                          color:
                                              ConstC.getColor(AppColor.textC1)),
                                    ),
                                    Text(
                                      'Qty: ${sale.quantity}',
                                      style: TextStyle(
                                          color:
                                              ConstC.getColor(AppColor.textC1)),
                                    ),
                                    Text(
                                      '₹${sale.totalPrice}',
                                      style: TextStyle(
                                          color:
                                              ConstC.getColor(AppColor.textC1)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        Divider(color: ConstC.getColor(AppColor.textC1)),
                        Text(
                          'Total Amount: ₹$totalAmount',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ConstC.getColor(AppColor.textC1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _clearProductFields();
                      setState(() {
                        _salesList.clear();
                      });
                    },
                    child: Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: ConstC.getColor(AppColor.textC1),
                      backgroundColor:
                          ConstC.getColor(AppColor.buttonBackground2),
                      fixedSize: Size(110, 50),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitSales();
                    },
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: ConstC.getColor(AppColor.textC1),
                      backgroundColor: ConstC.getColor(AppColor.background1),
                      fixedSize: Size(110, 50),
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

  void _showProductSelectionBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ProductSelectionBottomSheet(
          onProductSelected: (product, quantity) {
            setState(() {
              _selectedProduct = product.productName;
              _priceController.text = product.price.toString();
              _quantityController.text = quantity.toString();
            });
          },
        );
      },
    );
  }
}
