import 'package:data_base/core/controller/admin_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';


class ExecutorAdminWidget extends StatelessWidget {
  const ExecutorAdminWidget({Key? key, required this.onTap}) : super(key: key);

  final Function()onTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
        init: AdminController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                ),
                child: Column(
                  children: [
                    Column(
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
                            onChanged: (val){
                              controller.saveNameExecutor(val);
                            },
                            decoration: const InputDecoration(
                                floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                                labelText: 'Имя',
                                hintText: 'Введите имя'),
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
                            textInputAction: TextInputAction.next,
                            onChanged: (val){
                              controller.saveLastNameExecutor(val);
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
                            onChanged: (val){
                              controller.savePhoneExecutor(val);
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
                            onChanged: (val){
                              controller.saveEmailExecutor(val);
                            },
                            textInputAction: TextInputAction.next,
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
                            onChanged: (val){
                              controller.saveExpExecutor(val);
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              floatingLabelBehavior:
                              FloatingLabelBehavior.always,
                              labelText: 'опыт работы',
                              hintText: 'Введите опыт работы ',
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
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, top: 20, bottom: 10, right: 25),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: const Color(0xff009FE3),
                        child: InkWell(
                          onTap: onTap,
                          child: SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Сохранить',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
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
              ),
            ),
          );
        });
  }
}
