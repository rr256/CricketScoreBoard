
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class ScoreData{
  int run,wicket,over,ball,total_run,total_over,total_wide,total_fours,total_six;
   String team_name,match_code;
   bool batting=false;
  DatabaseReference temp=FirebaseDatabase.instance.reference().child('7M2SK'/*txtController.text*/);
  ScoreData(this.run, this.wicket, this.over,this.total_over, this.ball, this.total_run, this.team_name, this.match_code,this.batting);

  toJson(DataSnapshot ds){
    run=int.parse(ds.value['run']);
    wicket=int.parse(ds.value['wicket']);
    over=int.parse(ds.value['over']);
    ball=int.parse(ds.value['ball']);
    total_run=int.parse(ds.value['total_run']);
    total_over=int.parse(ds.value['total_over']);
    total_wide=int.parse(ds.value['total_wide']);
    total_fours=int.parse(ds.value['total_fours']);
    total_six=int.parse(ds.value['total_six']);
    team_name=ds.value['team_name'];
    match_code==ds.value['match_code'];
    batting=true;
  }
  toPrint(){
    print('TEAM NAME:-${team_name} ,RUN:-${run} ,Wicket:-${wicket} ,TOTAL RUN:-${total_run} ,OVER:- ${over} ,MATCH CODE${match_code}');
  }
  resetvalue(){
    run=wicket=over=ball=total_run=total_over=total_wide=total_fours=total_six=0;
    team_name=match_code="";
  }

  UpdatingData(String tm){  print("My database ref called");
    temp.child(tm).onValue.listen((event)  async{
      DataSnapshot ds=event.snapshot;
      team2.toJson(ds);

    });

  }
}

ScoreData team1=new ScoreData(0, 0, 0, 0,0, 0, "team1", "",true);
ScoreData team2=new ScoreData(0, 0, 0,0, 0, 0, "team2", "",false);
