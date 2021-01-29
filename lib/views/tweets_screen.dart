import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/models/subscribed.dart';
import 'package:example/utils/functions.dart';
import 'package:example/utils/spacing.dart';
import 'package:example/utils/styles.dart';
import 'package:example/views/tweet_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TweetsScreen extends StatefulWidget {
  @override
  _TweetsScreenState createState() => _TweetsScreenState();
}

class _TweetsScreenState extends State<TweetsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Tweets",
            style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.grey[500],
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Styles.appPrimaryColor),
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Pending",
                      style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Approved",
                      style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("Cancelled",
                        style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              ]),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: TabBarView(children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Utils")
                  .doc("Tweets")
                  .collection("Pending")
                  .orderBy("Timestamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CupertinoActivityIndicator(),
                          SizedBox(height: 30),
                          Text(
                            "Getting Data",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(height: 30)
                        ],
                      ),
                    );
                  default:
                    return snapshot.data.docs.isEmpty
                        ? Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "images/description.png",
                                  height: 70,
                                ),
                                verticalSpaceMedium,
                                Text(
                                  "No Pending Tweets",
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
                            children: snapshot.data.docs.map((document) {
                              Subscribed model = Subscribed.map(document);
                              return InkWell(
                                onTap: () {
                                  moveTo(
                                      context,
                                      TweetItemDetails(
                                        model: model,
                                        toApprove: true,
                                        status: "Pending",
                                      ));
                                },
                                child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            horizontalSpaceSmall,
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${model.package}  | ${model.program}",
                                                        style: GoogleFonts.nunito(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                  verticalSpaceTiny,
                                                  Row(
                                                    children: [
                                                      Text(
                                                        model.username,
                                                        style: GoogleFonts.nunito(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Text(
                                                        "  |  ",
                                                        style: GoogleFonts.nunito(
                                                            fontSize: 12,
                                                            color: Styles.appBackground,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        model.status,
                                                        style: GoogleFonts.nunito(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w600,
                                                          color: model.status == "Finished"
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios,
                                                color: Styles.appBackground, size: 20)
                                          ],
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
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Utils")
                  .doc("Tweets")
                  .collection("Approved")
                  .orderBy("Timestamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CupertinoActivityIndicator(),
                          SizedBox(height: 30),
                          Text(
                            "Getting Data",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(height: 30)
                        ],
                      ),
                    );
                  default:
                    return snapshot.data.docs.isEmpty
                        ? Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "images/description.png",
                                  height: 70,
                                ),
                                verticalSpaceMedium,
                                Text(
                                  "No Approved Tweets",
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
                            children: snapshot.data.docs.map((document) {
                              Subscribed model = Subscribed.map(document);
                              return InkWell(
                                onTap: () {
                                  moveTo(
                                      context, TweetItemDetails(model: model, status: "Approved"));
                                },
                                child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            horizontalSpaceSmall,
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${model.package}  | ${model.program}",
                                                        style: GoogleFonts.nunito(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                  verticalSpaceTiny,
                                                  Row(
                                                    children: [
                                                      Text(
                                                        model.username,
                                                        style: GoogleFonts.nunito(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Text(
                                                        "  |  ",
                                                        style: GoogleFonts.nunito(
                                                            fontSize: 12,
                                                            color: Styles.appBackground,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        model.status,
                                                        style: GoogleFonts.nunito(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w600,
                                                          color: model.status == "Finished"
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios,
                                                color: Styles.appBackground, size: 20)
                                          ],
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
              },
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Utils")
                  .doc("Tweets")
                  .collection("Cancelled")
                  .orderBy("Timestamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CupertinoActivityIndicator(),
                          SizedBox(height: 30),
                          Text(
                            "Getting Data",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          SizedBox(height: 30)
                        ],
                      ),
                    );
                  default:
                    return snapshot.data.docs.isEmpty
                        ? Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "images/description.png",
                                  height: 70,
                                ),
                                verticalSpaceMedium,
                                Text(
                                  "No Cancelled Tweets",
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
                            children: snapshot.data.docs.map((document) {
                              Subscribed model = Subscribed.map(document);
                              return InkWell(
                                onTap: () {
                                  moveTo(
                                      context, TweetItemDetails(model: model, status: "Cancelled"));
                                },
                                child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            horizontalSpaceSmall,
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${model.package}  | ${model.program}",
                                                        style: GoogleFonts.nunito(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                  verticalSpaceTiny,
                                                  Row(
                                                    children: [
                                                      Text(
                                                        model.username,
                                                        style: GoogleFonts.nunito(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Text(
                                                        "  |  ",
                                                        style: GoogleFonts.nunito(
                                                            fontSize: 12,
                                                            color: Styles.appBackground,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      Text(
                                                        model.status,
                                                        style: GoogleFonts.nunito(
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w600,
                                                          color: model.status == "Finished"
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios,
                                                color: Styles.appBackground, size: 20)
                                          ],
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
              },
            ),
          ]),
        ),
      ),
    );
  }
}
