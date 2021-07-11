

import 'package:crick_score_board/ScoreData.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';



  class SocreBorad extends StatefulWidget{
    final String teamname1,teamname2;

  const SocreBorad({Key key, this.teamname1, this.teamname2}) : super(key: key);


   @override
  _SocreBoradState createState() => _SocreBoradState(teamname1,teamname2);
}

//this is in bugfix code
class _SocreBoradState extends State<SocreBorad> {
  final String teamname1,teamname2;
    DatabaseReference temp=FirebaseDatabase.instance.reference().child('7M2SK'/*txtController.text*/);
  _SocreBoradState(this.teamname1, this.teamname2);

 void _mydata() {
  print("My database ref called");
   temp.child(teamname1).onValue.listen((event)  async{
      DataSnapshot ds=event.snapshot;
       team1.toJson(ds);
          setState(() {

          });
   });
   temp.child(teamname2).onValue.listen((event) async{
     DataSnapshot ds=event.snapshot;
      team2.toJson(ds); //team2.toPrint();
            setState(() {

            });
   });

 }


    @override
  void initState() {
    // TODO: implement initState
      print("Value of team 1 & team 2 are:${teamname2} and ${teamname1}");
      _mydata();
    super.initState();
  }

  @override
  void dispose() {
   print("disposed method called");
    team1.resetvalue();
    team2.resetvalue();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Welcome To ScoreBoard");
    print("team 1 name :${team1.team_name} & team 2 name : ${team2.team_name}");
    return screen();
  }


    Widget screen(){
      return Scaffold(
        appBar: AppBar(
          title: Text("Crick Score Board"),
          actions: [Icon(Icons.share)],
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                /*gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color(0xffEA5555)
                    ,
                    Color(0xffE11717)
                  ]
                )*/
              ),
              child: Column(
                children: [
                  Text("CSK won the Toss and elected to bat ",style: TextStyle(color: Color(0x5f0F2180),fontSize: 18),),
                  Container(
                    height: 150,
                    width: 350,
                    margin: EdgeInsets.only(top: 100),
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Color(0xff0F2180),//Color(0xff0F2180 ) for Blue  Color(0xffd92027) // for red
                        boxShadow: [BoxShadow(
                          color: Color(0x5f0F2180),
                          blurRadius: 25,

                        )],
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [

                            Text("${team1.team_name}",style: TextStyle(color: Color(0xffffffff),fontSize: 25)),
                            Text("${team1.run}/${team1.wicket}",style: TextStyle(color: Color(0xffffffff),fontSize: 25)),

                            Text("${team1.over}.${team1.ball}/${team1.total_over} Overs",style: TextStyle(color: Color(0xffffffff),fontSize: 15)),
                          ],
                        ),
                        Column(
                          children: [
                            Text("${team2.team_name}",style: TextStyle(color: Color(0xffffffff),fontSize: 25)),
                            Text("${team2.run}/${team2.wicket}",style: TextStyle(color: Color(0xffffffff),fontSize: 25)),
                            Text("${team2.over}.${team2.ball}/${team2.total_over} Overs",style: TextStyle(color: Color(0xffffffff),fontSize: 15)),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )

          ),
        ),

        floatingActionButton: FloatingActionButton(
           child: Icon(Icons.refresh),
          onPressed: (){
            _mydata();
                          },
        ),
      );
    }
}

