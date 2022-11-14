import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      home: AddData(),
    );
  }
}

class AddData extends StatefulWidget {
  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  late String b="Group_1.png";

  int IconNumber = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: 56),
            InkWell(
              onTap: ()=>setState(() {
                switch(IconNumber){
                  case 1: //IconNumber=2;
                  b =  "Group_2.png";
                  break;
                  case 2: //IconNumber=3;
                  b = "Group_3.png";
                  break;
                  case 3: //IconNumber=1;
                  b = "Group_1.png";
                  break;
                }
                var db = FirebaseFirestore.instance;
                final batch = db.batch();
                var data = db.collection("data").doc("lPc0VxgfTplsjEYgUAu4");
                var _increment = increment(IconNumber);
               // IconNumber=_increment;
                print(IconNumber);
                batch.update(data, {"values": _increment});
                batch.commit().then((_) {
                });
              }),
              child: Image.asset('lib/images/$b', height: 100, width: 100,),
            ),
            SizedBox(height: 30),
             Text(
                 "Value is $IconNumber",
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 25,
                 ),
             ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  increment(int iconNumber) {
    switch(IconNumber){
      case 1: IconNumber=2;
      break;
      case 2: IconNumber=3;
      break;
      case 3: IconNumber=1;
      break;
    }
    return IconNumber;
  }
}


