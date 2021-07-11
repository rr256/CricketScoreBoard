import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
/*
void  main() {
  runApp(CricApp());
}*/
class CricApp extends StatefulWidget {

  @override
  _CricAppState createState() => _CricAppState();
}

class _CricAppState extends State<CricApp> {
   int ftrun=0,ftwicket=0,ftover=0,ftball=0;
   int strun=0,stwicket=0,stover=0,stball=0;
  bool fbat=true,sbat=false;
  String fstar='*',sstar='';

  Widget custombutton(String str, int score,String d){

    return Container(child: OutlineButton(
      child: Text('$str'),
      onLongPress: () {
        debugPrint(' Score coming from button-$score');
        if(d=='undo'){
          undoscore();
        }
        else { tempscore();
              runcount(score, d);}

            setState(() {
            });
      },
      highlightColor: Colors.green,


    ),

    );
  }

   int tmpe_ftrun=0,tmpe_ftwicket=0,tmpe_ftover=0,tmpe_ftball=0;
   int tmpe_strun=0,tmpe_stwicket=0,tmpe_stover=0,tmpe_stball=0;
  void tempscore(){
    debugPrint(' temp score coming-$ftrun');
     tmpe_ftrun=ftrun;tmpe_ftwicket=ftwicket;tmpe_ftover=ftover;tmpe_ftball=ftball;
     tmpe_strun=strun;tmpe_stwicket=stwicket;tmpe_stover=stover;tmpe_stball=stball;
    debugPrint(' temp score updated to temp value-$tmpe_ftrun');
  }
  void undoscore(){
     ftrun=tmpe_ftrun;ftwicket=tmpe_ftwicket;ftover=tmpe_ftover;ftball=tmpe_ftball;
     strun=tmpe_strun;stwicket=tmpe_stwicket;stover=tmpe_stover;stball=tmpe_stball;
     debugPrint(' undo  button prssed-$tmpe_ftrun');
  }



  void runcount(int score,String d){
    if(d=='run'&&fbat==true) {ftrun=ftrun+score;}
    if(d=='wicket'&&fbat==true)ftwicket=ftwicket+1;
    if(d=='run'&&sbat==true) {strun = strun + score;}
    if(d=='wicket'&&sbat==true)   stwicket=stwicket+1;
    if(d=='clear'){
      ftrun=0;ftwicket=0;stover=0;stball=0;
      strun=0;stwicket=0;ftover=0;ftball=0;
    }

    if(d=='run'||d=='wicket') ballcount();
    if(d=='widewicket'&& fbat==true){ftwicket=ftwicket+1;}
    if(d=='widewicket'&& sbat==true){stwicket=stwicket+1;}


  }

  void ballcount(){
            if(fbat==true){
              if(ftball==5){ftover=ftover+1;ftball=0;}
              else
                ftball++;
            }
            if(sbat==true){
              if(stball==5){stover=stover+1;stball=0;}
              else
                stball++;
            }

  }


  @override
  Widget build(BuildContext context) {

    double defSize=40;

    return MaterialApp(

      title: 'Cricket History',
      home: Scaffold(
          appBar: AppBar(
            title:const Text('Cricket Score Calculator') ,
            leading: IconButton(icon: Icon(Icons.arrow_back),),
            actions: [IconButton(icon: Icon(Icons.share), onPressed: null)],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.deepOrangeAccent,Colors.deepPurpleAccent],
                      begin: Alignment.bottomCenter
                  )
              ),
            ),
          ),
          body:Column(
             children: <Widget>[
               Expanded(

                 child: Column(mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(20),
                      child: GestureDetector(
                    onTap: (){
                      setState(() {
                            sstar="";
                            fstar="*";
                            fbat=true;sbat=false;

                      });
                    },
                    child: Column(children: [

                      Text("$fstar"+'First Team  $ftrun/$ftwicket',style: TextStyle(fontSize: defSize),),
                      Text('Over '+"$ftover.$ftball",textAlign:TextAlign.left)
                    ], )


                  )
                  ),
                  
                  Container(
                    child: GestureDetector(
                        onTap: (){
                            fstar="";
                            sstar="*";
                            sbat=true;fbat=false;
                          debugPrint('$stwicket'+' default-$defSize');
                          setState(() {

                          });
                        },
                        child: Column(children: [
                          Text("$sstar"+'Second Team  $strun/$stwicket',style: TextStyle(fontSize: defSize )),
                          Text('Over '+"$stover.$stball",textAlign:TextAlign.left)
                        ])),


                  ),
                 ],
               ), ),
               Expanded(

                 flex:3,
                 child: Container(color: Colors.white24,

               child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),

               children: <Widget>[
                 custombutton('one',1,'run'),
                 custombutton('two',2,'run'),
                 custombutton('three',3,'run'),
                 custombutton('four',4,'run'),
                 custombutton('six',6,'run'),
                 custombutton('no ball',0,'noball'),
                 custombutton('Wide',0,'wide'),
                 custombutton('Dot Ball',0,'run'),
                 custombutton('wicket',1,'wicket'),
                 custombutton('UNDO',0,'undo'),
                 custombutton('Wide+Stump',1,'widewicket'),
                 custombutton('Clear Result',0,'clear'),

               ],
               ),
                 )
                 ,)
             ],


          )

      ),

    );
  }
}
