import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:yuvix/features/salespage/model/sales_model.dart';

import '../model/sales_item_model.dart';

String? selectedcat;

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

    await _salesBox.add(salesData);

    final allSales = _salesBox.values.toList();
    for (var sale in allSales) {
      print(sale.toString());

      for (var item in sale.salesList) {
        print(
            '  ${item.productName} - ₹${item.pricePerUnit.toStringAsFixed(2)} x ${item.quantity}');
      }
    }

    notifyListeners();
  }

  List<SalesModel> getAllSales() {
    final allSales = _salesBox.values.toList();
    for (var sale in allSales) {
      print(sale.toString());

      for (var item in sale.salesList) {
        print(
            '${item.productName} - ₹${item.pricePerUnit.toStringAsFixed(2)} x ${item.quantity}');
        print("${item.categoryName}");
      }
    }

    return _salesBox.values.toList();
  }

  List<SalesModel> getFilteredSales(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) {
      return [];
    }

    final dateFormat = DateFormat('dd.MMM.yyyy');

    return _salesBox.values.where((sale) {
      DateTime? saleDate;

      try {
        saleDate = dateFormat.parse(sale.date);
      } catch (e) {
        print('Date format exception: $e');
        return false;
      }

      return saleDate.isAfter(startDate.subtract(Duration(days: 1))) &&
          saleDate.isBefore(endDate.add(Duration(days: 1)));
    }).toList();
  }

  // fn
  Map<String, Map<String, dynamic>> getCategoryWiseSummary(
      List<SalesModel> sales) {
    Map<String, Map<String, dynamic>> categorySummary = {};

    for (var sale in sales) {
      for (var item in sale.salesList) {
        if (categorySummary.containsKey(item.categoryName)) {
          categorySummary[item.categoryName]!['totalQuantity'] += item.quantity;
          categorySummary[item.categoryName]!['totalAmount'] +=
              item.pricePerUnit * item.quantity;
        } else {
          categorySummary[item.categoryName] = {
            'totalQuantity': item.quantity,
            'totalAmount': item.pricePerUnit * item.quantity,
          };
        }
      }
    }

    categorySummary.forEach((category, summary) {
      print(
          'Category: $category, Total Quantity: ${summary['totalQuantity']}, Total Amount: ₹${summary['totalAmount'].toStringAsFixed(2)}');
    });

    return categorySummary;
  }

  int getTotalQuantity(List<SalesModel> sales) {
    int totalQuantity = 0;
    for (var sale in sales) {
      totalQuantity += sale.salesList.length;
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
