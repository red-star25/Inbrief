import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../ScreenConfig.dart';

class Info extends StatefulWidget {
  String search;
  Info({this.search});
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final api = "API_KEY";
  Future getData() async {
    final url =
        "https://newsapi.org/v2/everything?q=${widget.search}&apiKey=$api";
    final response = await http.get(url);
    final jsonData = jsonDecode(response.body);
    return jsonData;
  }



  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).pop();
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          backgroundColor: Color(0xFF292D32),
        body: FutureBuilder(
          future: getData(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return SpinKitDoubleBounce(color: Colors.black,);
            }
            return PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data["articles"].length,
              itemBuilder: (context,index){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          height: SizeConfig.blockSizeVertical*38,
                          width: SizeConfig.blockSizeHorizontal*100,
                          child: ClipPath(
                            clipper: Clipper(),
                            child: snapshot.data["articles"][index]["urlToImage"]!=null?Image(
                              image: NetworkImage(snapshot.data["articles"][index]["urlToImage"]),fit: BoxFit.cover,):Center(child: Text("No Image Preview",style: TextStyle(color: Colors.black),),),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          width: SizeConfig.blockSizeHorizontal*100,
                          child: Text(
                            snapshot.data["articles"][index]["title"]!=null?snapshot.data["articles"][index]["title"]:"",
                            style: GoogleFonts.russoOne(color: Colors.white,fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical*2,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          width: SizeConfig.blockSizeHorizontal*100,
                          child: Text(
                            snapshot.data["articles"][index]["description"]!=null?snapshot.data["articles"][index]["description"]:"",
                            style: GoogleFonts.dmSans(color: Colors.white,fontSize: 15),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical*4,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            snapshot.data["articles"][index]["author"]!=null? "Source: ${snapshot.data["articles"][index]["author"]}":"",
                            style: GoogleFonts.ubuntu(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                              snapshot.data["articles"][index]["publishedAt"]!=null?"${snapshot.data["articles"][index]["publishedAt"]}":"",
                              style: GoogleFonts.ubuntu(
                                  fontSize: 10,
                                  color: Colors.white
                              )
                          ),
                        ),

                      ],
                    ),
                    GestureDetector(
                      onTap:(){
                        _launchURL(snapshot.data["articles"][index]["url"]);
                      },
                      child: Container(
                        height: SizeConfig.blockSizeVertical*6,
                        width: SizeConfig.blockSizeHorizontal*100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                                colors: [
                                  Colors.black54,
                                  Colors.white12
                                ]
                            )
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Click here for more Information",
                            style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 10
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          },
        )
      ),
    );
  }
}

class Clipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, size.height
        - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(3 / 4 * size.width, size.height,
        size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)=>false;

}