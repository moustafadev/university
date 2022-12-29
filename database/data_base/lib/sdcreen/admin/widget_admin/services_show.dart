import 'package:data_base/model/service_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../core/controller/user_controller.dart';
import '../../../core/local/database.dart';

class ServicesShow extends StatelessWidget {
  const ServicesShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<UserController>(
        init: UserController(),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              if (int.tryParse(query) != null) {
                                controller.searchService(int.parse(query));
                              } else if(query=='') {
                                controller.getAllService();
                              }else{
                                controller.clearSer();
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
                  ? Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Theme(
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
                            'нaимeнoвaниe\nyслyги',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'цeнa\nyслyги',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Удалить',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                      rows: controller.serviceModel.map((e) {
                        print(controller.allOrder);
                        return DataRow(
                          cells: [
                            DataCell(Center(
                                child: Text(
                                  '${e.idService}',
                                  style: TextStyle(fontSize: 18),
                                ))),
                            DataCell(Center(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                inputFormatters: [],
                                onChanged: (val) {
                                  controller.updateService(ServiceModel(
                                    idService: e.idService,
                                    nameService: val,
                                    price: e.price,
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
                                initialValue: e.nameService!,
                              ),
                            )),
                            DataCell(Center(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                inputFormatters: [],
                                onChanged: (val) {
                                  controller.updateService(ServiceModel(
                                    idService: e.idService,
                                    nameService: e.nameService,
                                    price: val != ""?double.tryParse(val):0,
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
                                initialValue: e.price!.toString(),
                              ),
                            )),
                            DataCell(
                              Center(
                                child: InkWell(
                                  onTap: () async {
                                    controller.deleteService(e.idService!);
                                  },
                                  child: Container(
                                    height: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.red),
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 5),
                                        child: Text(
                                          "Удалить",
                                          style: const TextStyle(fontSize: 18,color: Colors.white),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList()),
              ),
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
