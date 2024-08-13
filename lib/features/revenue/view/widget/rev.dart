import 'package:flutter/material.dart';
import 'package:yuvix/core/constants/color.dart';

class RevenueWidgets {
  static Widget buildInfoCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: color),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
                fontSize: 24, color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  static Widget buildCategoryCard(
      String name, String imagePath, int quantity, double amount) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(imagePath),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ConstC.getColor(AppColor.textC3)),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Qty: $quantity',
                        style: TextStyle(
                            fontSize: 16, color: ConstC.getColor(AppColor.text)),
                      ),
                      Text(
                        'Amount: ₹$amount',
                        style: TextStyle(
                            fontSize: 16, color: ConstC.getColor(AppColor.text)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
