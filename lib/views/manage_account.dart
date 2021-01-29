import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/models/user.dart';
import 'package:example/utils/functions.dart';
import 'package:example/utils/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'account_details.dart';

class ManageAccounts extends StatefulWidget {
  @override
  _ManageAccountsState createState() => _ManageAccountsState();
}

class _ManageAccountsState extends State<ManageAccounts> {
  bool turn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: !turn
              ? Text(
                  "Manage Accounts",
                  style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
                )
              : CupertinoTextField(
                  prefix: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  placeholder: "Search users...",
                  onChanged: onSearchUsers,
                  padding: EdgeInsets.all(10),
                  clearButtonMode: OverlayVisibilityMode.editing,
                ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          actions: [
            !turn
                ? InkWell(
                    onTap: () {
                      turn = !turn;
                      setState(() {});
                    },
                    child: Icon(Icons.search))
                : InkWell(
                    onTap: () {
                      turn = !turn;
                      noUserFound = false;
                      showService = true;
                      showSearch = false;
                      FocusScope.of(context).unfocus();
                      setState(() {});
                    },
                    child: Icon(Icons.close)),
            horizontalSpaceSmall
          ],
          elevation: 2),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("All")
              .orderBy("Timestamp", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CupertinoActivityIndicator());
              default:
                usersList.clear();
                return snapshot.data.docs.isEmpty
                    ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "No Account yet, Add account!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          Visibility(
                            visible: showService,
                            child: ListView(
                              children: snapshot.data.docs.map<Widget>((document) {
                                TawthraUser model = TawthraUser.map(document);
                                usersList.add(model);
                                return InkWell(
                                  onTap: () {
                                    moveTo(context, AccountDetails(model: model));
                                  },
                                  child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 2),
                                            child: Text(
                                              model.name,
                                              style: GoogleFonts.nunito(
                                                  fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(
                                              model.email,
                                              style: GoogleFonts.nunito(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey),
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
                            ),
                          ),
                          Visibility(
                            visible: showSearch,
                            child: ListView.builder(
                                itemCount: sortedList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      moveTo(context, AccountDetails(model: sortedList[index]));
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 4),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0, vertical: 2),
                                              child: Text(
                                                sortedList[index].name,
                                                style: GoogleFonts.nunito(
                                                    fontSize: 16, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Text(
                                                sortedList[index].email,
                                                style: GoogleFonts.nunito(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey),
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
                                }),
                          ),
                          Visibility(
                              child: Center(
                                  child: Text(
                                "No user found",
                                style: GoogleFonts.nunito(
                                    fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                              )),
                              visible: noUserFound)
                        ],
                      );
            }
          }),
    );
  }

  List<TawthraUser> usersList = [];
  List<TawthraUser> sortedList = [];
  bool noUserFound = false;
  bool showService = true;
  bool showSearch = false;

  void onSearchUsers(String val) {
    if (usersList != null) {
      val = val.trim();
      if (val.isNotEmpty) {
        sortedList.clear();
        for (TawthraUser item in usersList) {
          if (item.name.toUpperCase().contains(val.toUpperCase())) {
            sortedList.add(item);
          }
        }
        if (sortedList.isEmpty) {
          setState(() {
            showService = false;
            showSearch = true;
            noUserFound = true;
          });
          return;
        }
        setState(() {
          noUserFound = false;

          showService = false;
          showSearch = true;
        });
      } else {
        setState(() {
          noUserFound = false;
          showService = true;
          showSearch = false;
          FocusScope.of(context).unfocus();
        });
      }
    } else {
      return;
    }
  }
}
