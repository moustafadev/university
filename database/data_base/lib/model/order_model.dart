import 'package:data_base/model/executors_model.dart';
import 'package:data_base/model/service_model.dart';
import 'package:data_base/model/user_model.dart';

class OrderModel {
  int? idOrder;
  int? userId;
  int? serviceId;
  int? executorsId;
  String? date;
  int? paid;
  int? quantity;
  String? sum;

  OrderModel({
    this.userId,
    this.serviceId,
    this.executorsId,
    this.date,
    this.idOrder,
    this.paid,
    this.quantity,
    this.sum,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    idOrder = json['id_order'];
    userId = json['user_id'];
    serviceId = json['service_id'];
    serviceId = json['executors_id'];
    date = json['date'];
    paid = json['paid'];
    quantity = json['quantity'];
    sum = json['sum'];
  }


  Map<String, dynamic>toMap(){
    final map = <String, dynamic>{};
    map['date'] = date;
    map['paid'] = paid;
    map['quantity'] = quantity;
    map['sum'] = sum;
    map['user_id'] = userId;
    map['service_id'] = serviceId;
    map['executors_id'] = executorsId;
    return map;
  }




}
