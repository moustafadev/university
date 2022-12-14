import 'package:data_base/model/executors_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controller/user_controller.dart';

class ExecutorsShow extends StatelessWidget {
  const ExecutorsShow({Key? key}) : super(key: key);

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
                              print(query.runtimeType);
                              if (int.tryParse(query) != null) {
                                controller.searchExecutors(int.parse(query));
                              } else if(query=='') {
                                controller.getAllExecutors();
                              }else{
                                controller.clearExe();
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: '??????????',
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
                            '??????',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            '??????????????',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),DataColumn(
                          label: Text(
                            '?????????? ????????????????',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),DataColumn(
                          label: Text(
                            '????. ??????????',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),DataColumn(
                          label: Text(
                            '???????? ????????????',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            '??????????????',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                      rows: controller.executorsModel.map((e) {
                        return DataRow(
                          cells: [
                            DataCell(Center(
                                child: Text(
                                  '${e.idExecutors}',
                                  style: TextStyle(fontSize: 18),
                                ))),
                            DataCell(Center(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                inputFormatters: [],
                                onChanged: (val) {
                                  controller.updateExecutor(ExecutorsModel(
                                    firstName: val,
                                    lastName: e.lastName,
                                    phoneExecutors: e.phoneExecutors,
                                    email: e.email,
                                    workExperience: e.workExperience,
                                  ));
                                },
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                keyboardType: TextInputType.name,
                                onSaved: (val) {},
                                readOnly: false,
                                initialValue: e.firstName!,
                              ),
                            )),
                            DataCell(Center(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                inputFormatters: [],
                                onChanged: (val) {
                                  controller.updateExecutor(ExecutorsModel(
                                    firstName: e.firstName,
                                    lastName: val,
                                    phoneExecutors: e.phoneExecutors,
                                    email: e.email,
                                    workExperience: e.workExperience,
                                  ));
                                },
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                keyboardType: TextInputType.name,
                                onSaved: (val) {},
                                readOnly: false,
                                initialValue: e.lastName!,
                              ),
                            )),
                            DataCell(Center(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                inputFormatters: [],
                                onChanged: (val) {
                                  controller.updateExecutor(ExecutorsModel(
                                    firstName: e.firstName,
                                    lastName: e.lastName,
                                    phoneExecutors: val,
                                    email: e.email,
                                    workExperience: e.workExperience,
                                  ));
                                },
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                keyboardType: TextInputType.name,
                                onSaved: (val) {},
                                readOnly: false,
                                initialValue: e.phoneExecutors!,
                              ),
                            )),
                            DataCell(Center(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                inputFormatters: [],
                                onChanged: (val) {
                                  controller.updateExecutor(ExecutorsModel(
                                    firstName: e.firstName,
                                    lastName: e.lastName,
                                    phoneExecutors: e.phoneExecutors,
                                    email: val,
                                    workExperience: e.email,
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
                                initialValue: e.email!,
                              ),
                            )),
                            DataCell(Center(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                inputFormatters: [],
                                onChanged: (val) {
                                  controller.updateExecutor(ExecutorsModel(
                                    firstName: e.firstName,
                                    lastName: e.lastName,
                                    phoneExecutors: e.phoneExecutors,
                                    email: e.email,
                                    workExperience: val,
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
                                initialValue: e.workExperience!,
                              ),
                            )),
                            DataCell(
                              Center(
                                child: InkWell(
                                  onTap: () async {
                                    controller.deleteExe(e.idExecutors!);
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
                                          "??????????????",
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
                    '?????? ????????????',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  )),
            ],
          );
        });
  }
}
