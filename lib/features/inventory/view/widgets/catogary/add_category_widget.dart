import 'package:flutter/material.dart';
import 'package:yuvix/features/inventory/view/widgets/catogary/categoryadd.dart';

class AddCategoryCard extends StatelessWidget {
  final title;
  const AddCategoryCard({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCategory()),
          );
        },
        child: Container(
          width: 100,
          height: 120,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:  Color(0xff03448c),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.white,),
              SizedBox(height: 10),
              Text(title,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}