import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/models/subscribed.dart';
import 'package:example/models/twitter_into.dart';
import 'package:example/models/user.dart';
import 'package:example/utils/functions.dart';
import 'package:example/utils/spacing.dart';
import 'package:example/utils/styles.dart';
import 'package:example/views/package_details.dart';
import 'package:example/widgets/network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

class AccountDetails extends StatefulWidget {
  final TawthraUser model;

  const AccountDetails({Key key, this.model}) : super(key: key);

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  bool isLoading = false;
  TwitterInfo info = TwitterInfo();
  List<String> images = [];

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
                "Account Details",
                style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              elevation: 2),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CachedImage(size: 70, imageUrl: "kk")],
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                child: Text(
                  widget.model.name,
                  style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Center(
                child: Text(
                  widget.model.email,
                  style: GoogleFonts.nunito(
                      fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
                ),
              ),
              Divider(),
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: Container(),
                      flexibleSpace: TabBar(
                          indicatorWeight: 0,
                          isScrollable: true,
                          indicatorPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          unselectedLabelColor: Colors.grey[500],
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Styles.appPrimaryColor),
                          tabs: [
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Images",
                                  style:
                                      GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Tab(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Packages",
                                    style: GoogleFonts.nunito(
                                        fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ]),
                      iconTheme: IconThemeData(color: Colors.white),
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                      centerTitle: true,
                    ),
                    body: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: TabBarView(children: [
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Utils")
                                .doc("Images")
                                .collection(widget.model.uid)
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
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16),
                                        ),
                                        SizedBox(height: 30)
                                      ],
                                    ),
                                  );
                                default:
                                  if (snapshot.data.documents.isNotEmpty) {
                                    images = [];
                                    snapshot.data.documents.map((document) {
                                      String item = document["url"];
                                      images.add(item);
                                    }).toList();
                                    return Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: StaggeredGridView.count(
                                        shrinkWrap: true,
                                        crossAxisCount: 4,
                                        children: images.map<Widget>((item) {
                                          return Builder(builder: (context) {
                                            return ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: item ?? "k",
                                                height: 150,
                                                //  width: 100,
                                                fit: BoxFit.fitWidth,
                                                placeholder: (context, url) => Container(
                                                    height: 20,
                                                    width: 20,
                                                    child: CupertinoActivityIndicator()),
                                                errorWidget: (context, url, error) => Container(
                                                  height: 150,
                                                  //  width: 100,
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage("images/placeholder.png"),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                        }).toList(),
                                        staggeredTiles: images
                                            .map<StaggeredTile>((_) => StaggeredTile.fit(2))
                                            .toList(),
                                        mainAxisSpacing: 15.0,
                                        crossAxisSpacing: 15.0,
                                      ),
                                    );
                                  } else {
                                    return Center(child: Text("Image Library is Empty"));
                                  }
                              }
                            }),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Utils")
                              .doc("Packages")
                              .collection(widget.model.uid)
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
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
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
                                            Text(
                                              "No subscriptions yet",
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
                                              moveTo(context, PackageItemDetails(model: model));
                                            },
                                            child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 15.0, vertical: 10),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        horizontalSpaceSmall,
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "${model.package}  | ${model.program}",
                                                                    style: GoogleFonts.nunito(
                                                                        fontSize: 16,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ],
                                                              ),
                                                              verticalSpaceTiny,
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    model.status,
                                                                    style: GoogleFonts.nunito(
                                                                      fontSize: 11,
                                                                      fontWeight: FontWeight.w600,
                                                                      color:
                                                                          model.status == "Finished"
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
                ),
              )
            ],
          ),
        ));
  }
}
