import 'package:example/utils/functions.dart';
import 'package:example/utils/spacing.dart';
import 'package:example/utils/styles.dart';
import 'package:example/views/edit_details.dart';
import 'package:example/views/images_library.dart';
import 'package:example/views/manage_account.dart';
import 'package:example/views/splash_screen.dart';
import 'package:example/views/tweets_screen.dart';
import 'package:example/widgets/custom_dialog.dart';
import 'package:example/widgets/network_image.dart';
import 'package:example/widgets/round_clipper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_account.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int presentLang;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("images/logo.png", height: 50),
            horizontalSpaceSmall,
            Text(
              "TWATRHA",
              style: GoogleFonts.nunito(
                  fontSize: 20.0, color: Styles.colorBlack, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Styles.yellowColor,
        actions: [
          myPopMenu(),
          horizontalSpaceSmall,
       /*   GestureDetector(
            onTap: () {
              selectLng(context);
            },
            child: Row(
              children: [
                Text(
                 // EasyLocalization.of(context).locale.languageCode.toUpperCase(),
                  "EN",
                  style: GoogleFonts.nunito(
                      fontSize: 14.0, color: Styles.colorBlack, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.keyboard_arrow_down)
              ],
            ),
          )*/
        ],
        bottom: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Styles.yellowColor,
          title: Text(
            "Select an Action to perform",
            style: GoogleFonts.nunito(
                fontSize: 16.0, color: Styles.colorBlack, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 3,
                  child: ClipPath(
                    clipper: BottomWaveClipper(),
                    child: Container(
                      color: Styles.yellowColor,
                    ),
                  )),
              Expanded(
                child: Container(),
                flex: 8,
              )
            ],
          ),
          GridView.builder(
              itemCount: goTos.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 15,
                  childAspectRatio: 1),
              itemBuilder: (context, index) {
                return packageItem(context, index);
              }),
        ],
      ),
    );
  }

  Widget myPopMenu() {
    return PopupMenuButton(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: CachedImage(size: 40, imageUrl: "ll"),
        ),
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                        child: Icon(Icons.person),
                      ),
                      Text('Admin Account')
                    ],
                  )),
              PopupMenuItem(
                  value: 2,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomDialog(
                            title: "Confirmation",
                            body: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Are you sure you want to logout?",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            onClicked: () {
                              FirebaseAuth.instance.signOut().then((a) {
                                moveToAndReplace(context, SplashScreen());
                              });
                            },
                            context: context),
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                        ),
                        Text('Logout')
                      ],
                    ),
                  )),
            ]);
  }

  Widget packageItem(context, index) {
    return GestureDetector(
      onTap: () {
        moveTo(context, goTos[index]);
      },
      child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.grey[300], blurRadius: 20, spreadRadius: 5)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(images[index], height: 60, width: 60),
              ),
              verticalSpaceSmall,
              Text(
                actions[index] ,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.0, color: Styles.colorBlack, fontWeight: FontWeight.w600),
              )
            ],
          )),
    );
  }

  selectLng(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              "Choose Language",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: StatefulBuilder(builder: (context, _setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  verticalSpaceSmall,
                  GestureDetector(
                    onTap: () {
                    //  EasyLocalization.of(context).locale = Locale('en', 'US');
                      presentLang = 0;
                      _setState(() {});
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: presentLang == 0 ? Colors.grey[300] : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "English",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Styles.colorBlack,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  GestureDetector(
                    onTap: () {
                      presentLang = 1;
                   //   EasyLocalization.of(context).locale = Locale('ar', 'DZ');
                      _setState(() {});
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: presentLang == 1 ? Colors.grey[300] : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Arabic",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Styles.colorBlack,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                ],
              );
            }),
          );
        });
  }
}

List<String> actions = ["Tweets", "Add Images", "Manage Accounts", "Add Account", "Edit Details"];
List goTos = [TweetsScreen(), ImagesLibrary(), ManageAccounts(), AddAccount(), EditDetails()];
List<String> images = [
  "images/tweets.png",
  "images/addimage.png",
  "images/manageacc.png",
  "images/addtwitter.png",
  "images/editd.png"
];
