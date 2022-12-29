class ExecutorsModel {
  int? idExecutors;
  String? workExperience;
  String? phoneExecutors;
  String? firstName;
  String? lastName;
  String? email;

  ExecutorsModel({
    this.idExecutors,
    this.workExperience,
    this.phoneExecutors,
    this.lastName,
    this.firstName,
    this.email,
  });


  ExecutorsModel.fromJson(Map<String, dynamic>json){
    idExecutors = json['executors_id'];
    workExperience = json['work_experience'];
    phoneExecutors = json['phone_executors'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

  Map<String, dynamic>toMap(){
    final map = <String, dynamic>{};
    map['work_experience'] = workExperience;
    map['phone_executors'] = phoneExecutors;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    return map;
  }


}
