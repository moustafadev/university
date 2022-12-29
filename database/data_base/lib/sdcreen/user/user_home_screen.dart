import 'package:data_base/model/order_model.dart';
import 'package:data_base/model/service_model.dart';
import 'package:data_base/model/user_model.dart';
import 'package:data_base/sdcreen/user/user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../core/controller/user_controller.dart';
import '../../model/executors_model.dart';
import '../choose_user_screen.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return GetBuilder<UserController>(
        init: UserController(),
        builder: (controller) {
          //print('<><<><><>${controller.allOrder[0].user!.firstName}');
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: const Text('Заказы'),
              leading: InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ChooseUserScreen()));
                  },
                  child: Icon(Icons.arrow_back_ios)),
            ),
            body: controller.allOrder != []
                ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 37, 194, 0.08),
                          blurRadius: 3.0,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.search,
                              color: Color(0xffE5E6E6),
                              size: 25,
                            ),
                          ),
                          Expanded(
                            flex: 15,
                            child: TextField(
                              onChanged: (query) {
                                if (query != '') {
                                  controller.searchOrder(query);
                                } else {
                                  controller.getAllOrder();
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: 'Поиск',
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Color(0xffE5E6E6),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: DataTable(
                      border: TableBorder.all(
                          color: Colors.black12, width: 1.5),
                      columnSpacing: size.width * 0.02,
                      columns: const [
                        DataColumn(
                          label: Text(
                            'id',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Фамилия\nИмя',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        DataColumn(
                            label: Text(
                              'yслyг',
                              style: TextStyle(fontSize: 15),
                            )),
                        DataColumn(
                            label: Text(
                              'испoлнитeли',
                              style: TextStyle(fontSize: 15),
                            )),
                        DataColumn(
                            label: Text(
                              'дата\nзаказа',
                              style: TextStyle(fontSize: 15),
                            )),
                        DataColumn(
                            label: Text(
                              'опыт\nработы',
                              style: TextStyle(fontSize: 15),
                            )),
                        DataColumn(
                            label: Text(
                              'Эл.почта',
                              style: TextStyle(fontSize: 15),
                            )),
                        DataColumn(
                            label: Text(
                              'aдрeс',
                              style: TextStyle(fontSize: 15),
                            )),
                        DataColumn(
                            label: Text(
                              'Номер телефона',
                              style: TextStyle(fontSize: 15),
                            )),
                        DataColumn(
                            label: Text(
                              'сумма',
                              style: TextStyle(fontSize: 15),
                            )),
                        DataColumn(
                            label: Text(
                              'кoличeствo\nзaкaзoв',
                              style: TextStyle(fontSize: 15),
                            )),
                        DataColumn(
                            label: Text(
                              'оплачено',
                              style: TextStyle(fontSize: 18),
                            )),
                      ],
                      rows: controller.allOrder.map((e) {
                        print(controller.allOrder);
                        return DataRow(
                          cells: [
                            DataCell(Center(
                                child: Text(
                                  '${e.id}',
                                  style: TextStyle(fontSize: 18),
                                ))),
                            DataCell(Center(
                              child: TextFormField(
                                style:
                                const TextStyle(color: Colors.black),
                                inputFormatters: [],
                                onChanged: (val) {
                                  controller.updateUser(UserModel(
                                    idUser: e.user!.idUser,
                                    email: e.user!.email,
                                    phoneUser: e.user!.phoneUser,
                                    addressUser: e.user!.addressUser,
                                    firstName: val,
                                    lastName: e.user!.lastName,
                                  ));
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    hintText: e.user!.firstName!
                                ),
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (val) {},
                                readOnly: false,
                                //initialValue: e.user!.firstName!,
                              ),
                            )),
                            DataCell(Center(
                              child: DropdownButton(
                                iconSize: 30,
                                value: e.service!.nameService!,
                                items: controller.serviceModel
                                    .map((ServiceModel value) {
                                  return DropdownMenuItem(
                                    alignment: Alignment.center,
                                    value: value.nameService!,
                                    child: Text(
                                      value.nameService!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20),
                                    ),
                                    onTap: () {
                                      controller.updateOrder(OrderModel(
                                        idOrder: e.id!,
                                        userId: e.user!.idUser,
                                        serviceId: value.idService,
                                        executorsId:
                                        e.executor!.idExecutors,
                                        sum: e.sum,
                                        quantity: int.parse(e.quantity!),
                                        date: e.data,
                                        paid: e.paid! ? 1 : 0,
                                      ));
                                    },
                                  );
                                }).toList(),
                                onChanged: (String? val) {
                                  //controller.selectValueServiceOnDropDown(val!);
                                },
                              ),
                            )),
                            DataCell(Center(
                              child: DropdownButton(
                                iconSize: 30,
                                value: e.executor!.firstName!,
                                items: controller.executorsModel
                                    .map((ExecutorsModel value) {
                                  print(value.idExecutors);
                                  return DropdownMenuItem(
                                    alignment: Alignment.center,
                                    value: value.firstName!,
                                    child: Text(
                                      value.firstName!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20),
                                    ),
                                    onTap: () {
                                      controller.updateOrder(OrderModel(
                                        idOrder: e.id!,
                                        userId: e.user!.idUser,
                                        serviceId: e.service!.idService,
                                        executorsId: value.idExecutors,
                                        sum: e.sum,
                                        quantity: int.parse(e.quantity!),
                                        date: e.data,
                                        paid: e.paid! ? 1 : 0,
                                      ));
                                    },
                                  );
                                }).toList(),
                                onChanged: (String? val) {},
                              ),

                              //     Text(
                              //   e.executor!.firstName!,
                              //   style: TextStyle(fontSize: 18),
                              // ),
                            )),
                            DataCell(Center(
                                child: Text(
                                  e.data!,
                                  style: TextStyle(fontSize: 18),
                                ))),
                            DataCell(Center(
                                child: Text(
                                  e.executor!.workExperience!,
                                  style: TextStyle(fontSize: 18),
                                ))),
                            DataCell(Center(
                              child: TextFormField(
                                style:
                                const TextStyle(color: Colors.black),
                                inputFormatters: [],
                                onChanged: (val) {
                                  controller.updateUser(UserModel(
                                    idUser: e.user!.idUser,
                                    email: val,
                                    phoneUser: e.user!.phoneUser,
                                    addressUser: e.user!.addressUser,
                                    firstName: e.user!.firstName,
                                    lastName: e.user!.lastName,
                                  ));
                                },
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (val) {},
                                readOnly: false,
                                initialValue: e.user!.email!,
                              ),
                            )),
                            DataCell(Center(
                              child: TextFormField(
                                style:
                                const TextStyle(color: Colors.black),
                                inputFormatters: [],
                                onChanged: (val) {
                                  controller.updateUser(UserModel(
                                    idUser: e.user!.idUser,
                                    email: e.user!.email,
                                    phoneUser: e.user!.phoneUser,
                                    addressUser: val,
                                    firstName: e.user!.firstName,
                                    lastName: e.user!.lastName,
                                  ));
                                },
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (val) {},
                                readOnly: false,
                                initialValue: e.user!.addressUser!,
                              ),
                            )),
                            DataCell(Center(
                              child: TextFormField(
                                style:
                                const TextStyle(color: Colors.black),
                                inputFormatters: [],
                                onChanged: (val) {
                                  controller.updateUser(UserModel(
                                    idUser: e.user!.idUser,
                                    email: e.user!.email,
                                    phoneUser: val,
                                    addressUser: e.user!.addressUser,
                                    firstName: e.user!.firstName,
                                    lastName: e.user!.lastName,
                                  ));
                                },
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (val) {},
                                readOnly: false,
                                initialValue: '${e.user!.phoneUser!}',
                              ),
                            )),
                            DataCell(Center(
                                child: Text(
                                  '${e.service!.price}',
                                  style: TextStyle(fontSize: 18),
                                ))),
                            DataCell(Center(
                              child: TextFormField(
                                style:
                                const TextStyle(color: Colors.black),
                                inputFormatters: [],
                                onChanged: (val) {
                                  controller.updateOrder(OrderModel(
                                    idOrder: e.id!,
                                    userId: e.user!.idUser,
                                    serviceId: e.service!.idService,
                                    executorsId: e.executor!.idExecutors,
                                    sum: e.sum,
                                    quantity: val != ''
                                        ? int.parse(val).toInt()
                                        : 0,
                                    date: e.data,
                                    paid: e.paid! ? 1 : 0,
                                  ));
                                },
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (val) {},
                                readOnly: false,
                                initialValue: '${e.quantity!}',
                              ),
                            )),
                            DataCell(
                              Center(
                                child: Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(50),
                                      color: const Color(0xffACCD00)),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 6,
                                          bottom: 6),
                                      child: Text(
                                        '${e.paid!}',
                                        style: TextStyle(fontSize: 18),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList()),
                ),
              ],
            )
                : const Center(
                child: Text(
                  'Нет данных',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                )),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserScreen()));
              },
              tooltip: 'Дополнения',
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        });
  }
}
