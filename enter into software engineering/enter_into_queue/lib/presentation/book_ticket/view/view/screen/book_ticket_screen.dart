

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../auth/model/user.dart';
import '../../../../home/view/widget/drawer.dart';
import '../../../controller/book_ticket_controller.dart';

class BookTicketScreen extends StatefulWidget {
  BookTicketScreen({Key? key}) : super(key: key);

  @override
  State<BookTicketScreen> createState() => _BookTicketScreenState();
}

class _BookTicketScreenState extends State<BookTicketScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var current;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return GetBuilder<BookTicketController>(
        init: BookTicketController(),
        builder: (controller) {
          final result = User.fromJson(GetStorage().read('user'));
          print(result.toJson());
          return Scaffold(
            key: scaffoldKey,
            appBar: _appBar(context, scaffoldKey),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: height * 0.17,
                    width: width,
                    decoration: const BoxDecoration(
                      color: Color(0xfff7892b),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: (){
                          //GetStorage().write('queue', null);
                          controller.getTicket(context,result);
                          controller.update();
                        },
                        child: Container(
                          height: height * 0.09,
                          width: width / 2,
                          decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                              child: Text(
                            'Получить Талун',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 40, bottom: 20, right: 20, left: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: height * 0.15,
                            width: width,
                            decoration: BoxDecoration(
                                color: Colors.deepOrangeAccent,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: result.currentWindow!.isNotEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Текущий номер Талуна',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'AG${result.currentWindow}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Нет данный',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: height * 0.3,
                      width: width,
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: result.numberWindow!.isNotEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Ваш номер очереди',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'AG${result.numberWindow}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'У вас нет очередь',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            drawer: Drawer(
              backgroundColor: const Color(0xfff7892b),
              child: DrawerWidget(
                username: result.username!,
              ),
            ),
          );
        });
  }

  int minutesBetween(DateTime from) {
    from = DateTime(from.year, from.month, from.day);
    return (DateTime.now().difference(from).inMinutes / 24).round();
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
        onPressed: () => scafoldKey.currentState.openDrawer(),
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
