import 'package:data_base/model/user_model.dart';
import 'package:data_base/sdcreen/user/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../core/controller/user_controller.dart';
import '../../core/local/database.dart';
import '../../core/snack_bar.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
        init: UserController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Клиeнт'),
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
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        bottom: 25,
                                        top: 30),
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'Имя',
                                          hintText: 'Введите имя'),
                                      keyboardType: TextInputType.text,
                                      onChanged: (val) {
                                        controller.saveFirstNameUser(val);
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Заполните поле';
                                        }
                                        return null;
                                      },
                                      readOnly: false,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, bottom: 25),
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      textInputAction: TextInputAction.next,
                                      onChanged: (val) {
                                        controller.saveLastNameUser(val);
                                      },
                                      decoration: const InputDecoration(
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.always,
                                          labelText: 'Фамилия',
                                          hintText: 'Введите фамилию'),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Заполните поле';
                                        }
                                        return null;
                                      },
                                      readOnly: false,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, bottom: 25),
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      inputFormatters: [],
                                      onChanged: (val) {
                                        controller.savePhoneUser(val);
                                      },
                                      textInputAction: TextInputAction.next,
                                      decoration: const InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'Номер телефона',
                                        hintText: '+7 (___) ___-__-__',
                                      ),
                                      keyboardType: TextInputType.number,
                                      onSaved: (val) {},
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Заполните поле';
                                        }
                                        return null;
                                      },
                                      readOnly: false,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, bottom: 25),
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      inputFormatters: [],
                                      textInputAction: TextInputAction.next,
                                      onChanged: (val) {
                                        controller.saveEmailUser(val);
                                      },
                                      decoration: const InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'Эл. почта',
                                        hintText: 'Введите Эл. почту',
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      onSaved: (val) {},
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Заполните поле';
                                        }
                                        return null;
                                      },
                                      readOnly: false,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, bottom: 25),
                                    child: TextFormField(
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      inputFormatters: [],
                                      textInputAction: TextInputAction.next,
                                      onChanged: (val){
                                        controller.saveAddressUser(val);
                                      },
                                      decoration: const InputDecoration(
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        labelText: 'aдрeс',
                                        hintText: 'Введите aдрeс',
                                      ),
                                      keyboardType: TextInputType.name,
                                      onSaved: (val) {},
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Заполните поле';
                                        }
                                        return null;
                                      },
                                      readOnly: false,
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
                                    onTap: () async{
                                     controller.nextToService(context);
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
