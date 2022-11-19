import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'package:farm_hack/pages/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);
  static const String id = "home_page";

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  var vegetables = ['tomato', 'carrot', 'rice', 'potato', 'cereals'];

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
  //     body:FutureBuilder(
  //       future:getData(),
  //       builder:(context,AsyncSnapshot<DocumentSnapshot> snapshot){
  //         if(snapshot.connectionState==ConnectionState.done){
  //             return ListView.builder(
  //                 itemCount: 5,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return GestureDetector(
  //                     child: ListTile(
  //                         leading: Text(''),
  //                         trailing: const Text(
  //                           "Price",
  //                           style: TextStyle(color: Colors.green, fontSize: 15),
  //                         ),
  //                         title: Text("${vegetables[index]}")),
  //                     onTap: () => {Navigator.of(context).pushNamed(LoginPage.id)},
  //                   );
  //                 });
  //         }
  //         else if(snapshot.connectionState==ConnectionState.none){
  //           return Text("No connection");
  //         }
  //         return CircularProgressIndicator();
  //       },
  //   )
  //   );
  // }
     body:StreamBuilder(
       stream:FirebaseFirestore.instance.collection("groceries").snapshots(),
       builder:(context,AsyncSnapshot<QuerySnapshot> snapshot){

        if(snapshot.connectionState==ConnectionState.done){
                    return FirestoreListView(snapshot.data.docs);
                }
                else if(snapshot.connectionState==ConnectionState.none){
                  return Text("No connection");
                }
                return CircularProgressIndicator();

       },
     ));
  
  

  Future<DocumentSnapshot> getData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection("groceries")
        .doc("vegetables")
        .get();
  }

}
}

class FirestoreListView extends StatelessWidget {
  FirestoreListView(this.documents);
  final List<DocumentSnapshot> documents;



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemExtent: 90.0,
      itemBuilder: (BuildContext context, int index){

        String name = documents[index].data["title"].toString();

        return Text(name);

      },
    );
  }
}


