import 'package:data_base/model/executors_model.dart';
import 'package:data_base/model/order_model.dart';
import 'package:data_base/sdcreen/user/user_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../model/all_orders_model.dart';
import '../../model/service_model.dart';
import '../../model/user_model.dart';
import '../../sdcreen/user/executor_screen.dart';
import '../../sdcreen/user/service_screen.dart';
import '../local/database.dart';
import '../snack_bar.dart';

class UserController extends GetxController {
  String? firstNameUser;

  void saveFirstNameUser(String val) {
    firstNameUser = val;
    update();
  }

  String? lastNameUser;

  void saveLastNameUser(String val) {
    lastNameUser = val;
    update();
  }

  String? phoneUser;

  void savePhoneUser(String val) {
    phoneUser = val;
    update();
  }

  String? emailUser;

  void saveEmailUser(String val) {
    emailUser = val;
    update();
  }

  String? addressUser;

  void saveAddressUser(String val) {
    addressUser = val;
    update();
  }

  List<ServiceModel> serviceModel = [];
  List<ServiceModel> serviceSearch =[];
  void searchService(int val) {
    serviceSearch=[];
    serviceSearch = serviceModel;
    if (val == '') {
      getAllService();
    } else {
      print(val);
      serviceModel=[];
      serviceModel.addAll(serviceSearch
          .where((element) {
        return element.idService! == val;
      })
          .toList());
      update();
    }

  }
  bool loading = false;

  clearSer(){
    serviceModel=[];
    update();
  }
 Future getAllService({bool isSelect = false}) async {
    serviceModel = [];
    final db = await DBProvider.db.database;
    final listService = await db?.query("Service");
    listService!.forEach((element) {
      serviceModel.add(ServiceModel.fromJson(element));
    });
    if (isSelect) selectService = serviceModel[0];
    update();
  }

  List<ExecutorsModel> executorsModel = [];
  List<ExecutorsModel> executorsSearch =[];
  void searchExecutors(int val) {
    executorsSearch=[];
    executorsSearch = executorsModel;
    if (val == '') {
      getAllService();
    } else {
      print(val);
      executorsModel=[];
      executorsModel.addAll(executorsSearch
          .where((element) {
        return element.idExecutors! == val;
      })
          .toList());
      update();
    }

  }

  clearExe(){
    executorsModel = [];
    update();
  }
  void getAllExecutors() async {
    executor = '';
    selectExecutor = null;
    executorsModel = [];
    final db = await DBProvider.db.database;
    final listExecutors = await db?.query("Executors");
    listExecutors!.forEach((element) {
      print(element);
      executorsModel.add(ExecutorsModel.fromJson(element));
    });
    executor = executorsModel.first.firstName;
    selectExecutor = executorsModel.first;
    update();
  }

  String? service;

  void selectValueServiceOnDropDown(String serviceName) {
    service = serviceName;
    update();
  }

  ServiceModel? selectService;

  void changeSelectPrice(ServiceModel val) {
    selectService = val;
  }

  String? executor;

  void selectExecutorValueOnDropDown(String serviceName) {
    executor = serviceName;
    update();
  }

  ExecutorsModel? selectExecutor;

  void changeSelectExecutor(ExecutorsModel val) {
    selectExecutor = val;
  }

  UserModel? userModel;

  void nextToService(context) async {
    try {
      final result = await DBProvider.db.insertUser(UserModel(
          firstName: firstNameUser,
          lastName: lastNameUser,
          phoneUser: phoneUser,
          email: emailUser,
          addressUser: addressUser));
      userModel = result;
      await getAllService(isSelect: true).then((value) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ServiceScreen()));
      });

      CustomSnackBar.goodSnackBar(context);
    } catch (e) {
      CustomSnackBar.badSnackBar(context);
    }
    update();
  }

  void nextToHomeUser(context) async {
    final order = OrderModel(
      userId: userModel!.idUser,
      executorsId: selectExecutor!.idExecutors,
      serviceId: selectService!.idService,
      date:
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
      paid: 0,
      sum: '${selectService!.price}',
      quantity: 1,
    );

    print(order.toMap());
    final result = await DBProvider.db.insertOrder(order);
    if (result) {
      await Get.put(UserController()).getAllOrder();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const UserHomeScreen()));
      CustomSnackBar.goodSnackBar(context);
    } else {
      CustomSnackBar.badSnackBar(context);
    }
  }

  List<AllOrdersModel> allOrder = [];
  List<AllOrdersModel> or =[];
  void searchOrder(String val) {
    or=[];
    or = allOrder;
    if (val == '') {
      getAllOrder();
    } else {
      print(val);
      allOrder=[];
      allOrder.addAll(or
          .where((element) {
            print(element.user!.firstName!);
            return searchFound(element.user!.firstName!,val);
          })
          .toList());
      update();
    }

  }

  bool searchFound(String element, String query) {
    String help = '';
    for (int i = 0; i < element.length; i++) {
      help += element[i];
      if (help.toLowerCase() == query.toLowerCase()) {
        return true;
      }
    }

    return false;
  }



  getAllOrder() async {
    allOrder = [];
    final db = await DBProvider.db.database;
    final orders = await db?.query("Orders");
    final services = await db?.query("Service");
    final executors = await db?.query("Executors");
    final users = await db?.query("User");

    orders!.forEach((order) {
      allOrder.add(AllOrdersModel(
        id: int.parse(order['order_id'].toString()),
        user: UserModel.fromJson(users!
            .where((user) => user['user_id'] == order['user_id'])
            .toList()
            .first),
        service: ServiceModel.fromJson(services!
            .where((service) => service['service_id'] == order['service_id'])
            .toList()
            .first),
        executor: ExecutorsModel.fromJson(executors!
            .where(
                (executor) => executor['executors_id'] == order['executors_id'])
            .toList()
            .first),
        data: order['date'].toString(),
        paid: order['paid'] == 1,
        sum: order['sum'].toString(),
        quantity: order['quantity'].toString(),
      ));
    });
    update();
  }

  void deleteService(int id) async {
    final db = await DBProvider.db.database;
    final orders = await db?.query("Orders");
    print(orders);
    if (orders!.isEmpty) {
      await db?.rawDelete(
        'DELETE FROM Service WHERE service_id = ?',
        [id],
      );
    } else {
      final or = orders.where((element) => element['service_id'] == id);
      print(or);
      if (or.isEmpty) {
        print('true');
        await db?.rawDelete(
          'DELETE FROM Service WHERE service_id = ?',
          [id],
        );
      } else {
        print('false');
      }
    }
    getAllService();
  }

  void deleteExe(int id) async {
    final db = await DBProvider.db.database;
    final orders = await db?.query("Orders");
    print(orders);
    if (orders!.isEmpty) {
      await db?.rawDelete(
        'DELETE FROM Executors WHERE executors_id = ?',
        [id],
      );
    } else {
      final or = orders.where((element) => element['executors_id'] == id);
      print(or);
      if (or.isEmpty) {
        print('true');
        await db?.rawDelete(
          'DELETE FROM Executors WHERE executors_id = ?',
          [id],
        );
      } else {
        print('false');
      }
    }
    getAllService();
    update();
  }

  void updateUser(UserModel user) async {
    final db = await DBProvider.db.database;

    await db!.update(
      'User',
      user.toMap(),
      where: "user_id = ?",
      whereArgs: [user.idUser],
    );
    await getAllOrder();
  }

  void updateExecutor(ExecutorsModel executorUpdate) async {
    final db = await DBProvider.db.database;
    await db!.update(
      'Executors',
      executorUpdate.toMap(),
      where: "executors_id = ?",
      whereArgs: [executorUpdate.idExecutors],
    );
    await getAllOrder();
  }

  void updateService(ServiceModel serviceUpdate) async {
    final db = await DBProvider.db.database;
    await db!.update(
      'Service',
      serviceUpdate.toMap(),
      where: "service_id = ?",
      whereArgs: [serviceUpdate.idService],
    );
    await getAllOrder();
  }

  void updateOrder(OrderModel orderUpdate) async {
    final db = await DBProvider.db.database;
    await db!.update(
      'Orders',
      orderUpdate.toMap(),
      where: "order_id = ?",
      whereArgs: [orderUpdate.idOrder],
    );
    await getAllOrder();
  }
}
