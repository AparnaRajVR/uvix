
import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:yuvix/core/constants/color.dart';
// import 'package:fluttericon/octicons_icons.dart';
import 'package:yuvix/features/homepage/view/screen/search_filter.dart';

import 'package:yuvix/features/revenue/view/screen/revenue.dart';
import 'package:yuvix/features/salespage/view/screens/sales.dart';

import '../../../inventory/view/screens/Inventory.dart';



  Color BackgroundColor = ConstC.getColor(AppColor.background1);

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children:  [
          InventoryPage(),
          SearchPage(),
          SalesPage(),
          RevenuePage(),
         
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: BackgroundColor,
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: _onItemSelected,
        items: [
          FlashyTabBarItem(
            icon: Icon(FontAwesome5.box_open, color: Colors.white),
            title: Text('Inventory Manage', style: TextStyle(color: Colors.white)),
          ),
          FlashyTabBarItem(
            icon: Icon(FontAwesome5.search, color: Colors.white),
            title: Text('Search', style: TextStyle(color: Colors.white)),
          ),
          FlashyTabBarItem(
            icon: Icon(FontAwesome5.hands_helping, color: Colors.white),
            title: Text('Sales', style: TextStyle(color: Colors.white)),
          ),
          FlashyTabBarItem(
            icon: Icon(FontAwesome5.chart_bar, color: Colors.white),
            title: Text('Revenue', style: TextStyle(color: Colors.white)),
          ),
        
        ],
      ),
    );
  }
}


