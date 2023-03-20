import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:books_app/screens/animated_btn.dart';
import 'package:books_app/screens/sign_in_dialog.dart';
import 'package:books_app/screens/sign_in_form.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    // _btnAnimationController = OneShotAnimation("active", autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "images/Backgrounds/Spline.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            "images/RiveAssets/shapes.riv",
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 309,
                      child: Column(
                        children: const [
                          Text(
                            "Computer Science & Engineering Library",
                            style: TextStyle(
                              fontSize: 50,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 140),
                          Text(
                            "Satify the thirst of knowledge!",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.italic,
                              fontSize: 22,

                            ),
                          ),

                        ],
                      ),
                    ),
                    const Spacer(flex: 3),
                    // ElevatedButton(onPressed: () {Navigator.push(context, SignInForm())},this.child,
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;

                        Future.delayed(
                          const Duration(milliseconds: 800),
                              () {
                            setState(() {
                              isShowSignInDialog = true;
                            });
                            showCustomDialog(
                              context,
                              onValue: (_) {
                                setState(() {
                                  isShowSignInDialog = false;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//
// import 'dart:ui';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';
// import 'package:books_app/utils/rive_utils.dart';
//
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }
//
// class _OnboardingScreenState extends State<OnboardingScreen> {
//
//   //For adding animation to the 'lets start reading page'
//   RiveAnimationController _btnAnimationController;
//   @override
//   void initState() {
//     // _btnAnimationController = OneShotAnimation("active",autoplay: false,); //autoplay stops the animation to play automatically on every reload
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         //Rive animated home screen
//         children: [
//           Positioned(
//               bottom: 190,
//               left: 50,
//               width: MediaQuery.of(context).size.width*1.7,
//               child: Image.asset("images/Backgrounds/Spline.png")),
//           Positioned.fill(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 30,sigmaY: 10),
//             ),
//           ),
//           const RiveAnimation.asset("images/RiveAssets/shapes.riv"),
//           Positioned.fill(
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 30,sigmaY: 30),
//               child: const SizedBox(),
//             ),
//           ),
//
//           //Adding text
//           SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 32),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                         const SizedBox(height: 20),
//                         //Computer Science & Engineering Library
//                         const Text("Computer Science & Engineering Library",
//                         style: TextStyle(
//                           fontSize: 50, fontFamily: "Poppins", height: 1.2),
//                         ),
//                         const SizedBox(height: 26),
//                         const Text("\n\nDepartment Library Management System     \n20z311 - Deepak V\n20z314 - Dharaneesh V\n20z332 - Naveen Kartick R\n20z348 - Sree Shivesh K\n20z360 - Lokesh Marri Yadav",
//                         style: TextStyle(
//                           fontSize: 15,
//                         ),),
//                     const Spacer(),
//                     GestureDetector(
//                       child: Padding(
//                         padding : const EdgeInsets.symmetric(vertical: 100),
//                         child: SizedBox(
//                           height: 64,
//                           width: 260,
//                           child: Stack(
//                             children: [
//                               RiveAnimation.asset(
//                                 "images/RiveAssets/button.riv",
//                                 // controllers: [_btnAnimationController],
//                               ),
//                               Positioned.fill(
//                                 top: 8,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: const [
//                                     Icon(CupertinoIcons.arrow_right),
//                                     SizedBox(width: 8),
//                                     Text("Lets start reading",
//                                       style: TextStyle(fontWeight: FontWeight.w600),
//                                     ),
//                                   ],),
//                               ),],
//                           ),
//                         ),
//                       ),
//                       onTap: () {
//                         _btnAnimationController.isActive=true;
//                         showGeneralDialog(
//                             barrierDismissible: true, //Enables closing of the dialog prompt if clicked outside of it anywhere on the screen
//                             barrierLabel: "Sign In",
//                             context: context,
//                             pageBuilder: (context, _, __) => Center(
//                               child: Container(
//                                 height: 620,
//                                 margin: const EdgeInsets.symmetric(horizontal: 16),
//                                 padding: const EdgeInsets.symmetric(vertical:24,horizontal: 114),
//                                 decoration: const BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius:
//                                     BorderRadius.all(Radius.circular(40)),
//                                 ),
//                                 child: Scaffold(
//                                   backgroundColor: Colors.transparent,
//                                   body: Column(
//                                     children:  [
//                                       const Text("Sign In",
//                                       style: TextStyle(
//                                         fontSize: 34, fontFamily: "Poppins",),
//                                       ),
//                                       Form(child: Column(children: [
//                                         TextFormField(
//
//                                         ),
//                                       ],))
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         );
//                       },
//
//                     ),
//                 ],
//                 ),
//               ),
//           ),
//         ],
//       ),
//     );
//   }
// }