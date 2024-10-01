
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:yuvix/core/constants/color.dart';

class SalesCard extends StatelessWidget {
  final String sale;
  final String buyerName;
  final String mobileNumber;
  final double totalAmount;

  const SalesCard({
    Key? key,
    required this.sale,
    required this.buyerName,
    required this.mobileNumber,
    required this.totalAmount,  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
         
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person, color: ConstC.getColor(AppColor.text), size: 24),
                  SizedBox(width: 10),
                  Text(
                    buyerName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:  ConstC.getColor(AppColor.textC2),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.phone, color: ConstC.getColor(AppColor.text), size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Mobile: $mobileNumber',
                    style: TextStyle(
                      fontSize: 16,
                      color:  ConstC.getColor(AppColor.textC2),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(FontAwesome5.rupee_sign, color:  ConstC.getColor(AppColor.text), size: 24),
                  SizedBox(width: 10),
                  Text(
                    'Total Amount: ₹${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
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
