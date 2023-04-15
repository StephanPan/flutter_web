
import 'package:get/get.dart';
import 'package:flutter_web/pages/home/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies(){
    Get.put<HomeController>(HomeController());
  }
}