import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/controller/user_controller.dart';
import 'admin/home_admin.dart';
import 'user/user_home_screen.dart';

class ChooseUserScreen extends StatelessWidget {
  const ChooseUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 25, top: 20, bottom: 40,right: 25),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0xff009FE3),
              child: InkWell(
                onTap: () async{
                 await Get.put(UserController()).getAllOrder();
                  Get.put(UserController()).getAllExecutors();
                 await Get.put(UserController()).getAllService(isSelect: false);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const UserHomeScreen()));
                },
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'пользователь',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 25, top: 20, bottom: 40,right: 25),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: const Color(0xff009FE3),
              child: InkWell(
                onTap: () {
                   Get.put(UserController()).getAllOrder();
                   Get.put(UserController()).getAllExecutors();
                   Get.put(UserController()).getAllService();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const HomeAdmin()));
                },
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'администратор',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
