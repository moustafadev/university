import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../core/controller/user_controller.dart';
import '../../model/executors_model.dart';
import '../../model/service_model.dart';
import 'user_home_screen.dart';

class ExecutorScreen extends StatelessWidget {
  const ExecutorScreen({Key? key}) : super(key: key);

  @override//Испoлнитeли
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: UserController(),
        builder: (controller) {
          print(controller.executorsModel);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Испoлнитeли'),
              automaticallyImplyLeading: true,
            ),
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      height: double.infinity,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 10,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:
                                    EdgeInsets.only(top: 20, bottom: 20),
                                    child: Text(
                                      'Наименование Испoлнитeли:',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width / 1.3,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton(
                                        iconSize: 30,
                                        value: controller.executor,
                                        items: controller.executorsModel
                                            .map((ExecutorsModel value){
                                          return DropdownMenuItem(
                                            alignment: Alignment.center,
                                            value: value.firstName!,
                                            child: Text(value.firstName!,style: TextStyle(color: Colors.black,fontSize: 20),),
                                            onTap: (){
                                              controller.changeSelectExecutor(value);
                                            },
                                          );
                                        }).toList(),
                                        onChanged: (String? val) {
                                          controller.selectValueServiceOnDropDown(val!);
                                        },
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                    EdgeInsets.only(top: 20, bottom: 10),
                                    child: Text(
                                      'опыт работы:',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 0, bottom: 20,left: 20),
                                    child: Text(
                                      '${controller.selectExecutor!.workExperience}',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, top: 20, bottom: 40),
                                child: Material(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      bottomLeft: Radius.circular(16.0),
                                    ),
                                  ),
                                  color: const Color(0xff009FE3),
                                  child: InkWell(
                                    onTap: () {
                                      controller.nextToHomeUser(context);
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
                                              'Далее',
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
