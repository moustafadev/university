import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../widget/bezierContainer.dart';
import '../widget/logo_widget.dart';
import 'login_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    const LogoWidget(),
                    const SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'ФИО',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                onChanged: (val) {
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
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
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true))
                            ],
                          ),
                        ),
                        Container(
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Вид работы',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                  onChanged: (val) {
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Color(0xfff3f3f4),
                                      filled: true))
                            ],
                          ),
                        ),
                        Container(
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
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
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(5)),
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
                          'Register Now',
                          style: TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .14),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'Already have an account ?',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Login',
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
  }
}
