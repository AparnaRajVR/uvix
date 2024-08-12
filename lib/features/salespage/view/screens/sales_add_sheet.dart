import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvix/features/salespage/controller/sales_service.dart';
import 'package:yuvix/core/constants/color.dart';
import 'package:yuvix/features/salespage/model/sales_item_model.dart';
import 'package:yuvix/features/salespage/view/widget/bottom_sheet.dart';

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
    _dateController.text = DateTime.now().toString().split(' ')[0];
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

    setState(() {
      _salesList.add(SalesItemModel(
        productName: productName,
        quantity: quantity,
        pricePerUnit: pricePerUnit,
        totalPrice: totalPrice,
         categoryName: '',
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
        SnackBar(content: Text('Please fill all the fields correctly')),
      );
      return;
    }
    print("@@@,,,,,,,,,,,,,,,,,,,,,,@@${_salesList}");

    double totalAmount = _salesList.fold(0.0, (sum, item) => sum + item.totalPrice);

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
    double totalAmount = _salesList.fold(0.0, (sum, item) => sum + item.totalPrice);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Add Page'),
        backgroundColor: ConstC.getColor(AppColor.appBar),
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
                          labelStyle: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today, color: ConstC.getColor(AppColor.icon1)),
                            onPressed: () async {
                              DateTime? selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (selectedDate != null) {
                                setState(() {
                                  _dateController.text = selectedDate.toString().split(' ')[0];
                                });
                              }
                            },
                          ),
                        ),
                        style: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _customerNameController,
                        decoration: InputDecoration(
                          labelText: 'Customer Name',
                          labelStyle: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                        ),
                        style: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _mobileNumberController,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                        ),
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: ConstC.getColor(AppColor.textC1)),
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
                        controller: TextEditingController(text: _selectedProduct),
                        decoration: InputDecoration(
                          labelText: 'Select Product',
                          labelStyle: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.arrow_drop_down, color: ConstC.getColor(AppColor.icon1)),
                            onPressed: () => _showProductSelectionBottomSheet(),
                          ),
                        ),
                        readOnly: true,
                        style: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _quantityController,
                        decoration: InputDecoration(
                          labelText: 'Quantity',
                          labelStyle: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          labelStyle: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: ConstC.getColor(AppColor.textC1)),
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
                            return ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    sale.productName,
                                    style: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                                  ),
                                  Text(
                                    'Qty: ${sale.quantity}',
                                    style: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                                  ),
                                  Text(
                                    '₹${sale.totalPrice}',
                                    style: TextStyle(color: ConstC.getColor(AppColor.textC1)),
                                  ),
                                ],
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
                      backgroundColor: ConstC.getColor(AppColor.buttonBackground2),
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
}}

