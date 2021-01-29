import 'package:cached_network_image/cached_network_image.dart';
import 'package:example/models/subscribed.dart';
import 'package:example/utils/functions.dart';
import 'package:example/utils/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PackageItemDetails extends StatefulWidget {
  final Subscribed model;

  const PackageItemDetails({Key key, this.model}) : super(key: key);

  @override
  _PackageItemDetailsState createState() => _PackageItemDetailsState();
}

class _PackageItemDetailsState extends State<PackageItemDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            "Package Details",
            style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          elevation: 2),
      body: Container(
        padding: MediaQuery.of(context).viewInsets,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            )),
        child: ListView(
          shrinkWrap: true,
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
                      "Price: #${widget.model.price ?? "#300"}",
                      style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
            verticalSpaceTiny,
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Text(
                      "Account: ",
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        moveTo(
                            context,
                            SafeArea(
                              child: WebView(
                                initialUrl: "https://twitter.com/" + widget.model.username,
                                javascriptMode: JavascriptMode.unrestricted,
                                navigationDelegate: (NavigationRequest request) {
                                  return NavigationDecision.navigate;
                                },
                              ),
                            ));
                      },
                      child: Text(
                        "@${widget.model.username}",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      ),
                    ),
                  ],
                )),
            verticalSpaceTiny,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                "Description: ${widget.model.desc ?? "blah blah blah"}",
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
                      Icon(
                        Icons.radio_button_checked,
                        color: Colors.green,
                        size: 22,
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text("Start Date",
                              style: GoogleFonts.nunito(
                                  fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
                          Text(widget.model.startTime,
                              style: GoogleFonts.nunito(
                                  fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black))
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      horizontalSpaceMedium,
                      Column(
                        children: [
                          Text("Daily Tweet",
                              style: GoogleFonts.nunito(
                                  fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
                          Text(widget.model.noOftweets.toString() + " Tweet(s)",
                              style: GoogleFonts.nunito(
                                  fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black))
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Text",
                              style: GoogleFonts.nunito(
                                  fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
                        ],
                      ),
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
    );
  }
}
