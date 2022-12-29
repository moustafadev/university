import 'package:data_base/core/controller/admin_controller.dart';
import 'package:data_base/model/executors_model.dart';
import 'package:data_base/model/service_model.dart';
import 'package:data_base/sdcreen/admin/widget_admin/executor_admin_widget.dart';
import 'package:data_base/sdcreen/admin/widget_admin/service_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../core/local/database.dart';
import '../../core/snack_bar.dart';

class AddExecutorAndService extends StatelessWidget {
  const AddExecutorAndService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
        init: AdminController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.blue,
                        child: InkWell(
                          onTap: () {
                            controller.changeService("executor");
                          },
                          child: SizedBox(
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Center(
                                child: Text(
                                  'Испoлнитeли',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.blue,
                        child: InkWell(
                          onTap: () {controller.changeService("service");},
                          child: const SizedBox(
                            height: 80,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Center(
                                child: Text(
                                  'Услyги',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
               controller.select == "service"? ServiceAdmin(
                  onTap: () async {
                    final result =await DBProvider.db.insertService(ServiceModel(
                        nameService: controller.nameService,
                        price: controller.price));
                    if(result){
                      CustomSnackBar.goodSnackBar(context);
                    }else{
                      CustomSnackBar.badSnackBar(context);
                    }
                  },
                ) :
                ExecutorAdminWidget(onTap: () async{
                  if(int.tryParse(controller.expExecutor!)!=null){
                    final result =  await DBProvider.db.insertExecutors(ExecutorsModel(
                        firstName: controller.nameExecutor,
                        lastName: controller.lastNameExecutor,
                        phoneExecutors: controller.phoneExecutor,
                        email: controller.emailExecutor,
                        workExperience: controller.expExecutor
                    ));
                    if(result){
                      CustomSnackBar.goodSnackBar(context);
                    }else{
                      CustomSnackBar.badSnackBar(context);
                    }
                  }else{
                    CustomSnackBar.badSnackBar(context);
                  }
                },),
              ],
            ),
          );
        });
  }
}
