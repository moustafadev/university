import 'package:data_base/model/executors_model.dart';
import 'package:data_base/model/service_model.dart';
import 'package:data_base/model/user_model.dart';

class AllOrdersModel {
  int? id;
  UserModel? user;
  ServiceModel? service;
  ExecutorsModel? executor;
  String? data;
  String? sum;
  String? quantity;
  bool? paid;

  AllOrdersModel({
    this.id,
    this.user,
    this.service,
    this.executor,
    this.data,
    this.sum,
    this.quantity,
    this.paid,
  });
}
