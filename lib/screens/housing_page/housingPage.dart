import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kantinir_mobile_app/screens/theme.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../food_page/foodPage.dart';
import '../housing_page/housingPage.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({super.key});

  @override
  State<HousingPage> createState() => _housingPageState();
}

class _housingPageState extends State<HousingPage> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference _kaon =
        FirebaseFirestore.instance.collection("tinir");
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        body: Center(
          child: Column(
            children: [
              Container(
                height: 500,
                child: StreamBuilder(
                  stream: _kaon.snapshots(),
                  builder: (context, AsyncSnapshot snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      );
                    }
                    if (snapshots.hasData) {
                      return ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot records =
                              snapshots.data!.docs[index];
                          return Slidable(
                            startActionPane:
                                ActionPane(motion: StretchMotion(), children: [
                              // SlidableAction(
                              //   onPressed: (context) {
                              //     navigateToNewPage(context);
                              //   },
                              //   icon: Icons.phone,
                              //   backgroundColor: Colors.blue,
                              // )
                            ]),
                            child: ListTile(
                              title: Text(records["name"]),
                              subtitle: Text(records["owner"] +
                                  '\n' +
                                  (records["fb link"]) +
                                  '\n' +
                                  (records["location"])),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        // appBar: AppBar(
        //   body: Co
        //   title: Text('Add Sensor',
        //       style: TextStyle(color: Colors.black), textAlign: TextAlign.center),
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
      );
    });
  }
}
