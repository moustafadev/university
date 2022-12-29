import 'package:data_base/core/controller/admin_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdminController>(
      init: AdminController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(controller.appBarTitle()),
          ),
          body: controller.pages[controller.currentPage],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(.60),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            currentIndex: controller.currentPage,
            onTap: (value) {
              controller.changeCurrantPage(value);
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Заказ',
                icon: Icon(Icons.house),
              ),
              BottomNavigationBarItem(
                label: 'дополнения',
                icon: Icon(Icons.add_circle),
              ),
              BottomNavigationBarItem(
                label: 'Услyги',
                icon: Icon(Icons.home_repair_service),
              ),
              BottomNavigationBarItem(
                label: 'Испoлнитeли',
                icon: Icon(Icons.person_pin_outlined),
              )
            ],
          ),
        );
      }
    );
  }
}
