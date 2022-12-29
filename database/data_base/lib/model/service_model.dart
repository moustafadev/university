class ServiceModel{
  int? idService;
  String? nameService;
  double? price;

  ServiceModel({this.idService, this.nameService, this.price});

  ServiceModel.fromJson(Map<String, dynamic>json){

    idService =  json['service_id'];
    nameService =  json['name_service'];
    price =  json['price'];
  }


  Map<String, dynamic>toMap(){
    final map = <String, dynamic>{};

    map['price'] = price;
    map['name_service'] = nameService;
    return map;
  }
}