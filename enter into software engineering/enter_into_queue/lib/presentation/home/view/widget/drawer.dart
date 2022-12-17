import 'package:enter_into_queue/presentation/auth/view/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../auth/view/screen/welcome_screen.dart';
import '../../../book_ticket/view/view/screen/book_ticket_screen.dart';
import '../screen/home_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    GetStorage getStorage = GetStorage('myData');
    return ListView(
      children: [
        Container(
          color: const Color(0xfff7892b),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Staying healthy!",
                      style: GoogleFonts.quicksand(
                          fontSize: 25, fontWeight: FontWeight.w600))),
              Container(
                color: const Color(0xfff7892b),
                padding: const EdgeInsets.only(top: 10, bottom: 15, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //       return EditProfile();
                        //     }));
                      },
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(
                                'assets/images/ellipse-141-bg-gQ1.png'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SizedBox(
                                  width: 200,
                                  child: Text(username,
                                      style: GoogleFonts.merriweather(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Container(
            height: MediaQuery.of(context).size.height * .59,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Icon(
                                Icons.home,
                                size: 28,
                                color: Colors.blueGrey.shade600,
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Text('Главная',
                                style: GoogleFonts.ubuntu(fontSize: 20)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BookTicketScreen()));
                        },
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Icon(
                                Icons.add_circle,
                                size: 28,
                                color: Colors.blueGrey.shade600,
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Text('Талон',
                                style: GoogleFonts.ubuntu(fontSize: 20)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          getStorage.write('user',null);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const WelcomePage()));
                        },
                        child: Row(
                          children: [
                            const SizedBox(width: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Icon(
                                Icons.logout,
                                size: 28,
                                color: Colors.blueGrey.shade600,
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Text('Выход',
                                style: GoogleFonts.ubuntu(fontSize: 20)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.only(top: 210.0, left: 50, right: 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20),
                          IconButton(
                              icon: const Icon(
                                FontAwesome.globe,
                                color: Colors.blue,
                              ),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(
                                FontAwesome.instagram,
                                color: Colors.pink,
                              ),
                              onPressed: () {}),
                          IconButton(
                              icon: Icon(
                                Icons.email_outlined,
                                color: Colors.blueGrey,
                              ),
                              onPressed: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
