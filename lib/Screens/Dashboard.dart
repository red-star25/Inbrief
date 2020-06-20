import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:inbreif/Screens/Categories.dart';
import 'package:inbreif/Screens/SerachPage.dart';
import 'package:inbreif/Screens/infoPage.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ScreenConfig.dart';

class Brief_Dashboard extends StatefulWidget {
  @override
  _Brief_DashboardState createState() => _Brief_DashboardState();
}

class _Brief_DashboardState extends State<Brief_Dashboard> {

  final api = "API_KEY";


  Future getData() async{
    final url="https://newsapi.org/v2/top-headlines?country=in&pageSize=100&apiKey=$api";
    final response = await http.get(url);
    final jsonData = jsonDecode(response.body);
    return jsonData;
  }


  connect()async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      }
    } on SocketException catch (_) {
      final snackBar = SnackBar(
        content: Text(
          'No Internet',
          style: TextStyle(fontSize: 16),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      );
      scaffold_state.currentState.showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    connect();
    getData();
    super.initState();
  }


  Future<bool> _onBackPressed() {
      exit(0);
  }

  GlobalKey<ScaffoldState> scaffold_state = new GlobalKey<ScaffoldState>();
  bool searchBar=false;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex=0;
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: CupertinoTabBar(
            backgroundColor: Colors.black,
              currentIndex: currentIndex,
              onTap: (val){
                print(val);
              },
              activeColor: Colors.red,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.whatshot,),

                ),
                BottomNavigationBarItem(
                  icon: IconButton(icon:Icon(Icons.category),onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Categories()));
                  },),

                ),
                BottomNavigationBarItem(
                  icon: IconButton(icon:Icon(Icons.search,size: 35,color: Colors.white,),onPressed: (){
                    setState(() {
                      searchBar=true;
                    });
                  },),

                ),
                BottomNavigationBarItem(
                  icon: IconButton(icon:Icon(Icons.share,),onPressed: (){
                    Share.share("Download InBrief News App :\nhttps://play.google.com/store/apps/details?id=com.NakumsDtech.inbreif");
                  },)

                ),
                BottomNavigationBarItem(
                  icon: IconButton(icon:Icon(Icons.info_outline),onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>InfoPage()
                    ));
                  },)

                ),
              ]
          ),
            key: scaffold_state,
            backgroundColor: Color(0xFF292D32),
            body:FutureBuilder(
              future: getData(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return SpinKitDoubleBounce(color: Colors.black,);
                }
                return LayoutBuilder(
                    builder:(context,constraint) {
                      if(constraint.maxHeight<=740&&constraint.maxWidth<=360){
                        return PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data["articles"].length,
                          itemBuilder: (context,index){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: Stack(
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
                                      !searchBar?Container(
                                        width: SizeConfig.blockSizeHorizontal*100,
                                        height: SizeConfig.blockSizeVertical*6,
                                        color:Colors.black.withOpacity(0.7),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Divider(color: Colors.white,),
                                            FlatButton(
                                              splashColor: Colors.red,
                                              onPressed:(){
                                                Share.share("Read This Interesting News :${snapshot.data["articles"][index]["url"]}\nDownload InBrief News App :\nhttps://play.google.com/store/apps/details?id=com.NakumsDtech.inbreif");
                                              },
                                              child:Icon(Icons.share,color: Colors.white),),
                                            Divider(color: Colors.white,),
                                            FlatButton(
                                                splashColor: Colors.red,
                                                onPressed: ()=>_launchURL('https://play.google.com/store/apps/details?id=com.NakumsDtech.inbreif'),
                                                child:Icon(Icons.star,color: Colors.white,)),
                                          ],
                                        ),
                                      ):
                                      Card(
                                        color: Colors.white70,
                                        child: Container(
                                          height: SizeConfig.blockSizeVertical * 7,
                                          width: SizeConfig.blockSizeHorizontal * 100,
                                          child: TextField(
                                            style: TextStyle(color: Colors.black),
                                            onSubmitted: (value){
                                              if(value=="") {
                                                final snackBar = SnackBar(
                                                  content: Text(
                                                    'No News Found',
                                                    style: TextStyle(fontSize: SizeConfig.blockSizeVertical *2,),
                                                  ),
                                                  duration: Duration(seconds: 2),
                                                  backgroundColor: Colors.green,
                                                );
                                                scaffold_state.currentState.showSnackBar(snackBar);
                                                searchBar=false;
                                              }
                                              else{
                                                searchBar = false;
                                                Navigator.push(context, MaterialPageRoute(builder: (
                                                    context) => Info(search:value,)));
                                              }
                                            },

                                            decoration: InputDecoration(
                                                icon: Icon(Icons.search,color: Colors.black,),
                                                suffixIcon: IconButton(icon:Icon(Icons.cancel,color: Colors.black,),onPressed: (){
                                                  setState(() {
                                                    searchBar=false;
                                                  });
                                                },),
                                                border: OutlineInputBorder(),
                                                hintText: "Search News",
                                                hintStyle: TextStyle(color: Colors.black,)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex:4,
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width: SizeConfig.blockSizeHorizontal*100,
                                          child: Text(
                                            snapshot.data["articles"][index]["title"]!=null?snapshot.data["articles"][index]["title"]:"",
                                            style: GoogleFonts.russoOne(color: Colors.white,fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width: SizeConfig.blockSizeHorizontal*100,
                                          child: Text(
                                            snapshot.data["articles"][index]["description"]!=null?"${snapshot.data["articles"][index]["description"]}":"",
                                            style: GoogleFonts.dmSans(color: Colors.white,fontSize: 15),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
//                                SizedBox(
//                                  height: SizeConfig.blockSizeVertical*14,
//                                ),
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
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
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
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data["articles"].length,
                        itemBuilder: (context,index){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Stack(
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
                                    !searchBar?Container(
                                      width: SizeConfig.blockSizeHorizontal*100,
                                      height: SizeConfig.blockSizeVertical*6,
                                      color:Colors.black.withOpacity(0.7),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Divider(color: Colors.white,),
                                          FlatButton(
                                            splashColor: Colors.red,
                                            onPressed:(){
                                              Share.share("Read This Interesting News :${snapshot.data["articles"][index]["url"]}\nDownload InBrief News App :\nhttps://play.google.com/store/apps/details?id=com.NakumsDtech.inbreif");
                                            },
                                            child:Icon(Icons.share,color: Colors.white),),
                                          Divider(color: Colors.white,),
                                          FlatButton(
                                              splashColor: Colors.red,
                                              onPressed: ()=>_launchURL('https://play.google.com/store/apps/details?id=com.NakumsDtech.inbreif'),
                                              child:Icon(Icons.star,color: Colors.white,)),
                                        ],
                                      ),
                                    ):
                                    Card(
                                      color: Colors.white70,
                                      child: Container(
                                        height: SizeConfig.blockSizeVertical * 7,
                                        width: SizeConfig.blockSizeHorizontal * 100,
                                        child: TextField(
                                          style: TextStyle(color: Colors.black),
                                          onSubmitted: (value){
                                            if(value=="") {
                                              final snackBar = SnackBar(
                                                content: Text(
                                                  'No News Found',
                                                  style: TextStyle(fontSize: SizeConfig.blockSizeVertical *2,),
                                                ),
                                                duration: Duration(seconds: 2),
                                                backgroundColor: Colors.green,
                                              );
                                              scaffold_state.currentState.showSnackBar(snackBar);
                                              searchBar=false;
                                            }
                                            else{
                                              searchBar = false;
                                              Navigator.push(context, MaterialPageRoute(builder: (
                                                  context) => Info(search:value,)));
                                            }
                                          },

                                          decoration: InputDecoration(
                                              icon: Icon(Icons.search,color: Colors.black,),
                                              suffixIcon: IconButton(icon:Icon(Icons.cancel,color: Colors.black,),onPressed: (){
                                                setState(() {
                                                  searchBar=false;
                                                });
                                              },),
                                              border: OutlineInputBorder(),
                                              hintText: "Search News",
                                              hintStyle: TextStyle(color: Colors.black,)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        flex:6,
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width: SizeConfig.blockSizeHorizontal*100,
                                          child: Text(
                                            snapshot.data["articles"][index]["title"]!=null?snapshot.data["articles"][index]["title"]:"",
                                            style: GoogleFonts.russoOne(color: Colors.white,fontSize: 25),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          width: SizeConfig.blockSizeHorizontal*100,
                                          child: Text(
                                            snapshot.data["articles"][index]["description"]!=null?snapshot.data["articles"][index]["description"]:"",
                                            style: GoogleFonts.dmSans(color: Colors.white,fontSize: 20),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          snapshot.data["articles"][index]["author"]!=null? "Source: ${snapshot.data["articles"][index]["author"]}":"",
                                          style: GoogleFonts.ubuntu(
                                            fontSize: SizeConfig.blockSizeVertical*2,
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
                                                fontSize: SizeConfig.blockSizeVertical*2,
                                                color: Colors.white
                                            )
                                        ),
                                      ),
                                      Expanded(
                                        flex:1,
                                        child: GestureDetector(
                                          onTap:(){
                                            _launchURL(snapshot.data["articles"][index]["url"]);
                                          },
                                          child: Container(
                                            height: SizeConfig.blockSizeVertical*7,
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
                                                    fontSize: SizeConfig.blockSizeVertical*2
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          );
                        },
                      );
                    }
                );
              },
            )
        ),
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