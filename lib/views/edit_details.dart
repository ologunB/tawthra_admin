import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/utils/constants.dart';
import 'package:example/utils/spacing.dart';
import 'package:example/widgets/custom_button.dart';
import 'package:example/widgets/show_exception_alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

class EditDetails extends StatefulWidget {
  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class Item {
  Item({this.isExpanded = false});

  bool isExpanded;
}

class _EditDetailsState extends State<EditDetails> {
  List<Item> _data1 = [Item(isExpanded: false)];
  List<Item> _data2 = [Item(isExpanded: false)];
  List<Item> _data3 = [Item(isExpanded: false)];
  List<Item> _data4 = [Item(isExpanded: false)];
  List<Item> _data5 = [Item(isExpanded: false)];
  List<Item> _data6 = [Item(isExpanded: false)];

  bool isLoading = true;
  TextEditingController descController = TextEditingController();
  TextEditingController pack1ap = TextEditingController();
  TextEditingController pack1ad = TextEditingController();
  TextEditingController pack1bp = TextEditingController();
  TextEditingController pack1bd = TextEditingController();
  TextEditingController pack1cp = TextEditingController();
  TextEditingController pack1cd = TextEditingController();
  TextEditingController pack1dp = TextEditingController();
  TextEditingController pack1dd = TextEditingController();

  TextEditingController pack2a = TextEditingController();
  TextEditingController pack2b = TextEditingController();
  TextEditingController pack2c = TextEditingController();
  TextEditingController pack2d = TextEditingController();
  TextEditingController pack2e = TextEditingController();

  TextEditingController pack3a = TextEditingController();
  TextEditingController pack3b = TextEditingController();
  TextEditingController pack3c = TextEditingController();
  TextEditingController pack3d = TextEditingController();
  TextEditingController pack3e = TextEditingController();

  TextEditingController pack4a = TextEditingController();
  TextEditingController pack4b = TextEditingController();
  TextEditingController pack4c = TextEditingController();
  TextEditingController pack4d = TextEditingController();
  TextEditingController pack4e = TextEditingController();

  TextEditingController pack5a = TextEditingController();
  TextEditingController pack5b = TextEditingController();
  TextEditingController pack5c = TextEditingController();
  TextEditingController pack5d = TextEditingController();

  TextEditingController pack6a = TextEditingController();
  TextEditingController pack6b = TextEditingController();
  TextEditingController pack6c = TextEditingController();

  TextEditingController pack1desc = TextEditingController();
  TextEditingController pack2desc = TextEditingController();
  TextEditingController pack3desc = TextEditingController();
  TextEditingController pack4desc = TextEditingController();
  TextEditingController pack5desc = TextEditingController();
  TextEditingController pack6desc = TextEditingController();


  @override
  void initState() {
    getDetails();
    super.initState();
  }

  void getDetails() async {
    DocumentSnapshot doc =
    await FirebaseFirestore.instance.collection("Utils").doc("Details").get();
    descController = TextEditingController(text: doc.data()["App Description"]);

    pack1ap = TextEditingController(text: doc.data()["pack1ap"]);
    pack1ad = TextEditingController(text: doc.data()["pack1ad"]);
    pack1bp = TextEditingController(text: doc.data()["pack1bp"]);
    pack1bd = TextEditingController(text: doc.data()["pack1bd"]);
    pack1cp = TextEditingController(text: doc.data()["pack1cp"]);
    pack1cd = TextEditingController(text: doc.data()["pack1cd"]);
    pack1dp = TextEditingController(text: doc.data()["pack1dp"]);
    pack1dd = TextEditingController(text: doc.data()["pack1dd"]);

    pack2a = TextEditingController(text: doc.data()["pack2a"]);
    pack2b = TextEditingController(text: doc.data()["pack2b"]);
    pack2c = TextEditingController(text: doc.data()["pack2c"]);
    pack2d = TextEditingController(text: doc.data()["pack2d"]);
    pack2e = TextEditingController(text: doc.data()["pack2e"]);

    pack3a = TextEditingController(text: doc.data()["pack3a"]);
    pack3b = TextEditingController(text: doc.data()["pack3b"]);
    pack3c = TextEditingController(text: doc.data()["pack3c"]);
    pack3d = TextEditingController(text: doc.data()["pack3d"]);
    pack3e = TextEditingController(text: doc.data()["pack3e"]);

    pack4a = TextEditingController(text: doc.data()["pack4a"]);
    pack4b = TextEditingController(text: doc.data()["pack4b"]);
    pack4c = TextEditingController(text: doc.data()["pack4c"]);
    pack4d = TextEditingController(text: doc.data()["pack4d"]);
    pack4e = TextEditingController(text: doc.data()["pack4e"]);

    pack5a = TextEditingController(text: doc.data()["pack5a"]);
    pack5b = TextEditingController(text: doc.data()["pack5b"]);
    pack5c = TextEditingController(text: doc.data()["pack5c"]);
    pack5d = TextEditingController(text: doc.data()["pack5d"]);

    pack6a = TextEditingController(text: doc.data()["pack6a"]);
    pack6b = TextEditingController(text: doc.data()["pack6b"]);
    pack6c = TextEditingController(text: doc.data()["pack6c"]);

    pack1desc = TextEditingController(text: doc.data()["pack1desc"]);
    pack2desc = TextEditingController(text: doc.data()["pack1desc"]);
    pack3desc = TextEditingController(text: doc.data()["pack1desc"]);
    pack4desc = TextEditingController(text: doc.data()["pack1desc"]);
    pack5desc = TextEditingController(text: doc.data()["pack1desc"]);
    pack6desc = TextEditingController(text: doc.data()["pack1desc"]);

    isLoading = false;
    setState(() {});
  }

  final _formKey = GlobalKey<FormState>();

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
                "Edit Details",
                style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              elevation: 2),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: descController,
                    validator: (val) {
                      if (val.length == 0) {
                        return "App Desc is required";
                      } else {
                        return null;
                      }
                    },
                    maxLines: 4,
                    style: TextStyle(
                        color: Color(0xff071232), fontWeight: FontWeight.w500, fontSize: 16),
                    cursorColor: Color(0xff245DE8),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      fillColor: Color(0xffF3F4F8),
                      labelText: "App Description",
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
                  ),
                  verticalSpaceMedium,
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _data1[index].isExpanded = !isExpanded;
                      });
                    },
                    children: _data1.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                "Package 1",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                          body: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: pack1desc,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Package 1 Desc is required";
                                  } else {
                                    return null;
                                  }
                                },
                                maxLines: 4,
                                style: TextStyle(
                                    color: Color(0xff071232), fontWeight: FontWeight.w500, fontSize: 16),
                                cursorColor: Color(0xff245DE8),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  fillColor: Color(0xffF3F4F8),
                                  labelText: "Package 1 Description",
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
                              ),

                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program A Price", controller: pack1ap),
                              verticalSpaceSmall,
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: pack1ad,
                                maxLines: 2,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return " Desc is required";
                                  } else {
                                    return null;
                                  }
                                },
                                style: TextStyle(
                                    color: Color(0xff071232),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                cursorColor: Color(0xff245DE8),
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  fillColor: Color(0xffF3F4F8),
                                  labelText: "Program A Description",
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
                              ),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program B Price", controller: pack1bp),
                              verticalSpaceSmall,
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: pack1bd,
                                maxLines: 2,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return " Desc is required";
                                  } else {
                                    return null;
                                  }
                                },
                                style: TextStyle(
                                    color: Color(0xff071232),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                cursorColor: Color(0xff245DE8),
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  fillColor: Color(0xffF3F4F8),
                                  labelText: "Program B Description",
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
                              ),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program C Price", controller: pack1cp),
                              verticalSpaceSmall,
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: pack1cd,
                                maxLines: 2,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return " Desc is required";
                                  } else {
                                    return null;
                                  }
                                },
                                style: TextStyle(
                                    color: Color(0xff071232),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                cursorColor: Color(0xff245DE8),
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  fillColor: Color(0xffF3F4F8),
                                  labelText: "Program C Description",
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
                              ),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program D Price", controller: pack1dp),
                              verticalSpaceSmall,
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: pack1dd,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return " Desc is required";
                                  } else {
                                    return null;
                                  }
                                },
                                maxLines: 2,
                                style: TextStyle(
                                    color: Color(0xff071232),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                                cursorColor: Color(0xff245DE8),
                                decoration: InputDecoration(
                                  contentPadding:
                                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  fillColor: Color(0xffF3F4F8),
                                  labelText: "Program D Description",
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
                              ),
                            ],
                          ),
                          isExpanded: item.isExpanded,
                          canTapOnHeader: true);
                    }).toList(),
                  ),
                  verticalSpaceMedium,
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _data2[index].isExpanded = !isExpanded;
                      });
                    },
                    children: _data2.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                "Package 2",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                          body: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: pack2desc,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Package 2 Desc is required";
                                  } else {
                                    return null;
                                  }
                                },
                                maxLines: 4,
                                style: TextStyle(
                                    color: Color(0xff071232), fontWeight: FontWeight.w500, fontSize: 16),
                                cursorColor: Color(0xff245DE8),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  fillColor: Color(0xffF3F4F8),
                                  labelText: "Package 2 Description",
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
                              ),

                              CustomTextField(labelText: "Program A Price", controller: pack2a),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program B Price", controller: pack2b),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program C Price", controller: pack2c),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program D Price", controller: pack2d),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program E Price", controller: pack2e),
                            ],
                          ),
                          isExpanded: item.isExpanded,
                          canTapOnHeader: true);
                    }).toList(),
                  ),
                  verticalSpaceMedium,
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _data3[index].isExpanded = !isExpanded;
                      });
                    },
                    children: _data3.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                "Package 3",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                          body: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: pack3desc,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Package 3 Desc is required";
                                  } else {
                                    return null;
                                  }
                                },
                                maxLines: 4,
                                style: TextStyle(
                                    color: Color(0xff071232), fontWeight: FontWeight.w500, fontSize: 16),
                                cursorColor: Color(0xff245DE8),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  fillColor: Color(0xffF3F4F8),
                                  labelText: "Package 3 Description",
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
                              ),

                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program A Price", controller: pack3a),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program B Price", controller: pack3b),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program C Price", controller: pack3c),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program D Price", controller: pack3d),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program E Price", controller: pack3e),
                            ],
                          ),
                          isExpanded: item.isExpanded,
                          canTapOnHeader: true);
                    }).toList(),
                  ),
                  verticalSpaceMedium,
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _data4[index].isExpanded = !isExpanded;
                      });
                    },
                    children: _data4.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                "Package 4",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                          body: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: pack4desc,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Package 4 Desc is required";
                                  } else {
                                    return null;
                                  }
                                },
                                maxLines: 4,
                                style: TextStyle(
                                    color: Color(0xff071232), fontWeight: FontWeight.w500, fontSize: 16),
                                cursorColor: Color(0xff245DE8),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  fillColor: Color(0xffF3F4F8),
                                  labelText: "Package 4 Description",
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
                              ),

                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program A Price", controller: pack4a),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program B Price", controller: pack4b),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program C Price", controller: pack4c),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program D Price", controller: pack4d),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program E Price", controller: pack4e),
                            ],
                          ),
                          isExpanded: item.isExpanded,
                          canTapOnHeader: true);
                    }).toList(),
                  ),
                  verticalSpaceMedium,
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _data5[index].isExpanded = !isExpanded;
                      });
                    },
                    children: _data5.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                "Package 5",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                          body: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: pack5desc,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Package 5 Desc is required";
                                  } else {
                                    return null;
                                  }
                                },
                                maxLines: 4,
                                style: TextStyle(
                                    color: Color(0xff071232), fontWeight: FontWeight.w500, fontSize: 16),
                                cursorColor: Color(0xff245DE8),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  fillColor: Color(0xffF3F4F8),
                                  labelText: "Package 5 Description",
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
                              ),

                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program A Price", controller: pack5a),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program B Price", controller: pack5b),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program C Price", controller: pack5c),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program D Price", controller: pack5d),
                            ],
                          ),
                          isExpanded: item.isExpanded,
                          canTapOnHeader: true);
                    }).toList(),
                  ),
                  verticalSpaceMedium,
                  ExpansionPanelList(
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        _data6[index].isExpanded = !isExpanded;
                      });
                    },
                    children: _data6.map<ExpansionPanel>((Item item) {
                      return ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return ListTile(
                              title: Text(
                                "Package 6",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                          body: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: pack6desc,
                                validator: (val) {
                                  if (val.length == 0) {
                                    return "Package 6 Desc is required";
                                  } else {
                                    return null;
                                  }
                                },
                                maxLines: 4,
                                style: TextStyle(
                                    color: Color(0xff071232), fontWeight: FontWeight.w500, fontSize: 16),
                                cursorColor: Color(0xff245DE8),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  fillColor: Color(0xffF3F4F8),
                                  labelText: "Package 6 Description",
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
                              ),

                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program A Price", controller: pack6a),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program B Price", controller: pack6b),
                              verticalSpaceSmall,
                              CustomTextField(labelText: "Program C Price", controller: pack6c),
                              verticalSpaceSmall,
                            ],
                          ),
                          isExpanded: item.isExpanded,
                          canTapOnHeader: true);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
              padding: EdgeInsets.all(10),
              child: CustomButton(
                  title: "Update Details",
                  onPressed: () {
                    offKeyboard(context);
                    _formKey.currentState.save();
                    _formKey.currentState.validate();

                    if (!_formKey.currentState.validate()) {
                      showSnackBar(context, "Error", "Fill all the empty Fields");
                      return;
                    }

                    showTweetDialog(context,
                        type: "Alert",
                        message: "Are you sure you want to update the details?", onPressed: () {
                          updateDetails(context);
                        });
                  })),
        ));
  }

  updateDetails(context) {
    Navigator.pop(context);
    isLoading = true;
    setState(() {});
    Map<String, Object> mData = Map();
    mData.putIfAbsent("App Description", () => descController.text);
    mData.putIfAbsent("pack1ap", () => pack1ap.text);
    mData.putIfAbsent("pack1ad", () => pack1ad.text);
    mData.putIfAbsent("pack1bp", () => pack1bp.text);
    mData.putIfAbsent("pack1bd", () => pack1bd.text);
    mData.putIfAbsent("pack1cp", () => pack1cp.text);
    mData.putIfAbsent("pack1cd", () => pack1cd.text);
    mData.putIfAbsent("pack1dp", () => pack1dp.text);
    mData.putIfAbsent("pack1dd", () => pack1dd.text);

    mData.putIfAbsent("pack2a", () => pack2a.text);
    mData.putIfAbsent("pack2b", () => pack2b.text);
    mData.putIfAbsent("pack2c", () => pack2c.text);
    mData.putIfAbsent("pack2d", () => pack2d.text);
    mData.putIfAbsent("pack2e", () => pack2e.text);

    mData.putIfAbsent("pack3a", () => pack3a.text);
    mData.putIfAbsent("pack3b", () => pack3b.text);
    mData.putIfAbsent("pack3c", () => pack3c.text);
    mData.putIfAbsent("pack3d", () => pack3d.text);
    mData.putIfAbsent("pack3e", () => pack3e.text);

    mData.putIfAbsent("pack4a", () => pack4a.text);
    mData.putIfAbsent("pack4b", () => pack4b.text);
    mData.putIfAbsent("pack4c", () => pack4c.text);
    mData.putIfAbsent("pack4d", () => pack4d.text);
    mData.putIfAbsent("pack4e", () => pack4e.text);

    mData.putIfAbsent("pack5a", () => pack5a.text);
    mData.putIfAbsent("pack5b", () => pack5b.text);
    mData.putIfAbsent("pack5c", () => pack5c.text);
    mData.putIfAbsent("pack5d", () => pack5d.text);

    mData.putIfAbsent("pack6a", () => pack6a.text);
    mData.putIfAbsent("pack6b", () => pack6b.text);
    mData.putIfAbsent("pack6c", () => pack6c.text);

    mData.putIfAbsent("pack1desc", () => pack1desc.text);
    mData.putIfAbsent("pack2desc", () => pack2desc.text);
    mData.putIfAbsent("pack3desc", () => pack3desc.text);
    mData.putIfAbsent("pack4desc", () => pack4desc.text);
    mData.putIfAbsent("pack5desc", () => pack5desc.text);
    mData.putIfAbsent("pack6desc", () => pack6desc.text);


    FirebaseFirestore.instance.collection("Utils").doc("Details").update(mData).then((value) {
      isLoading = false;
      setState(() {});
      showSnackBar(context, "Alert", "Details Updated");
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      showExceptionAlertDialog(context: context, exception: e, title: "Error");
    });
  }
}

class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  String labelText;

  CustomTextField({this.labelText, this.controller});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: widget.controller,
      maxLines: 1,
      style: TextStyle(color: Color(0xff071232), fontWeight: FontWeight.w500, fontSize: 16),
      cursorColor: Color(0xff245DE8),
      validator: (val) {
        if (val.length == 0) {
          return "${widget.labelText} is required";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        fillColor: Color(0xffF3F4F8),
        labelText: widget.labelText,
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
    );
  }
}
