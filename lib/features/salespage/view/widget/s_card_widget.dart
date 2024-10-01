import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yuvix/core/constants/color.dart';
import 'package:yuvix/features/salespage/model/sales_item_model.dart';

class SalesCardDetailsWidgets {
  static Widget buildDetailRow({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ConstC.getColor(AppColor.background1),
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  static List<Widget> buildSalesList({
    required List<SalesItemModel> salesList,
  }) {
   
    return salesList.map<Widget>((item) {
      log("$item");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${item}");
      return Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 201, 187, 187),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ConstC.getColor(AppColor.text)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.productName,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Text(
              '₹${item.pricePerUnit.toStringAsFixed(2)} x ${item.quantity}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }).toList();
  }

  static Widget buildTotalAmountRow({
    required double totalAmount,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Total Amount:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ConstC.getColor(AppColor.background1),
          ),
        ),
        Text(
          '₹${totalAmount.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ConstC.getColor(AppColor.background1),
          ),
        ),
      ],
    );
  }
}
