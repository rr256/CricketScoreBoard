import 'dart:math';
import 'dart:ui';

import 'package:crick_score_board/ScoreData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:crick_score_board/ChooseScreen.dart';
import 'package:crick_score_board/LogInScreen.dart';
import 'package:crick_score_board/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


Future<void>  main() async {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(
    MyApp(),

  );
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbApp=Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
              title: 'This Material APP Title',
                theme: theme(),
                home:FutureBuilder(
                  future: _fbApp,
                  builder: (context,snapshot){
                    if(snapshot.hasError){ print("you have an error ${snapshot.error.toString()}");return Text('Something Went Wrong');}
                    else if (snapshot.hasData){
                      print("successfully connected to firebase");
                          return MainScreen();
                    }
                    else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },

                ) /*Scaffold(
                 *//* appBar: AppBar(title: Text("CRICK SCORE BOARD",style: TextStyle(fontFamily: 'Reggae')
                    ,)
                    ,centerTitle: true,),*//*
                   body: SingleChildScrollView(

                          padding: EdgeInsets.all(20),
                      child: ChooseScreen()),
                ),*/

    );
    throw UnimplementedError();
  }

  Widget MainScreen (){
    return Scaffold(
                  appBar: AppBar(title: Text("CRICK SCORE BOARD",style: TextStyle(fontFamily: 'Reggae')
                    ,)
                    ,centerTitle: true,),
                   body: SingleChildScrollView(

                          padding: EdgeInsets.all(20),
                      child: ChooseScreen()),
                    floatingActionButton:FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: (){
                        setState(() {
                          DatabaseReference _testRef=FirebaseDatabase.instance.reference().child("test");
                          _testRef.set({
                            'id':'101',
                            'data':'This is sample value  ${getRandomString(5)}'
                          });

                          _testRef.once().then((DataSnapshot dataSnapShot){
                            print(dataSnapShot.value['data']);
                          });
                        });
                      },
                    ) ,
                );
  }



}

String getRandomString(int len) {

  var r = Random();
  const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}


