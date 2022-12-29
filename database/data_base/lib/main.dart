import 'package:data_base/sdcreen/choose_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

import 'core/controller/user_controller.dart';
import 'core/local/database.dart';

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

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'реклама',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChooseUserScreen(),
    );
  }
}
