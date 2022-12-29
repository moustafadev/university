import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('реклама'),
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
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  labelText: 'Эл. почта',
                                  hintText: 'Введите Эл. почту',
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
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  labelText: 'опыт работы ',
                                  hintText: 'Введите опыт работы ',
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //         const HomeScreen()));
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
                                        'Сохранить',
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
  }
}
