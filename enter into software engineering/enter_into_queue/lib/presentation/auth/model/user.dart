class User {
  int? id;
  String? fuo;
  String? username;
  String? work;
  String? password;
  String? numberWindow;
  String? currentWindow;

  User({
    this.id,
    this.fuo,
    this.username,
    this.work,
    this.password,
    this.numberWindow,
    this.currentWindow,

  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fuo = json['fuo'];
    username = json['username'];
    work = json['work'];
    password = json['password'];
    numberWindow = json['numberWindow'];
    currentWindow = json['currentWindow'];
  }

  // await db.execute('''
  //     create table User (
  //       id integer primary key autoincrement,
  //       fuo text not null,
  //       username text not null,
  //       work text not null,
  //       password text not null,
  //       numberWindow text
  //       )
  //    ''');

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['fuo'] = fuo;
    map['username'] = username;
    map['work'] = work;
    map['password'] = password;
    map['numberWindow'] = numberWindow;
    map['currentWindow'] = currentWindow;
    return map;
  }
}
