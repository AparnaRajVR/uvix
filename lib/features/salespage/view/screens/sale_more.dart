
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:yuvix/core/constants/color.dart';
import 'package:yuvix/features/salespage/controller/sales_service.dart';
import 'package:yuvix/features/salespage/model/sales_model.dart';
import 'package:yuvix/features/salespage/view/screens/sales_card_detail.dart';
import '../widget/sale_card.dart';

class SalesMore extends StatefulWidget {
  const SalesMore({Key? key}) : super(key: key);

  @override
  _SalesMoreState createState() => _SalesMoreState();
}

class _SalesMoreState extends State<SalesMore> {
  DateTime selectedDate = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;
  final DateFormat formatter = DateFormat('dd.MMM.yyyy'); 

  @override
  Widget build(BuildContext context) {
    String formattedToday = formatter.format(selectedDate);
    String formattedYesterday = formatter.format(selectedDate.subtract(Duration(days: 1)));
    String formattedStartDate = startDate != null ? formatter.format(startDate!) : 'Start Date';
    String formattedEndDate = endDate != null ? formatter.format(endDate!) : 'End Date';

    return Scaffold(
      appBar: AppBar(
        foregroundColor: ConstC.getColor(AppColor.textC1),
        backgroundColor: ConstC.getColor(AppColor.appBar),
        title: Text("Sales More"),
        titleTextStyle: TextStyle(color: ConstC.getColor(AppColor.textC1), fontSize: 23),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      startDate = selectedDate.subtract(Duration(days: 1));
                      endDate = selectedDate.subtract(Duration(days: 1));
                    });
                  },
                  child: Text(
                    formattedYesterday,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      startDate = selectedDate;
                      endDate = selectedDate;
                    });
                  },
                  child: Text(
                    formattedToday,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          startDate = pickedDate;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        color: ConstC.getColor(AppColor.buttonBackground),
                        border: Border.all(color: ConstC.getColor(AppColor.text)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        formattedStartDate,
                        style: TextStyle(fontSize: 16, color: ConstC.getColor(AppColor.textC1)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: endDate ?? selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          endDate = pickedDate;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                      decoration: BoxDecoration(
                        color: ConstC.getColor(AppColor.buttonBackground),
                        border: Border.all(color: ConstC.getColor(AppColor.text)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        formattedEndDate,
                        style: TextStyle(fontSize: 16, color: ConstC.getColor(AppColor.textC1)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<SalesProvider>(
              builder: (context, salesProvider, child) {
                final filteredSales = salesProvider.getFilteredSales(startDate, endDate);
                final totalQuantity = salesProvider.getTotalQuantity(filteredSales);
                final filterTotalAmount = salesProvider.getTotalAmount(filteredSales);

                print("Total Quantity: $totalQuantity");
                print("Total Filtered Amount: $filterTotalAmount");

                if (filteredSales.isEmpty) {
                  return Center(child: Text('Please select a date'));
                }
                return ListView.builder(
                  itemCount: filteredSales.length,
                  itemBuilder: (context, index) {
                    final SalesModel sale = filteredSales[index];
                    final salesList = sale.salesList.toList();

                    Map<String, int> productQuantities = {};
                    double totalAmount = sale.totalAmount;

                    salesList.forEach((product) {
                      final productName = product.productName;
                      final productQuantity = product.quantity;

                      if (productQuantities.containsKey(productName)) {
                        productQuantities[productName] =
                            productQuantities[productName]! + productQuantity;
                      } else {
                        productQuantities[productName] = productQuantity;
                      }
                    });

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SalesCardDetails(sales: sale),
                          ),
                        );
                      },
                      child: SalesCard(
                        buyerName: sale.customerName,
                        mobileNumber: sale.mobileNumber,
                        totalAmount: totalAmount, sale: sale.customerName,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
