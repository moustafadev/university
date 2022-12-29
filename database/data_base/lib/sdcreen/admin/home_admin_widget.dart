import 'package:data_base/core/controller/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../model/executors_model.dart';
import '../../model/order_model.dart';
import '../../model/service_model.dart';
import '../../model/user_model.dart';


class HomeAdminWidget extends StatelessWidget {
  const HomeAdminWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<UserController>(
        init: UserController(),
    builder: (controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
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
        controller.allOrder != []
            ? Theme(
          data: Theme.of(context)
              .copyWith(dividerColor: Colors.transparent),
          child: DataTable(
              border:
              TableBorder.all(color: Colors.black12, width: 1.5),
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
                      child: Text(
                        e.user!.firstName!,
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
                    DataCell(Center(
                      child: Text(
                      e.service!.nameService!,
                        style: TextStyle(fontSize: 15),
                      ),

                    )),
                    DataCell(Center(
                      child:Text(
                        '${e.executor!.firstName!}\n${e.executor!.lastName!}',
                        style: TextStyle(fontSize: 15),
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
                      child: Text(
                        e.user!.email!,
                        style: TextStyle(fontSize: 15),
                      ),)),
                    DataCell(Center(
                      child: Text(
                        e.user!.addressUser!,
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
                    DataCell(Center(
                      child: Text(
                        e.user!.phoneUser!.toString(),
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
                    DataCell(Center(
                        child: Text(
                          '${e.service!.price}',
                          style: const TextStyle(fontSize: 18),
                        ))),
                    DataCell(Center(
                      child: Text(
                        e.quantity!.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    )),
                    DataCell(
                      Center(
                        child: InkWell(
                          onTap: () {
                            controller.updateOrder(OrderModel(
                              idOrder: e.id!,
                              userId: e.user!.idUser,
                              serviceId: e.service!.idService,
                              executorsId: e.executor!.idExecutors,
                              sum: e.sum,
                              quantity: int.parse(e.quantity!),
                              date: e.data,
                              paid: e.paid! ? 0 : 1,
                            ));
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xffACCD00)),
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 5,
                                    bottom: 5),
                                child: Text(
                                  e.paid!?"Да":"Нет",
                                  style: const TextStyle(fontSize: 18),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList()),
        )
            : const Center(
            child: Text(
              'Нет данных',
              style: TextStyle(fontSize: 20, color: Colors.black),
            )),
      ],
    );
  });
  }
}
