import 'package:books_app/models/book.dart';
import 'package:books_app/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:books_app/services/auth.dart';

class ActionsWidget extends StatelessWidget {
  final Book book;
  final User user = Auth().currentUser;
  ActionsWidget(this.book);
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget borrowButton(BuildContext context) {
    String availability;
    Map bookDetails;
    IconData icon;
    icon = Icons.book;

    Future<void> addUserBookDetails(String title, String email, String deptAccnNoOld, String dateOfReturn, String dateOfRequest, String dateOfIssue) async {
      try {
        await databaseReference.child('userBookDetails').push().set({
          'TITLE': title,
          'Email': email,
          'DEPT_ACCNNO_OLD': deptAccnNoOld,
          'DATE OF RETURN': dateOfReturn,
          'DATE OF REQUEST': dateOfRequest,
          'DATE OF ISSUE': dateOfIssue,
        });
      } catch (e) {
        print('Error: $e');
      }
    }

    Future<void> checkBookAvailability(String fieldValue) async {
      final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
      availability = 'AB';
      try {
        DataSnapshot snapshot = await databaseReference.child('books').orderByChild('TITLE').equalTo(fieldValue.toUpperCase()).once();
        if(snapshot.value == null) {
          availability = 'NA';
        }
        else {
          availability = 'BORROW';
          bookDetails = snapshot.value.values.elementAt(0);
        }
      } catch (e) {
        // print('Error: $e');
      }
    }

    Future<void> updateBook(String deptAccnnoOld) async {
      final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('books');

      // Query the Realtime Database for the book with the specified DEPT_ACCNNO_OLD
      DataSnapshot snapshot = await databaseReference
          .orderByChild('DEPT_ACCNNO_OLD')
          .equalTo(deptAccnnoOld)
          .once();

      // Check if the snapshot has data
      if (snapshot.value != null) {
        // Get the key of the book to update
        String bookKey = snapshot.value.keys.first;
        print(bookKey);
        // Update the MATL_STATUS field of the book
        await databaseReference.child(bookKey).update({'MATL_STATUS': 'ISSUED'});
      }
    }

    checkBookAvailability(book.title);

    return StreamBuilder(
      stream: databaseReference.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.snapshot.value != null && bookDetails != null && bookDetails['MATL_STATUS'] != null && bookDetails['MATL_STATUS'].toUpperCase() == 'AVAILABLE') {
          return ActionButton(
            label: availability,
            icon: icon,
            onPressed: () {
              DateTime now = DateTime.now();
              String todaysDate = "${now.day}-${now.month}-${now.year}";
              print(book.title+ user.email+ bookDetails['DEPT_ACCNNO_OLD']+ ''+ todaysDate+ '');
              addUserBookDetails(book.title, user.email, bookDetails['DEPT_ACCNNO_OLD'], '', todaysDate, '');
              updateBook(bookDetails['DEPT_ACCNNO_OLD']);
            }
          );
        } else {
          // Return a button with a placeholder text
          return ElevatedButton(
            onPressed: null,
            child: Text('NA'),
          );
        }
      },
    );
  }

  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ActionButton(
          icon: Icons.chrome_reader_mode,
          label: 'PREVIEW',
          onPressed: () async {
            await Utils.launchURL(book.previewLink);
          },
        ),
        SizedBox(width: 5.0),
        // ActionButton(
        //   label: book.saleability != 'FOR_SALE'
        //       ? 'N/A'
        //       : '${book.amount} ${book.currencyCode}',
        //   onPressed: book.saleability != 'FOR_SALE'
        //       ? null
        //       : () async {
        //     await Utils.launchURL(book.buyLink);
        //   },
        //   icon: Icons.shop,
        // ),
        SizedBox(width: 5.0),
        borrowButton(context),
      ],
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  ActionButton(
      {@required this.icon, @required this.label, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10.0),
          ),
          Icon(
            icon,
            size: 16.0,
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}