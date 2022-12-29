class UserModel{
  int? idUser;
  String? email;
  dynamic phoneUser;
  String? addressUser;
  String? firstName;
  String? lastName;

  UserModel(
      {this.idUser,
      this.email,
      this.phoneUser,
      this.addressUser,
      this.firstName,
      this.lastName});

  UserModel.fromJson(Map<String, dynamic>json){
    idUser = json['user_id'];
    email = json['email'];
    phoneUser = json['phone_user'];
    addressUser = json['address_user'];
    firstName = json['first_name'];
    lastName =  json['last_name'];
  }

  Map<String, dynamic>toMap(){
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['phone_user'] = phoneUser;
    map['address_user'] = addressUser;
    return map;
  }

}