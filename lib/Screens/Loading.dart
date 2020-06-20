import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inbreif/ScreenConfig.dart';
import 'Dashboard.dart';

class Brief_Loading extends StatefulWidget {
  @override
  _Brief_LoadingState createState() => _Brief_LoadingState();
}

class _Brief_LoadingState extends State<Brief_Loading> {


  Future<Timer> timer()async{
    return Future.delayed(Duration(seconds:3),(){
      return Navigator.push(context, MaterialPageRoute(builder: (context)=>Brief_Dashboard()));
    });
  }


  @override
  void initState() {
    timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFF292D32),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(child: Text('InBrief',
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical*5,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),),
              SizedBox(height: 5,),
              CircleAvatar(
                backgroundColor: Color(0xFF292D32),
                radius: SizeConfig.blockSizeVertical*10,
                backgroundImage: AssetImage('images/ic_launcher.png'),
              ),
              SizedBox(height: 5,),
              SpinKitRing(color: Colors.white,size: 50,)
            ],
          )
      ),
    );
  }
}
