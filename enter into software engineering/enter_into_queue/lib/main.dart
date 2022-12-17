import 'package:enter_into_queue/presentation/auth/view/screen/welcome_screen.dart';
import 'package:enter_into_queue/presentation/home/view/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/database.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await  DBProvider.db.database;
  print('object');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         primarySwatch: Colors.blue,
         textTheme:GoogleFonts.latoTextTheme(textTheme).copyWith(
           bodyText1: GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
         ),
      ),
      debugShowCheckedModeBanner: false,
      home: GetStorage().read('user') == null? const WelcomePage():HomeScreen(),
    );
  }
}
