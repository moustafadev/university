import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/database.dart';
import '../../../core/snack_bar.dart';
import '../../home/view/screen/home_screen.dart';
import '../model/user.dart';
import '../view/screen/login_screen.dart';

class UserController extends GetxController {
  List<User> listUserModel = [];
  User? user;

  String? fuo;

  void saveFuo(String val) {
    fuo = val;
    update();
  }

  String? username;

  void saveUsername(String val) {
    username = val;
    update();
  }

  String? work;

  void saveWork(String val) {
    work = val;
    update();
  }

  String? password;

  void savePassword(String val) {
    password = val;
    update();
  }

  Future getAllUser() async {
    listUserModel = [];
    final db = await DBProvider.db.database;
    final listUser = await db?.query("User")??[];
    listUser.forEach((element) {
      print(element);
      listUserModel.add(User.fromJson(element));
    });

    update();
  }
  void insertUser(context)async{
   final result = await DBProvider.db.insertUser(User(
          fuo: fuo,
          work: work,
          username: username,
          password: password,
          numberWindow: "",
          currentWindow: ""
      ));
      user = result;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginPage()));
      CustomSnackBar.goodSnackBar(context);

  }

  void signup(context) async {
    await getAllUser();
    try {
      print(listUserModel.isNotEmpty);
      if(listUserModel.isNotEmpty){
        if(listUserModel.where((element) => username==element.username).isEmpty){
          insertUser(context);
        }else{
          CustomSnackBar.badSnackBar(context,"имя пользователя используется");
        }
      }else{
        insertUser(context);
      }
    } catch (e) {
      print(e);
      CustomSnackBar.badSnackBar(context,"что-то ошибка");
    }
  }

  bool isLoadingLogin = false;

  void checkLogin(context)async {
    try{
     await getAllUser();
      user = listUserModel
          .where((element) =>
      element.username == username && password == element.password)
          .first;
      if(user!=null){
        print("success Login");
        GetStorage().write('user', user!.toJson());
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomeScreen()));
      }
    }catch(e){
      CustomSnackBar.badSnackBar(context,"пароль или имя пользователя не верно $e");
    }

  }
}
