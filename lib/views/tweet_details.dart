import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/models/subscribed.dart';
import 'package:example/utils/constants.dart';
import 'package:example/utils/error_util.dart';
import 'package:example/utils/spacing.dart';
import 'package:example/utils/styles.dart';
import 'package:example/widgets/custom_button.dart';
import 'package:example/widgets/show_alert_dialog.dart';
import 'package:example/widgets/show_exception_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

class TweetItemDetails extends StatefulWidget {
  final Subscribed model;
  final bool toApprove;
  final String status;

  TweetItemDetails({this.model, this.toApprove = false, this.status});

  @override
  _TweetItemDetailsState createState() => _TweetItemDetailsState();
}

class _TweetItemDetailsState extends State<TweetItemDetails> {
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
                "Tweet Details",
                style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              elevation: 2),
          bottomNavigationBar: widget.toApprove
              ? Row(
                  children: [
                    Flexible(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      child: CustomButton(
                          title: "Reject Package",
                          color: Colors.red,
                          textColor: Colors.white,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Are you sure you want to reject this package",
                                      style: GoogleFonts.nunito(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                              child: Text(
                                                "NO",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 12,
                                                    color: Styles.colorBlack,
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          horizontalSpaceMedium,
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              reject(context);
                                            },
                                            child: Container(
                                              padding:
                                                  EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: Styles.appPrimaryColor),
                                              child: Text(
                                                "YES",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 12,
                                                    letterSpacing: 1,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            );
                          }),
                    )),
                    Flexible(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      child: CustomButton(
                          title: "Approve Package",
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Are you sure you want to approve this package",
                                      style: GoogleFonts.nunito(
                                          fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                              child: Text(
                                                "NO",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 12,
                                                    color: Styles.colorBlack,
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          horizontalSpaceMedium,
                                          InkWell(
                                            onTap: () async {
                                              Navigator.pop(context);
                                              approve(context);
                                            },
                                            child: Container(
                                              padding:
                                                  EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: Styles.appPrimaryColor),
                                              child: Text(
                                                "YES",
                                                style: GoogleFonts.nunito(
                                                    fontSize: 12,
                                                    letterSpacing: 1,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            );
                          }),
                    )),
                  ],
                )
              : SizedBox(),
          body: Container(
            padding: MediaQuery.of(context).viewInsets,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Text(
                          widget.model.package,
                          style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        horizontalSpaceSmall,
                        Text(
                          widget.model.program,
                          style: GoogleFonts.nunito(
                              fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          "Price: ${widget.model.price ?? "#300"}",
                          style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
                verticalSpaceTiny,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    " Description: ${widget.model.desc ?? "blah blah blah"}",
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
                              Text("Status",
                                  style: GoogleFonts.nunito(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey)),
                              Text(widget.status,
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: color(widget.status))),
                            ],
                          ),
                          horizontalSpaceMedium,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.radio_button_checked,
                                    color: color(widget.status),
                                    size: 22,
                                  ),
                                ],
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text("Starting Date",
                                      style: GoogleFonts.nunito(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey)),
                                  Text(widget.model.startTime,
                                      style: GoogleFonts.nunito(
                                          fontSize: 14,
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
                          Text("Text",
                              style: GoogleFonts.nunito(
                                  fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
                          verticalSpaceTiny,
                          Text(widget.model.text,
                              style: GoogleFonts.nunito(
                                  fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Images",
                          style: GoogleFonts.nunito(
                              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
                      Container(
                        height: 120,
                        child: ListView.builder(
                          itemCount: widget.model.images.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                              child: CachedNetworkImage(
                                imageUrl: widget.model.images[index]["image"],
                                height: 100,
                                width: 100,
                                placeholder: (context, url) => Container(
                                    height: 20, width: 20, child: CupertinoActivityIndicator()),
                                errorWidget: (context, url, error) => Container(
                                  height: 100,
                                  width: 100,
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage("images/placeholder.png"),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpaceMedium
              ],
            ),
          ),
        ));
  }

  Color color(String text) {
    if (text == "Pending") {
      return Colors.blue;
    } else if (text == "Approved") {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  void approve(BuildContext context) async {
    Map<String, dynamic> mData = Map();
    widget.model.toJson().forEach((key, value) => mData.putIfAbsent(key, () => value));
    mData.update("status", (a) => "Pending", ifAbsent: () => "Pending");

    try {
      var dataRes = await dio.post("https://thatra.herokuapp.com/api/v1/package1/",
          options: defaultOptions, data: mData);

      print(dataRes);
      switch (dataRes.statusCode) {
        case 201:
          mData.update("id", (a) => dataRes.data["id"]);

          FirebaseFirestore _firestore = FirebaseFirestore.instance;

          WriteBatch writeBatch = _firestore.batch();
          writeBatch.set(
              _firestore
                  .collection("Utils")
                  .doc("Tweets")
                  .collection("Approved")
                  .doc(widget.model.timeStamp),
              mData);

          writeBatch.update(
              _firestore
                  .collection("Utils")
                  .doc("Packages")
                  .collection(widget.model.uid)
                  .doc(widget.model.timeStamp),
              {"status": "Pending"});

          writeBatch.delete(_firestore
              .collection("Utils")
              .doc("Tweets")
              .collection("Pending")
              .doc(widget.model.timeStamp));

          writeBatch.commit().then((value) {
            setState(() {
              isLoading = false;
            });
            Navigator.pop(context);
          }).catchError((e){
            setState(() {
              isLoading = false;
            });
            showExceptionAlertDialog(context: context, exception: e, title: "Error");

          });

          break;
        default:
          setState(() {
            isLoading = false;
          });
          showAlertDialog(
              context: context,
              content:dataRes.data["message"] ?? "Unknown Error",
              title: "Error",
              defaultActionText: "OK");
          throw dataRes.data["message"] ?? "Unknown Error";
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      showAlertDialog(
          context: context,
          content: DioErrorUtil.handleError(e),
          title: "Error",
          defaultActionText: "OK");
      throw DioErrorUtil.handleError(e);
    }
  }

  void reject(BuildContext context) async {
    Map<String, dynamic> mData = Map();
    widget.model.toJson().forEach((key, value) => mData.putIfAbsent(key, () => value));
    mData.update("status", (a) => "Cancelled", ifAbsent: () => "Cancelled");

    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    WriteBatch writeBatch = _firestore.batch();
    writeBatch.set(
        _firestore
            .collection("Utils")
            .doc("Tweets")
            .collection("Cancelled")
            .doc(widget.model.timeStamp),
        mData);

    writeBatch.update(
        _firestore
            .collection("Utils")
            .doc("Packages")
            .collection(widget.model.uid)
            .doc(widget.model.timeStamp),
        {"status": "Pending"});

    writeBatch.delete(_firestore
        .collection("Utils")
        .doc("Tweets")
        .collection("Pending")
        .doc(widget.model.timeStamp));

    writeBatch.commit().then((value) {
      Navigator.pop(context);
      setState(() {
        isLoading = false;
      });
    }).catchError((e){
      setState(() {
        isLoading = false;
      });
      showExceptionAlertDialog(context: context, exception: e, title: "Error");

    });
  }
}
