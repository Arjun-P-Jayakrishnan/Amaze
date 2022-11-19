import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_hack/pages/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../pages/homepage.dart';




class storage extends StatelessWidget {
  const storage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:Firebase.initializeApp(),
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Text('Error');
        }
         if(snapshot.connectionState==ConnectionState.done){
           return Homepage();
         }
        return Text('Loading');
      },
    );
  }
}
