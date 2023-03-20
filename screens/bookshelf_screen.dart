import 'package:books_app/providers/bookshelf.dart';
import 'package:books_app/screens/profile.dart';
import 'package:books_app/screens/search_screen.dart';
// import 'package:books_app/widgets/navbar.dart';
import 'package:books_app/widgets/saved_book_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:provider/provider.dart';

import 'home_screen.dart';

class BookShelfScreen extends StatefulWidget {
  static const routeName = '/bookshelf';

  @override
  _BookShelfScreenState createState() => _BookShelfScreenState();
}

class _BookShelfScreenState extends State<BookShelfScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:Color(0xFFFFACAC),
      backgroundColor: Color(0xFFF1D3B3),
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
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: NavBar(BookShelfScreen.routeName),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          return Future.delayed(Duration.zero);
        },
        child: Consumer<Bookshelf>(
          builder: (BuildContext context, bookshelf, Widget child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                  elevation: 2,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/coverimage1.jpg"),
                            fit: BoxFit.cover)),
                    child: Container(
                      color: Colors.black38,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40, left: 20, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Bookshelf',
                                textAlign: TextAlign.end,
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: 46,
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
               Divider(
                 height: 0,
               ),
                Expanded(
                  child: FutureBuilder(
                    future: Provider.of<Bookshelf>(context, listen: false)
                        .fetchAndSetBooks(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? Center(child: CircularProgressIndicator())
                          : bookshelf.savedBooks.length <= 0
                              ? EmptyBookshelfWidget()
                              : ListView.builder(
                                  itemCount: bookshelf.savedBooks.length,
                                  itemBuilder: (ctx, i) => SavedBookItem(
                                      bookshelf.savedBooks.reversed
                                          .toList()[i]),
                                );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class EmptyBookshelfWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xFFFFACAC),
      color: Color(0xFFF1D3B3),
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [
      //       Color(0xFFE1EEDD),
      //       Color(0xFFF16767),
      //
      //     ],
      //     begin: FractionalOffset.bottomCenter,
      //     end: FractionalOffset.topCenter,
      //   ),
      // ),
      child: Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Click ",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.bookmark_border,
                        size: 18,
                      ),
                    ),
                    TextSpan(
                      text: " to add books to the bookshelf",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
