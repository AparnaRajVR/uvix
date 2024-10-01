import 'package:flutter/material.dart';
import 'package:yuvix/features/salespage/model/sales_model.dart';
import '../widget/s_card_widget.dart';

class SalesCardDetails extends StatelessWidget {
  final SalesModel sales;

  const SalesCardDetails({required this.sales});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Details'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
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
                      color: Colors.teal,
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

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
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
}

