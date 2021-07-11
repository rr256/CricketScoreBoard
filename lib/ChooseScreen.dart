import 'package:crick_score_board/TeaminfoForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:crick_score_board/ScoreBoard.dart';


import 'ScoreData.dart';

  class ChooseScreen extends StatefulWidget{
  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
    final txtController=TextEditingController();

  @override
  Widget build(BuildContext context) {

      return SafeArea(


          child: Column(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,


            children: [
              SizedBox(height: 30,),

              Text('Welcome To',
                style: TextStyle(fontFamily: 'Reggae',
                    fontSize: 50,
                  color: Color(0xff0F2180),

                ),),
              Text('CRICK SCORE BOARD',style: TextStyle(fontFamily: 'Reggae',fontSize: 30,
                  color: Color(0xff0F2180)
              ),),
             /* Center(
                child: Text('Easy to use \n Easy to Share Score Borad ',style: TextStyle(fontSize: 20,
                    color: Color(0xff0F2180)
                ),),
              ),*/
              SizedBox(height: 50),
              Center(child: Image(image:AssetImage("assets/images/logo1.png",), height: 200, )),
              Container(
                padding: EdgeInsets.all(15),
                child: TextField(
                    controller: txtController,
                  decoration: InputDecoration(
                        border: OutlineInputBorder(),
                    hintText: 'Enter The Match Code'
                  ),
                ),


              ),
              Container(width: 390,height:50,child: custombtn("View Match Score",context)),
              SizedBox(height: 30,),
              Container( width: 390,height:50,child: custombtn("Create New Match Score",context)),

            ],
          )
        );

  }

    Widget custombtn(String text,BuildContext context) {
      return OutlinedButton(
          style:OutlinedButton.styleFrom(
            backgroundColor:Color(0xff0F2180 ) ,// Color(0xffC90A39) for red
          ) ,
          onPressed: ()async{
            if(text=='View Match Score' )
              {
                String _teamname1,_teamname2;
                DatabaseReference temp=FirebaseDatabase.instance.reference().child('7M2SK'/*txtController.text*/);
                temp.onValue.listen((event)  async{
                   DataSnapshot ds=event.snapshot;
                  _teamname1=await ds.value['team1'];// +'/'
                  _teamname2=await ds.value['team2'];//+'/'
                  await print(ds.value['team1']+ds.value['team2']);
                   await  Navigator.push(context, MaterialPageRoute(builder: (context)=> SocreBorad(teamname1: _teamname1,teamname2:_teamname2 ,)));
                });
              }
            else
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TeaminfoForm()));
          },
          child: Text(text,style: TextStyle(color: Colors.white)));
    }
}

