import 'package:books_app/screens/search_screen.dart';
import 'package:books_app/widgets/widget_tree.dart';
import 'package:books_app/screens/bookshelf_screen.dart';
import 'package:books_app/screens/home_screen.dart';
import 'package:books_app/widgets/detailWidgets/actions_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:books_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileScreen extends StatelessWidget {
  final User user = Auth().currentUser;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('userBookDetails');
  String noOfBooksIssued = "";
  String noOfBooksDue = "";

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUid() {
    return Text(
      user?.email ?? 'User email',
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: 25,
      ),
    );
  }

  Future<void> getNumberOfBooks(String userEmail) async {
    // Query the Realtime Database for the rows with the specified email and non-null DATE OF ISSUE
    DataSnapshot snapshot = await databaseReference
        .orderByChild('Email')
        .equalTo(userEmail)
        .once();

    int issued = 0;
    int due = 0;

    // Loop through the snapshot's children and count the number of rows where DATE OF ISSUE is not null
    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value;

      values.forEach((key, value) {
        if (value['DATE OF ISSUE'] != '') {
          issued++;
          if (value['DATE OF RETURN'] == '') {
            due++;
          }
        }
      });
    }

    noOfBooksIssued = issued.toString();
    noOfBooksDue = due.toString();
  }

  Widget getBooksCount(BuildContext context, int i) {
    return StreamBuilder(
      stream: databaseReference.onValue,
      builder: (context, snapshot) {
        getNumberOfBooks(user.email);
        if (i == 1) {
          if (snapshot.hasData && snapshot.data.snapshot.value != null) {
            return Text(
              noOfBooksIssued,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 25,
              ),
            );
          } else {
            // Return a button with a placeholder text
            return ElevatedButton(
              onPressed: () {
                // Perform some action when the button is pressed
              },
              child: Text('..'),
            );
          }
        }
        else {
          if (snapshot.hasData && snapshot.data.snapshot.value != null) {
            return Text(
              noOfBooksDue,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 25,
              ),
            );
          } else {
            // Return a button with a placeholder text
            return ElevatedButton(
              onPressed: () {
                // Perform some action when the button is pressed
              },
              child: Text('..'),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Color(0xFFE1EEDD),
        //         Color(0xFFF16767),
        //       ],
        //       begin: FractionalOffset.bottomCenter,
        //       end: FractionalOffset.topCenter,
        //     ),
        //   ),
        // ),
        Scaffold(
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
          // backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ActionButton(
                        icon: Icons.logout,
                        onPressed: () {
                          signOut();
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const WidgetTree()), (Route route) => false);
                        },
                        label: 'Sign Out',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'My\nProfile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 42,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Container(
                    height: height * 0.43,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.72,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,width: 2),
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                    ),
                                    _userUid(),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Books\nIssued',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                              ),
                                            ),
                                            getBooksCount(context, 1),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 8,
                                          ),
                                          child: Container(
                                            height: 65,
                                            width: 3,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(100),
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Books\n  Due',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                              ),
                                            ),
                                            getBooksCount(context, 2),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 120,
                              right: 15,
                              child: Icon(
                                Icons.settings,
                                color: Colors.grey[700],
                                size: 35,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  child: Image.asset(
                                    'images/profile.png',
                                    width: innerWidth * 0.45,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: height * 0.65,
                    width: width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,width: 2),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Book History',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          Divider(
                            thickness: 2.0,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}


//
// class ProfileScreen extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: ListView(
//
//         children: [
//           SizedBox(height:30),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 30,
//                 width: 30,
//                 child: const CircleAvatar(
//                   backgroundImage: AssetImage('assets/images/profile.png'),
//                 ),
//               ),
//               SizedBox(height: 30),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[
//                   Text("Sree Shivesh"),
//                   Text("Student",
//                       style: TextStyle(
//                         fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey.shade500,
//                       )),
//                   SizedBox(height: 30),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: const Color(0xFFFF9800),
//                     ),
//                     // padding: EdgeInsets.symmetric(horizontal: AppLayout.getHeight(3),vertical:AppLayout.getHeight(3)),
//                     padding: EdgeInsets.only(left:5,right: 7, top: 5, bottom: 3),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(2),
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color(0xFF526799),
//                           ),
//                         ),
//                         SizedBox(height: 30),
//                         Text("data"),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),],
//       ),
//     );
//   }
// }