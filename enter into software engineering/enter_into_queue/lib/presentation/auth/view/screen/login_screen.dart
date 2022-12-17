import 'package:enter_into_queue/presentation/auth/view/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/user_controller.dart';
import '../widget/bezierContainer.dart';
import '../widget/logo_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (controller) {
        return Scaffold(
          body: SizedBox(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: -height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: const BezierContainer()),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        const LogoWidget(),
                        const SizedBox(height: 50),
                        Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Имя пользователя',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                      onChanged: (val) {
                                        controller.saveUsername(val);
                                      },
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true))
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Пароль',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                      onChanged: (val) {
                                        controller.savePassword(val);
                                      },
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: Color(0xfff3f3f4),
                                          filled: true))
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {

                            controller.checkLogin(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: const Offset(2, 4),
                                      blurRadius: 5,
                                      spreadRadius: 2)
                                ],
                                gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xfffbb448),
                                      Color(0xfff7892b)
                                    ])),
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: height * .27),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            padding: const EdgeInsets.all(15),
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  'У вас нет учетной записи ?',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'регистр',
                                  style: TextStyle(
                                      color: Color(0xfff79c4f),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(
                                left: 0, top: 10, bottom: 10),
                            child: const Icon(Icons.keyboard_arrow_left,
                                color: Colors.black),
                          ),
                          const Text('Back',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
