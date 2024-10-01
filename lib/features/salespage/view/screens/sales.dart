import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:yuvix/features/salespage/controller/sales_service.dart';
import 'package:yuvix/features/salespage/view/screens/sale_more.dart';
import 'package:yuvix/features/salespage/view/screens/sales_add_sheet.dart';
import 'package:yuvix/features/salespage/view/screens/sales_card_detail.dart';
//import 'package:yuvix/features/salespage/view/screens/sales_card_details.dart';
import '../../../../core/constants/color.dart';
import '../widget/sale_card.dart';

class SalesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  ConstC.getColor(AppColor.appBar),
        title: Text('Sales Page'),
        titleTextStyle: TextStyle(color:  ConstC.getColor(AppColor.textC1),fontSize: 23),
        centerTitle: true,
        
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Recent Sales',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Provider.of<SalesProvider>(context, listen: false).initializeSalesBox(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading sales data'));
                } else {
                  return Consumer<SalesProvider>(
                    builder: (context, salesProvider, child) {
                      final allSales = salesProvider.getAllSales();
                      if (allSales.isEmpty) {
                        return Center(child: Text('No sales recorded.'));
                      }

                      DateTime today = DateTime.now();
                      String formattedToday = DateFormat('yyyy-MM-dd').format(today);

                      final todaySales = allSales.where((sale) {
                        return sale.date == formattedToday;
                      }).toList();

                      final otherSales = allSales.where((sale) {
                        return sale.date != formattedToday;
                      }).toList();

                      final limitedSales = [...todaySales, ...otherSales.take(4)].toList();

                      return ListView.builder(
                        itemCount: limitedSales.length,
                        itemBuilder: (context, index) {
                          final sale = limitedSales[index];
                          

                          return InkWell(
                            onTap: () {
                              print("::::::::::::::::::::::::::::${sale.salesList}");
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SalesCardDetails(sales: sale,),));
                            },
                            child: SalesCard(
                              sale:sale.customerName ,
                                buyerName: sale.customerName,
                                mobileNumber: sale.mobileNumber,
                                totalAmount: sale.totalAmount,
                              
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SalesMore(),
                  ),
                );
              },
              child: Text(
                'See More',
                style: TextStyle(
                  fontSize: 18,
                  color:  ConstC.getColor(AppColor.background1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SalesAddPage(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor:  ConstC.getColor(AppColor.background1),
      ),
    );
  }
}




