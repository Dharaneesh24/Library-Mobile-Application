import 'package:books_app/widgets/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:books_app/providers/books.dart';
import 'package:books_app/providers/bookshelf.dart';
import 'package:books_app/providers/categories.dart';
import 'package:books_app/providers/nyt.dart';
// import 'package:books_app/screens/bookshelf_screen.dart';
// import 'package:books_app/screens/home_screen.dart';
// import 'package:books_app/screens/search_screen.dart';
// import 'package:books_app/screens/specific_search_screen.dart';
// import 'package:books_app/screens/onboarding_screen.dart';
// import 'package:books_app/screens/sign_in_form.dart';
import 'package:books_app/services/connectivity_service.dart';
import 'package:books_app/services/connectivity_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BooksApp());
}

class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => Books(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => NYT(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Bookshelf(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => Categories(),
        ),
        StreamProvider<ConnectivityStatus>(
          create: (BuildContext context) =>
              ConnectivityService().connectionStatusController.stream,
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0))),
        debugShowCheckedModeBanner: false,
        title: 'Books App',
        home: const WidgetTree(),
        // initialRoute: HomeScreen.routeName,
        // routes: {
        //   SearchScreen.routeName: (context) => SearchScreen(),
        //   BookShelfScreen.routeName: (context) => BookShelfScreen(),
        //   SpecificSearchScreen.routeName: (context) => SpecificSearchScreen(),
        //   HomeScreen.routeName: (context) => HomeScreen(),
        //   OnboardingScreen.routeName: (context) =>OnboardingScreen(),
        //   SignInForm.routeName: (context) => SignInForm(),
        // },
      ),
    );
  }
}
