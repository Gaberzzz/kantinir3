import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../food_page/foodPage.dart';
import '../housing_page/housingPage.dart';

class Home_contentPage extends StatefulWidget {
  const Home_contentPage({super.key});

  @override
  State<Home_contentPage> createState() => _Home_contentPageState();
}

class _Home_contentPageState extends State<Home_contentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Container(child: Text("Add Sensor")),
          TextField(
            decoration: InputDecoration(hintText: "Enter Sensor ID"),
          ),
          ElevatedButton(onPressed: () {}, child: Text("Continue"))
        ],
      ),
    )
        // appBar: AppBar(
        //   body: Co
        //   title: Text('Add Sensor',
        //       style: TextStyle(color: Colors.black), textAlign: TextAlign.center),
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        );
  }
}
