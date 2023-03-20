import 'package:books_app/providers/books.dart';
import 'package:books_app/screens/profile.dart';
import 'package:books_app/widgets/books_grid.dart';
import 'package:books_app/widgets/navbar.dart';
import 'package:books_app/widgets/network_sensititve.dart';
import 'package:books_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import 'bookshelf_screen.dart';
import 'home_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool loadGrid = false;
  @override
  //Get books on search
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Books>(context, listen: false).clearList();
      setState(() {
        loadGrid = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFFFACAC),
      backgroundColor: Color(0xFFF1D3B3),
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color(0xFFFFACAC),
      body: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                elevation: 2,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/coverimage1.jpg"),
                          fit: BoxFit.cover)),
                  child: Container(
                    color: Colors.black38,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 50.0, left: 16.0, right: 16.0,bottom: 2.0),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Discover \nBooks',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              NetworkSensitive(offlineChild: Container(), child: SearchBar()),
              SizedBox(height: 20),
            ],
          ),
          if (loadGrid)
            BooksGrid(
              routeName: SearchScreen.routeName,
            ),
          GNav(
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
        ],
      ),
    );
  }
}
