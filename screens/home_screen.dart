import 'dart:async';
import 'package:books_app/providers/nyt.dart';
import 'package:books_app/screens/bookshelf_screen.dart';
import 'package:books_app/screens/profile.dart';
import 'package:books_app/widgets/app_title.dart';
import 'package:books_app/widgets/categoriesWidgets/categories_section.dart';
// import 'package:books_app/widgets/navbar.dart';
import 'package:books_app/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  // int _selectedIndex = 0;
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Likes',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Search',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Profile',
  //     style: optionStyle,
  //   ),
  // ];

  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  // Called when this State object changes.
  void didChangeDependencies() {
    super.didChangeDependencies();
    getBooksData();
  }

  Future<void> getBooksData() async {
    await Provider.of<NYT>(context, listen: false).getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1D3B3),
      //Color(0xFFFFC3A1),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: NavBar(HomeScreen.routeName),
      // children: [
      //   Center(
      //     child: _widgetOptions.elementAt(_selectedIndex),
      //   ),
      // ],
      bottomNavigationBar: GNav(
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: Colors.white,
        tabBackgroundColor: Colors.grey.shade800,
        padding: EdgeInsets.all(20),
        gap: 8,
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              },
          ),
          GButton(icon: Icons.search,
            text: 'Search',
            onPressed: () {
            Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()),
            );
            },
          ),
          GButton(
            icon: Icons.bookmark,
            text: 'Bookshelf',
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => BookShelfScreen()),
              );
              },
          ),
          GButton(
            icon: Icons.account_circle_rounded,
            text: 'Profile',
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
              },
          ),
        ],
      ),
      //   selectedIndex: _selectedIndex,
      //   onTabChange: (index) {
      //     setState(() {
      //       _selectedIndex = index;
      //     });
      //   },
      // ),
      body: RefreshIndicator(
        color: Color(0xff0DB067),
        backgroundColor: Colors.black,
        displacement: 80,
        onRefresh: () async {
          await getBooksData();
        },
        child: Column(
          children: <Widget>[
            AppTitle(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    // Showcase(),
                    Container(
                      // decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //       colors: [
                      //         Color(0xFFE1EEDD),
                      //         Color(0xFFFFACAC),
                      //       ],
                      //       begin: FractionalOffset.bottomCenter,
                      //       end: FractionalOffset.topCenter,
                      //     ),
                      //   ),
                      child: CategoriesSection(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
