import 'package:inbreif/CategoryViewPage/CategoryViewpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inbreif/ScreenConfig.dart';
import 'package:inbreif/Screens/Dashboard.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  BoxDecoration decoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.1),
          offset: Offset(-10.0, -10.0),
          blurRadius: 16.0,
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          offset: Offset(10.0, 10.0),
          blurRadius: 16.0,
        ),
      ],
      color: Color(0xFF292D32),
      borderRadius: BorderRadius.circular(12.0),
    );
  }



  List<String> assetImages = [
    'images/general.jpg',
    'images/enter.jpg',
    'images/science.jpg',
    'images/business.jpg',
    'images/technology.jpg',
    'images/health.jpg',
    'images/sports.jpg',
  ];

  List<String> categoryName = [
    'General',
    'Entertainment',
    'Science',
    'Business',
    'Technology',
    'Health',
    'Sports'
  ];

  List<String> categoryApi=[
    "https://newsapi.org/v2/top-headlines?country=in&category=General&pageSize=100&apiKey=API_KEY",
    "https://newsapi.org/v2/top-headlines?country=in&category=entertainment&pageSize=100&apiKey=API_KEY",
    "https://newsapi.org/v2/top-headlines?country=in&category=Science&pageSize=100&apiKey=API_KEY",
    "https://newsapi.org/v2/top-headlines?country=in&category=Business&pageSize=100&apiKey=API_KEY",
    "https://newsapi.org/v2/top-headlines?country=in&category=Technology&pageSize=100&apiKey=API_KEY",
    "https://newsapi.org/v2/top-headlines?country=in&category=Health&pageSize=100&apiKey=API_KEY",
    "https://newsapi.org/v2/top-headlines?country=in&category=Sports&pageSize=100&apiKey=API_KEY",
  ];

  Future<bool> _onBackPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Brief_Dashboard()));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          backgroundColor: Color(0xFF292D32),
          body: Container(
            width: SizeConfig.blockSizeHorizontal * 100,
            height: SizeConfig.blockSizeVertical * 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 50,
                  height: SizeConfig.blockSizeVertical * 10,
                  decoration: decoration(),
                  child: Center(
                      child: Text(
                    "Category",
                    style: GoogleFonts.pacifico(
                        fontSize: SizeConfig.blockSizeVertical * 5,
                        color: Colors.white),
                  )),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 5,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 80,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Center(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryViewPage(api: categoryApi[index],Catname: categoryName[index],)));
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                    child: Center(
                                      child: Container(
                                        height: SizeConfig.blockSizeVertical * 8,
                                        width: SizeConfig.blockSizeHorizontal * 45,
                                        decoration: decoration().copyWith(
                                          color: Colors.black54
                                        ),
                                        child: Center(
                                          child: Text(
                                            categoryName[index],
                                            style: GoogleFonts.galindo(
                                                fontSize: 18, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    width: SizeConfig.blockSizeHorizontal * 80,
                                    height: SizeConfig.blockSizeVertical * 30,
                                    decoration: decoration().copyWith(
                                        image: DecorationImage(
                                            image: AssetImage(assetImages[index]),
                                            fit: BoxFit.cover),
                                    ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        );
                      },
                      itemCount: 6),
                )
              ],
            ),
          )),
    );
  }
}
