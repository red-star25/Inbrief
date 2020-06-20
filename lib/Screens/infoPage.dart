import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inbreif/ScreenConfig.dart';
import 'package:url_launcher/url_launcher.dart';
class InfoPage extends StatelessWidget {
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
    return Scaffold(
      backgroundColor: Color(0xFF292D32),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Color(0xFF292D32),
              radius: SizeConfig.blockSizeVertical*10,
              backgroundImage: AssetImage('images/ic_launcher.png'),
            ),
            SizedBox(
              height: 50,
            ),
            Text('Dhruv Nakum',
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical*5,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'InBrief Developer',
              style: TextStyle(

                fontSize: SizeConfig.blockSizeVertical*3,
                color: Colors.white,
                letterSpacing: 2.5,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical*5,
              width: SizeConfig.blockSizeHorizontal*70,
              child: Divider(
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: ()=>_launchURL('https://play.google.com/store/apps/details?id=com.NakumsDtech.inbreif'),
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
                child: ListTile(
                  leading: Icon(
                    Icons.star,
                    color: Colors.teal.shade900,
                  ),
                  title: Text(
                    'Rate This App',
                    style: GoogleFonts.sourceSansPro(
                        letterSpacing: 2.0
                    ),
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.teal.shade900,
                ),
                title: Text(
                  'nakumdhruv123@gmail.com',
                  style: GoogleFonts.sourceSansPro(
                        fontSize: 14,
                      letterSpacing: 2.0
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Card(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: ListTile(
                leading: Icon(
                  Icons.details,
                  color: Colors.teal.shade900,
                ),
                title: Text(
                  'Nakums Dtech',
                  style: GoogleFonts.sourceSansPro(

                      letterSpacing: 2.0
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }
}
