import 'dart:math';

import 'package:enter_into_queue/core/theme/extention.dart';
import 'package:enter_into_queue/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/database.dart';
import '../../../../core/theme/light_color.dart';
import '../../../../core/theme/theme.dart';
import '../../../auth/model/user.dart';
import '../../model/dactor_model.dart';
import '../widget/drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print(GetStorage().read('user'));
    final result = User.fromJson(GetStorage().read('user'));
    print(result.username);
    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(context, scaffoldKey),
      // AppBar(
      //   backgroundColor: const Color(0xfff7892b),
      // ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _header(result.username),
            _searchField(context),
            _category(context),
            _doctorsList(context),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xfff7892b),
        child: Drawer(
          backgroundColor: Color(0xfff7892b),
          child: DrawerWidget(username: result.username!,),
        ),
      ),
    );
  }

  Widget getdoctorWidgetList(context) {
    return Column(
        children: doctorDataList.map((x) {
      return _doctorTile(x, context);
    }).toList());
  }

  List<DoctorModel> doctorDataList = [
    DoctorModel(
        rating: null,
        image: 'assets/images/ellipse-141-bg-gQ1.png',
        isfavourite: null,
        satisfaction: null,
        type: 'good',
        goodReviews: null,
        name: 'mostafa',
        description: 'mostafa is good doctor',
        totalScore: null),
    DoctorModel(
        rating: null,
        image: 'assets/images/ellipse-141-bg-gQ1.png',
        isfavourite: null,
        satisfaction: null,
        type: 'good',
        goodReviews: null,
        name: 'mostafa',
        description: 'mostafa is good doctor',
        totalScore: null),
    DoctorModel(
        rating: null,
        image: 'assets/images/ellipse-141-bg-gQ1.png',
        isfavourite: null,
        satisfaction: null,
        type: 'good',
        goodReviews: null,
        name: 'mostafa',
        description: 'mostafa is good doctor',
        totalScore: null),
    DoctorModel(
        rating: null,
        image: 'assets/images/ellipse-141-bg-gQ1.png',
        isfavourite: null,
        satisfaction: null,
        type: 'good',
        goodReviews: null,
        name: 'mostafa',
        description: 'mostafa is good doctor',
        totalScore: null),
    DoctorModel(
        rating: null,
        image: 'assets/images/ellipse-141-bg-gQ1.png',
        isfavourite: null,
        satisfaction: null,
        type: 'good',
        goodReviews: null,
        name: 'mostafa',
        description: 'mostafa is good doctor',
        totalScore: null),
    DoctorModel(
        rating: null,
        image: 'assets/images/ellipse-141-bg-gQ1.png',
        isfavourite: null,
        satisfaction: null,
        type: 'good',
        goodReviews: null,
        name: 'mostafa',
        description: 'mostafa is good doctor',
        totalScore: null),
  ];

  Widget _doctorTile(DoctorModel model, context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 10,
            color: LightColor.grey.withOpacity(.2),
          ),
          BoxShadow(
            offset: Offset(-3, 0),
            blurRadius: 15,
            color: LightColor.grey.withOpacity(.1),
          )
        ],
      ),
      child: Container(
        width: AppTheme.fullWidth(context),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: randomColor(context),
              ),
              child: Image.asset(
                model.image!,
                height: 50,
                width: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(model.name!,
              style: GoogleFonts.marmelad(
                  fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Text(
            model.type!,
            style: TextStyles.bodySm.subTitleColor.bold,
          ),
          trailing: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ).ripple(() {
        Navigator.pushNamed(context, "/DetailPage", arguments: model);
      }, borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }

  Color randomColor(context) {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  Widget _doctorsList(context) {
    return Container(
      width: AppTheme.fullWidth(context),
      height: AppTheme.fullHeight(context) / 3,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Text("Consult a Doctor",
                    style: GoogleFonts.merriweather(fontSize: 20)),
                SizedBox(
                  width: AppTheme.fullWidth(context) / 2.5,
                ),
                IconButton(
                    icon: Icon(
                      Icons.sort,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {})
                // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
              ],
            ).hP16,
            getdoctorWidgetList(context)
          ],
        ),
      ),
    );
  }

  Widget _category(context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 10, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("AI Prediction",
                  style: GoogleFonts.merriweather(fontSize: 20)),
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.fullHeight(context) * .28,
          width: AppTheme.fullWidth(context),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                child: _categoryCard(
                    "TB Prediction",
                    "",
                    color: LightColor.green,
                    lightColor: LightColor.lightGreen,
                    context),
              ).ripple(() {
                Navigator.pushNamed(
                  context,
                  "/TBPage",
                );
              }),
              Container(
                child: _categoryCard(
                    "Skin Cancer Prediction",
                    "",
                    color: LightColor.skyBlue,
                    lightColor: LightColor.lightBlue,
                    context),
              ).ripple(() {
                Navigator.pushNamed(context, "/SkinPage");
              }),
              Container(
                child: _categoryCard(
                    "Covid - 19 Prediction",
                    "",
                    color: LightColor.orange,
                    lightColor: LightColor.lightOrange,
                    context),
              ).ripple(() {
                Navigator.pushNamed(
                  context,
                  "/CovidPage",
                );
              }),
              Container(
                child: _categoryCard(
                    "Nearby Hospitals",
                    "",
                    color: Colors.yellow,
                    lightColor: Colors.yellowAccent,
                    context),
              ).ripple(() async {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryCard(String title, String subtitle, context,
      {required Color color, required Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.white;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.white;
      subtitleStyle = TextStyles.bodySm.bold.white;
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Text(title,
                              style: GoogleFonts.nunito(
                                  fontSize: 15, fontWeight: FontWeight.bold))
                          .hP8,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  Widget _searchField(context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightColor.grey.withOpacity(.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
              width: 50,
              child: Icon(Icons.search, color: LightColor.purple)
                  .alignCenter
                  .ripple(() {}, borderRadius: BorderRadius.circular(13))),
        ),
      ),
    );
  }

  Widget _header(String? username) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Hello,", style: GoogleFonts.ubuntu(color: Colors.grey)),
          Text(username!, style: GoogleFonts.merriweather(fontSize: 30)),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context, scafoldKey) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0xfff7892b),
      leading: IconButton(
        icon: const Icon(
          Icons.short_text,
          color: Colors.black,
        ),
        onPressed: () async{
          scafoldKey.currentState.openDrawer();
          final dbs = await DBProvider.db.database;
          // DBProvider.db.deleteDatabase(path);
          print(await dbs!.query("User"));
        },
      ),
      actions: const <Widget>[
        Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/ellipse-141-bg-gQ1.png'),
          ),
        ),
      ],
    );
  }
}
