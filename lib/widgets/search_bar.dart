import 'package:books_app/providers/books.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool byTitle = true;
  String searchString;
  bool free = false;

  void search() async {
    Provider.of<Books>(context, listen: false).setStartIndex();

    Provider.of<Books>(context, listen: false)
        .toggleTotalItemsCalculation(true);
    await Provider.of<Books>(context, listen: false)
        .getSearchedBookData(searchString, byTitle, free);
    Provider.of<Books>(context, listen: false)
        .toggleTotalItemsCalculation(false);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
          side:BorderSide(
            color: Colors.black,
            width: 2,
          ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        free = !free;
                        search();
                      });
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          free ? 'FREE' : 'ALL',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: 56,
                      child: VerticalDivider(
                        width: 0,
                        color: Colors.black,
                      )),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        byTitle = !byTitle;
                        search();
                      });
                    },
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        byTitle ? 'TITLE' : 'AUTHOR',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                ],
              ),
              Container(
                  height: 56,
                  child: VerticalDivider(
                    width: 0,
                    color: Colors.black,
                  )),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: TextField(
                    autofocus: true,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 4.0),
                            hintText: 'Search book',
                            hintStyle: TextStyle(
                                // color: kSearchBarHintColor,
                                ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none)
                        .copyWith(
                            hintText: byTitle
                                ? 'Search by title'
                                : 'Search by author'),
                    textInputAction: TextInputAction.search,
                    onChanged: (value) {
                      searchString = value;
                    },
                    onSubmitted: (value) async {
                      if (value == '') return;
                      search();
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (searchString == null) return;
                      if (searchString != null &&
                          searchString.trim().length == 0) return;
                      search();
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
