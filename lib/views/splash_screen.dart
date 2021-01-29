import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:example/utils/constants.dart';
import 'package:example/utils/functions.dart';
import 'package:example/utils/spacing.dart';
import 'package:example/utils/styles.dart';
import 'package:example/widgets/custom_button1.dart';
import 'package:example/widgets/show_exception_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      User user = FirebaseAuth.instance.currentUser;
      user != null ? moveToAndReplace(context, HomeScreen()) : () {};
    });
    super.initState();
  }

  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        progressIndicator: CupertinoActivityIndicator(radius: 15),
        isLoading: isLoading,
        color: Styles.appLightPrimaryColor,
        child: Scaffold(
          backgroundColor: Styles.whiteColor,
          body: Center(
              child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Image.asset("images/logo.png", height: 120),
              verticalSpaceMedium,
              TypewriterAnimatedTextKit(
                speed: Duration(milliseconds: 500),
                text: ["TWATRHA"],
                textStyle: GoogleFonts.nunito(
                    fontSize: 25.0, color: Styles.colorBlack, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              verticalSpaceLarge,
              Text(
                "PIN",
                style: GoogleFonts.nunito(
                    fontSize: 14.0, color: Styles.colorBlack, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              verticalSpaceSmall,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  obscureText: true,
                  controller: controller,
                  maxLength: 8,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: Color(0xff071232), fontWeight: FontWeight.w500, fontSize: 16),
                  cursorColor: Color(0xff245DE8),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    fillColor: Color(0xffF3F4F8),
                    labelStyle: TextStyle(color: Colors.black54, fontSize: 16),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: Color(0xff245DE8),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Password is required";
                    } else if (val.length < 4) {
                      return 'Password must be a minimum of 4 characters';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: CustomButton1(
                  title: "LOGIN",
                  onPressed: () {
                    signIn(context);
                  },
                  color: Styles.appPrimaryColor,
                ),
              )
            ],
          )),
        ));
  }

  signIn(context) async {
    offKeyboard(context);
    setState(() {
      isLoading = true;
    });
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    await _firebaseAuth
        .signInWithEmailAndPassword(email: "danielrichard8673@gmail.com", password: controller.text)
        .then((value) {
      User user = value.user;

      if (user != null) {
        if (!user.emailVerified) {
          setState(() {
            isLoading = false;
          });
          showSnackBar(context, "Alert", "Email not verified");

          _firebaseAuth.signOut();
          return;
        } else {
          moveToAndReplace(context, HomeScreen());
        }
      } else {
        setState(() {
          isLoading = false;
        });
        _firebaseAuth.signOut();
      }
      return;
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      _firebaseAuth.signOut();
      showExceptionAlertDialog(context: context, exception: e, title: "Error");

      return;
    });
  }
}
