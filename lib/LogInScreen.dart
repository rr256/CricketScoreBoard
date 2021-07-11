import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

    class LogInScreen extends StatefulWidget{
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Stack(
        children: [
          Image(image:AssetImage("assets/images/Untitled2.png",),height: double.infinity,   ),
          BackdropFilter(filter: ImageFilter.blur(sigmaX: 2,sigmaY: 2),child: Container(height:double.infinity,width:double.infinity,color: Colors.black.withOpacity(0.3),),),
          Center(
            child: Text('CRICK SCORE BOARD',style: TextStyle(fontFamily: 'Chela',fontSize: 40,color: Color(0xffffffff)
            ),
            ),
          )
      ],

      ),
    );

  }
}