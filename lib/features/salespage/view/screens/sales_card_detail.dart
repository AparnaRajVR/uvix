
import 'package:flutter/material.dart';
import 'package:yuvix/core/constants/color.dart';
import 'package:yuvix/features/salespage/model/sales_model.dart';
import '../widget/s_card_widget.dart';


class SalesCardDetails extends StatelessWidget {
  final SalesModel sales;

  const SalesCardDetails({required this.sales});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sales Details',
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: ConstC.getColor(AppColor.textC1),
          fontSize: 23,
        ),
        backgroundColor: ConstC.getColor(AppColor.background1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: ConstC.getColor(AppColor.textC1),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 37, 36, 36).withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SalesCardDetailsWidgets.buildDetailRow(
                    label: 'Customer Name:',
                    value: sales.customerName,
                  ),
                  SalesCardDetailsWidgets.buildDetailRow(
                    label: 'Mobile Number:',
                    value: sales.mobileNumber,
                  ),
                  SalesCardDetailsWidgets.buildDetailRow(
                    label: 'Date:',
                    value: sales.date,
                  ),

                  SizedBox(height: 16),

                  Text(
                    'Sales List',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ConstC.getColor(AppColor.background1),
                    ),
                  ),
                  SizedBox(height: 8),

                  ...SalesCardDetailsWidgets.buildSalesList(
                    salesList: sales.salesList,
                  ),

                  SizedBox(height: 16),

                  SalesCardDetailsWidgets.buildTotalAmountRow(
                    totalAmount: sales.totalAmount,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
