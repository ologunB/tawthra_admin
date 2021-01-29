import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/models/twitter_acc.dart';
import 'package:example/models/twitter_into.dart';
import 'package:example/utils/constants.dart';
import 'package:example/utils/spacing.dart';
import 'package:example/widgets/custom_button.dart';
import 'package:example/widgets/network_image.dart';
import 'package:example/widgets/show_exception_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'dart:convert';

class TwitterDetails extends StatefulWidget {
  final TwitterKeys model;

  const TwitterDetails({Key key, this.model}) : super(key: key);

  @override
  _TwitterDetailsState createState() => _TwitterDetailsState();
}

class _TwitterDetailsState extends State<TwitterDetails> {
  bool isLoading = true;
  TwitterInfo info = TwitterInfo();

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  getDetails() async {
    const String apiKey = '17Exv61ua6N5GrrRgHy22ltub';
    const String apiSecret = 'aizFVjFVieeolOtYqLksloKVIUGqacaJL02fzMwEw9XRlrxv68';
    final oauth1.ClientCredentials clientCredentials = oauth1.ClientCredentials(apiKey, apiSecret);

    var client = new oauth1.Client(oauth1.SignatureMethods.hmacSha1, clientCredentials,
        oauth1.Credentials(widget.model.token, widget.model.tokenSecret));

    var dataRes = await client.get('https://api.twitter.com/1.1/account/verify_credentials.json');

    try {
      switch (dataRes.statusCode) {
        case 200:
          try {
            info = TwitterInfo.fromJson(jsonDecode(dataRes.body));
            setState(() {
              isLoading = false;
            });
          } catch (e) {
            print(e);
            setState(() {
              isLoading = false;
            });
          }

          break;
        default:
          setState(() {
            isLoading = false;
          });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        progressIndicator: CupertinoActivityIndicator(radius: 15),
        isLoading: isLoading,
        color: Colors.grey,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text(
                "Twitter Details",
                style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              elevation: 2),
          body: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CachedImage(size: 70, imageUrl: info.profileImageUrlHttps)],
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  info.name ?? "",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Center(
                child: Text(
                  "@${info.screenName ?? "account"}",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
                ),
              ),
              Divider(),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        "Location: ${info.location ?? "null"}",
                        style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
              verticalSpaceTiny,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "Description: ${info.description ?? "blah blah blah"}",
                  style: GoogleFonts.nunito(
                      fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600),
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Verified",
                                style: GoogleFonts.nunito(
                                    fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
                            Text("${info.verified ?? "false"}",
                                style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black)),
                          ],
                        ),
                        horizontalSpaceMedium,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Text("Followers",
                                    style: GoogleFonts.nunito(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey)),
                                Text("${info.followersCount} " ?? "22",
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )
                          ],
                        ),
                        horizontalSpaceMedium,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 10),
                            Column(
                              children: [
                                Text("Following",
                                    style: GoogleFonts.nunito(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey)),
                                Text("${info.friendsCount} " ?? "22",
                                    style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )
                          ],
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("No of Tweets",
                            style: GoogleFonts.nunito(
                                fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
                        verticalSpaceTiny,
                        Text("${info.statusesCount} " ?? "22",
                            style: GoogleFonts.nunito(
                                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(10),
            child: CustomButton(
                title: "Delete Account",
                onPressed: () {
                  deleteAccount(context);
                }),
          ),
        ));
  }

  deleteAccount(BuildContext context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    WriteBatch writeBatch = _firestore.batch();

    writeBatch.delete(
        _firestore.collection("Utils").doc("Tokens").collection("Admin").doc(widget.model.userId));

    writeBatch.commit().then((value) {
      showSnackBar(context, "Alert", "Account Successfully removed");
      Navigator.pop(context);
    }).catchError((e){
      setState(() {
        isLoading = false;
      });
      showExceptionAlertDialog(context: context, exception: e, title: "Error");

    });
    Navigator.pop(context);
  }
}
