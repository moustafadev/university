import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/database.dart';
import '../../../core/snack_bar.dart';
import '../../auth/model/user.dart';

class BookTicketController extends GetxController {
  var current;

  User? user;

  void getTicket(context, User result) {
    print(GetStorage().read('queue'));
    if (GetStorage().read('queue') == null) {

      GetStorage().write('queue',[1]);
      GetStorage().write('currentWindow', 1);
      current = GetStorage().read('currentWindow');
      updateQueue(
          User(
              id: result.id,
              fuo: result.fuo,
              username: result.username,
              work: result.work,
              password: result.password,
              currentWindow: 1.toString(),
              numberWindow: 1.toString()),
          context);
    } else {
      final queue = GetStorage().read('queue') as List;
      print(queue);
      queue.add(int.parse(queue.last.toString()) + 1);
      current = GetStorage().read('currentWindow');
      GetStorage().write('queue', queue);
      updateQueue(
          User(
            id: result.id,
            fuo: result.fuo,
            username: result.username,
            work: result.work,
            password: result.password,
            currentWindow: GetStorage().read('currentWindow').toString(),
            numberWindow: queue.last.toString(),
          ),
          context);
    }
    update();
  }

  void updateQueue(User user, context) async {
    print('object${user.toJson()}');
    try {
      final db = await DBProvider.db.database;
      await db!.update(
        'User',
        user.toJson(),
        where: "id = ?",
        whereArgs: [user.id],
      );
      print(await db.query("User"));
      GetStorage().write('user', user.toJson());
      print(GetStorage().read('user'));
    } catch (e) {
      CustomSnackBar.badSnackBar(context, "что-то ошибка");
    }
    update();
  }
}
