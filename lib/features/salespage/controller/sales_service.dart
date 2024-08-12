
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yuvix/features/salespage/model/sales_model.dart';

import '../model/sales_item_model.dart';

class SalesProvider with ChangeNotifier {
  late Box<SalesModel> _salesBox;
  String? selectedCategory;

  SalesProvider() {
    initializeSalesBox();
  }

  Future<void> initializeSalesBox() async {
    _salesBox = await Hive.openBox<SalesModel>('sales');
    notifyListeners();
  }

 void saveSales({
  required String date,
  required String customerName,
  required String mobileNumber,
  required double totalAmount,
  required List<SalesItemModel> salesList,
}) async {
 
  final salesData = SalesModel(
    date: date,
    customerName: customerName,
    mobileNumber: mobileNumber,
    totalAmount: totalAmount,
    salesList: salesList.toList(),
  );

  // Add the data to the Hive box
  await _salesBox.add(salesData);

  // Print all data from the Hive box
  final allSales = _salesBox.values.toList();
  for (var sale in allSales) {
    print(sale.toString()); // Print the SalesModel instance

    // Print details of each SalesItemModel in the sales list
    for (var item in sale.salesList) {
      print('  ${item.productName} - ₹${item.pricePerUnit.toStringAsFixed(2)} x ${item.quantity}');
    }
  }

  // Notify listeners
  notifyListeners();
}


  List<SalesModel> getAllSales() {

      final allSales = _salesBox.values.toList();
  for (var sale in allSales) {
    print(sale.toString()); // Print the SalesModel instance

    // Print details of each SalesItemModel in the sales list
    for (var item in sale.salesList) {
      print('????????????????????????????  ${item.productName} - ₹${item.pricePerUnit.toStringAsFixed(2)} x ${item.quantity}');
    }
  }


    return _salesBox.values.toList();
  }

  List<SalesModel> getFilteredSales(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) {
      return [];
    }
    return _salesBox.values.where((sale) {
      DateTime saleDate = DateTime.parse(sale.date);
      return saleDate.isAfter(startDate.subtract(Duration(days: 1))) &&
          saleDate.isBefore(endDate.add(Duration(days: 1)));
    }).toList();
  }

  int getTotalQuantity(List<SalesModel> sales) {
    int totalQuantity = 0;
    for (var sale in sales) {
      for (var item in sale.salesList) {
        totalQuantity += item.quantity;
      }
    }
    return totalQuantity;
  }

  double getTotalAmount(List<SalesModel> sales) {
    double totalAmount = 0;
    for (var sale in sales) {
      totalAmount += sale.totalAmount;
    }
    return totalAmount;
  }
}
