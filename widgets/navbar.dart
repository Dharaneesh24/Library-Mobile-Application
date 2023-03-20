import 'dart:math';
import 'package:books_app/providers/books.dart';
import 'package:books_app/screens/bookshelf_screen.dart';
import 'package:books_app/screens/home_screen.dart';
import 'package:books_app/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:books_app/screens/profile.dart';
import 'package:provider/provider.dart';



class NavBar extends StatefulWidget {
  final String currentRoute;
  NavBar(this.currentRoute);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}


// class NavBar extends StatefulWidget {
//   NavBar()
//
//   @override
//   State<NavBar> createState() => _NavBarState();
// }
//
// class _NavBarState extends State<NavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     // floatingActionButton: NavBar(HomeScreen.routeName),
//       bottomNavigationBar: GNav(
//         backgroundColor: Colors.black,
//         color: Colors.white,
//         activeColor: Colors.white,
//         tabBackgroundColor: Colors.grey.shade800,
//         padding: EdgeInsets.all(20),
//         gap: 8,
//         tabs: [
//           GButton(
//           icon: Icons.home,
//           text: 'Home',
//           onPressed: () {
//           Navigator.push(
//           context, MaterialPageRoute(builder: (context) => HomeScreen()),
//           );
//         },
//         ),
//         GButton(
//           icon: Icons.search,
//           text: 'Search',
//           onPressed: () {
//             Navigator.push(
//               context, MaterialPageRoute(builder: (context) => SearchScreen()),
//             );
//             },
//         ),
//         GButton(
//           icon: Icons.bookmark,
//           text: 'Bookshelf',
//           onPressed: () {
//             Navigator.push(
//               context, MaterialPageRoute(builder: (context) => BookShelfScreen()),
//             );
//             },
//         ),
//         GButton(
//           icon: Icons.account_circle_rounded,
//           text: 'Profile',
//           onPressed: () {
//             Navigator.push(
//               context, MaterialPageRoute(builder: (context) => ProfileScreen()),
//             );
//             },
//         ),
//       ],
//       ),
//     );
//   }
// }


