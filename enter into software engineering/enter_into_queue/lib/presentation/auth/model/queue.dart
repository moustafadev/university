class Queue {
  int? id;
  String? number;
  String? nextQueue;
  String? perQueue;
  String? status;
  String? work;
  String? data;

  Queue({
    this.id,
    this.number,
    this.nextQueue,
    this.perQueue,
    this.status,
    this.work,
    this.data,
  });

  Queue.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    nextQueue = json['nextQueue'];
    work = json['work'];
    perQueue = json['perQueue'];
    status = json['status'];
    data = json['data'];
  }

  Map<String,dynamic> toJson(){
    final map = <String, dynamic>{};
    map['id'] = id;
    map['number'] = number;
    map['nextQueue'] = nextQueue;
    map['work'] = work;
    map['perQueue'] = perQueue;
    map['status'] = status;
    map['data'] = data;
    return map;
  }

}
