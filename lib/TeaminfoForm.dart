import 'package:crick_score_board/ScoreData.dart';
import 'package:crick_score_board/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'UmpireScoreBoard.dart';
String teamcode=getRandomString(5);
DatabaseReference DbRef=FirebaseDatabase.instance.reference().child(teamcode);  //change

class TeaminfoForm extends StatefulWidget {
  @override
  _TeaminfoFormState createState() => _TeaminfoFormState();
}

class _TeaminfoFormState extends State<TeaminfoForm> {

   final controller1=TextEditingController();
   final controller2=TextEditingController();
   final controller3=TextEditingController();

   @override
   void dispose(){
     controller1.dispose();
     controller2.dispose();
     controller3.dispose();
     super.dispose();
   }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter The Match Details"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextField(
               readOnly: true,

                decoration: InputDecoration(hintText:teamcode,),            ),
            SizedBox(height: 20,),
            _textField("1st Team Name"),
            SizedBox(height: 20,),
            _textField("2nd Team Name"),
            SizedBox(height: 20,),
            _textField("Total Over"),
            OutlinedButton(onPressed: (){

              DbRef.child(controller1.text).set({
                'batting':'true',
                'run':'0',
                'wicket':'0',
                'over':'0',
                'ball':'0',
                'total_run':'0',
                'total_over':'${controller3.text}',
                'total_wide':'0',
                'total_fours':'0',
                'total_six':'0',
                'team_name':'${controller1.text}'
              });
              DbRef.child(controller2.text).set({
                'batting':'false',
                'run':'0',
                'wicket':'0',
                'over':'0',
                'ball':'0',
                'total_run':'0',
                'total_over':'${controller3.text}',
                'total_wide':'0',
                'total_fours':'0',
                'total_six':'0',
              'team_name':'${controller2.text}'
              });
              DbRef.update({
                'team1':'${controller1.text}',
                'team2':'${controller2.text}'
              });

              team1.team_name=controller1.text;
              team2.team_name=controller2.text;
              team2.total_over=int.parse(controller3.text);
              team1.total_over=team2.total_over;

            // print(" F_team ${team1.team_name} S_team ${team2.team_name} Total Over ${team1.total_over} Totel Over value ${int.parse(controller3.text)}");
             Navigator.push(context, MaterialPageRoute(builder: (context)=>UmpireScoreBoard()));
            },
                child: Text("Next +>>"))
          ],
        ),
      ),
    );
  }

  TextField _textField(String str){
    return TextField(
        controller: str=="1st Team Name"?controller1 : str=="2nd Team Name"? controller2:controller3,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: str
      ),
    );
  }

  
}
