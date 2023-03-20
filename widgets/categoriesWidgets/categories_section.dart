import 'package:books_app/providers/categories.dart';
import 'package:books_app/widgets/categoriesWidgets/category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 100.0,bottom: 0),
            child: Text('Categories',
                style: GoogleFonts.montserrat(
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.w700))),
          ),
          Container(
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [
            //       Color(0xFFE1EEDD),
            //       Color(0xFFFFBFA9),
            //     ],
            //     begin: FractionalOffset.bottomCenter,
            //     end: FractionalOffset.topCenter,
            //   ),
            // ),
            height: MediaQuery.of(context).size.height * 0.69,
            width: MediaQuery.of(context).size.width * 0.95,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: categories.categoriesList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                childAspectRatio: 1/2,
              ),
              itemBuilder: (context, i) =>
                  CategoryItem(categories.categoriesList[i]),
            ),
          ),
        ],
      ),
    );
  }
}
