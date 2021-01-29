import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/models/twitter_acc.dart';
import 'package:example/utils/constants.dart';
import 'package:example/utils/functions.dart';
import 'package:example/utils/spacing.dart';
import 'package:example/views/twitter_details.dart';
import 'package:example/widgets/custom_button.dart';
import 'package:example/widgets/show_exception_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:webview_flutter/webview_flutter.dart';

class AddAccount extends StatefulWidget {
  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  bool isLoading = false;

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
                "Add Twitter Accounts",
                style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              elevation: 2),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Utils")
                  .doc("Tokens")
                  .collection("Admin")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(child: CupertinoActivityIndicator());
                  default:
                    return snapshot.data.docs.isEmpty
                        ? Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "No Account yet, Add account!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        : ListView(
                            children: snapshot.data.docs.map<Widget>((document) {
                              TwitterKeys model = TwitterKeys.map(document);
                              return InkWell(
                                onTap: () {
                                  moveTo(context, TwitterDetails(model: model));
                                },
                                child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            model.screenName,
                                            style: TextStyle(
                                                fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        verticalSpaceSmall,
                                        Divider(
                                          height: 0,
                                        )
                                      ],
                                      mainAxisSize: MainAxisSize.min,
                                    )),
                              );
                            }).toList(),
                          );
                }
              }),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(10),
            child: CustomButton(
                title: "Add Twitter Account",
                onPressed: () {
                  getTokens(context);
                }),
          ),
        ));
  }

  getTokens(context) {
    isLoading = true;
    setState(() {});

    var platform = new oauth1.Platform(
        'https://api.twitter.com/oauth/request_token', // temporary credentials request
        'https://api.twitter.com/oauth/authorize', // resource owner authorization
        'https://api.twitter.com/oauth/access_token', // token credentials request
        oauth1.SignatureMethods.hmacSha1 // signature method
        );

    // define client credentials (consumer keys)
    const String apiKey = '17Exv61ua6N5GrrRgHy22ltub';
    const String apiSecret = 'aizFVjFVieeolOtYqLksloKVIUGqacaJL02fzMwEw9XRlrxv68';
    final oauth1.ClientCredentials clientCredentials = oauth1.ClientCredentials(apiKey, apiSecret);

    // create Authorization object with client credentials and platform definition
    final oauth1.Authorization auth = oauth1.Authorization(clientCredentials, platform);

    // request temporary credentials (request tokens)
    auth.requestTemporaryCredentials('https://callback').then((oauth1.AuthorizationResponse res) {
      isLoading = false;
      setState(() {});
      moveTo(
          context,
          SafeArea(
            child: WebView(
              initialUrl: auth.getResourceOwnerAuthorizationURI(res.credentials.token),
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://callback')) {
                  Navigator.of(context).pop('success');
                  isLoading = true;
                  setState(() {});

                  List<String> list = request.url.split("&");
                  List<String> list2 = list[1].split("=");

                  auth.requestTokenCredentials(res.credentials, list2[1]).then((value) {
                    Map<String, Object> mData = Map();
                    mData.putIfAbsent("oauth_token", () => value.credentials.token);
                    mData.putIfAbsent("oauth_token_secret", () => value.credentials.tokenSecret);
                    mData.putIfAbsent("user_id", () => value.optionalParameters["user_id"]);
                    mData.putIfAbsent("screen_name", () => value.optionalParameters["screen_name"]);

                    FirebaseFirestore.instance
                        .collection("Utils")
                        .doc("Tokens")
                        .collection("Admin")
                        .doc(value.optionalParameters["user_id"])
                        .set(mData)
                        .then((val) {
                      showSnackBar(context, "Alert", "Account Added");

                      setState(() {
                        isLoading = false;
                      });
                    }).catchError((e) {
                      showExceptionAlertDialog(context: context, exception: e, title: "Error");
                      setState(() {
                        isLoading = false;
                      });
                    });
                    isLoading = false;
                    setState(() {});
                  }).catchError((e) {
                    isLoading = false;
                    setState(() {});
                    showSnackBar(context, "Error", e.toString());
                    print(e);
                  });

                  // <-- Handle success case
                } else {
                  Navigator.of(context).pop('cancel');
                  showSnackBar(context, "Error",
                      "Unable to Authorize user, Do you have twitter app installed?");
                }
                return NavigationDecision.navigate;
              },
            ),
          ));
    }).catchError((e) {
      print(e);
      isLoading = false;
      setState(() {});

      showSnackBar(context, "Error", e.toString());
    }).timeout(Duration(seconds: 30), onTimeout: () {
      isLoading = false;
      setState(() {});

      showSnackBar(context, "Timed out", "Internet connection is unstable");
    });
  }
}
