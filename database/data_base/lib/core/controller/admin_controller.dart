import 'package:data_base/core/controller/user_controller.dart';
import 'package:data_base/sdcreen/admin/home_admin_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../sdcreen/admin/add_executor_and_service.dart';
import '../../sdcreen/admin/widget_admin/executors_show.dart';
import '../../sdcreen/admin/widget_admin/services_show.dart';


class AdminController extends GetxController{

  int currentPage = 0;

  final pages = [
    HomeAdminWidget(),
    AddExecutorAndService(),
    ServicesShow(),
    ExecutorsShow()
  ];

  String appBarTitle(){
    switch(currentPage){
      case 0:
        return "Заказы";
      case 1:
        return "дополнения";
      case 2:
        return "Услyги";
      case 3:
        return "Испoлнитeли";
      default:
        return "";
    }
  }

  void changeCurrantPage(int index)async{
    if(index == 2) {
     await Get.put(UserController()).getAllService();
    } else if(index==3) {
      Get.put(UserController()).getAllExecutors();
    }

    currentPage = index;
    update();
  }

  String? nameService;

  void saveNameService(String val){
    nameService=val;
    update();
  }

  double? price;

  void savePrice(String val){
    price=double.tryParse(val);
    update();
  }

  String select = "executor";

  void changeService(String val){
    select = val;
    update();
  }


  String? nameExecutor;

  void saveNameExecutor(String val){
    nameExecutor=val;
    update();
  }

  String? lastNameExecutor;

  void saveLastNameExecutor(String val){
    lastNameExecutor=val;
    update();
  }

  String? phoneExecutor;

  void savePhoneExecutor(String val){
    phoneExecutor=val;
    update();
  }

  String? emailExecutor;

  void saveEmailExecutor(String val){
    emailExecutor=val;
    update();
  }

  String? expExecutor;

  void saveExpExecutor(String val){
    expExecutor=val;
    update();
  }


}