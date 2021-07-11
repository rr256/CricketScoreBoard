import 'package:crick_score_board/TeaminfoForm.dart';
import 'package:flutter/material.dart';
import 'package:crick_score_board/ScoreData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

 class UmpireScoreBoard extends StatefulWidget{

  @override
  _UmpireScoreBoardState createState() => _UmpireScoreBoardState();
}

class _UmpireScoreBoardState extends State<UmpireScoreBoard> {


   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    DbRef.remove();
    team1.resetvalue();
    team2.resetvalue();
    print('Disposed Called');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: Text("Crick Score Board"),
        actions: [Icon(Icons.share)],
       // backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Container(
            //width: double.infinity,
           // height: double.infinity,
           // decoration: BoxDecoration(
              /*gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Color(0xffEA5555)
                    ,
                    Color(0xffE11717)
                  ]
                )*/
           // ),
            child: Column(
              children: [
                Text("CSK won the Toss and elected to bat ",style: TextStyle(color: Color(0xcfffffff),fontSize: 18),),
                Container(
                  height: 150,
                  width: 350,
                  //margin: EdgeInsets.only(top: 100),
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
                          Text("${first_team.run}/${first_team.wicket}",style: TextStyle(color: Color(0xffffffff),fontSize: 25)),
                          Text("${first_team.over}.${first_team.ball}/${first_team.total_over} Overs",style: TextStyle(color: Color(0xffffffff),fontSize: 15)),
                        ],
                      ),
                      Column(
                        children: [
                          Text("${team2.team_name}",style: TextStyle(color: Color(0xffffffff),fontSize: 25)),
                          Text("${second_team.run}/${second_team.wicket}",style: TextStyle(color: Color(0xffffffff),fontSize: 25)),
                          Text("${second_team.over}.${second_team.ball}/${second_team.total_over} Overs",style: TextStyle(color: Color(0xffffffff),fontSize: 15)),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [ custombutton('one',1,'run'),
                    custombutton('two',2,'run'),
                    custombutton('three',3,'run'),],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [     custombutton('four',4,'run'),
                    custombutton('six',6,'run'),
                    custombutton('no ball',0,'noball'),],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  custombutton('Wide',0,'wide'),
                  custombutton('Dot Ball',0,'run'),
                  custombutton('wicket',1,'wicket'),
                ],),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  custombutton('UNDO',0,'undo'),
                  custombutton('Wide+Stump',1,'widewicket'),
                  custombutton('Clear Result',0,'clear'),
                ],),




              ],
            )

        ),
      ),

    );
  }

  ScoreData first_team=ScoreData(0, 0, 0,team1.total_over, 0, 0, team1.team_name,team1.match_code,true);
  ScoreData second_team=ScoreData(0, 0, 0, team2.total_over,0, 0,team2.team_name,team2.match_code,false);
  DatabaseReference team1ref=DbRef.child(team1.team_name);
  DatabaseReference team2ref=DbRef.child(team2.team_name);

  Widget custombutton(String str, int score,String d){

    return Container(child: OutlineButton(
      child: Text('$str'),
      onLongPress: () {
        if(first_team.total_over==second_team.over)
              return;
        else if(d=='undo'){
          //undoscore(team1.batting?first_team:second_team);
        }
        else {
         // tempscore(team1.batting?first_team:second_team);

          runcount(score, d,team1.batting?first_team:second_team , team1.batting?team1ref:team2ref);

        }

        setState(() {
        });
      },
      highlightColor: Colors.green,


    ),

    );
  }

  ScoreData tempScore=ScoreData(0, 0, 0,team1.total_over, 0, 0, "","",true);
  void tempscore(ScoreData s){
   // debugPrint(' temp score coming-$ftrun');
    tempScore.over=s.over;
    tempScore.total_over=s.total_over;
    tempScore.team_name=s.team_name;
    tempScore.run=s.run;
    tempScore.total_fours=s.total_fours;
    tempScore.ball=s.ball;
    tempScore.wicket=s.wicket;
    tempScore.total_run=s.total_run;
    tempScore.total_six=s.total_six;
    tempScore.total_wide=s.total_wide;
   //print(' temp score updated to temp value-${tempScore.run} First Team Score${first_team.run}');
  }
  void undoscore(ScoreData s){

  }



  void runcount(int score,String d,ScoreData s,DatabaseReference ref){

    print("Team 1 ref ${ref.key}");
    if(d=='run') {ref.update({'run':'${s.run=s.run+score}'});}
    if(d=='wicket')ref.update({'wicket':'${s.wicket=s.wicket+1}'});;
    if(d=='clear'){

    }

    if(d=='run'||d=='wicket') ballcount(s,ref);
    if(d=='widewicket' ){s.wicket=s.wicket+1;}



  }

  void ballcount(ScoreData s,DatabaseReference ref){

      if(s.ball==5){

        s.over=s.over+1;s.ball=0;
        ref.update({'over':'${s.over}','ball':'0'});
      }
      else{
        s.ball++;
        ref.update({'ball':'${s.ball}'});
      }

      if(first_team.total_over==s.over)
      {
        ref.update({'batting':'${s.batting=false}'});
        team1.batting=false;
      }

  }

}