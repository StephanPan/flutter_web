import 'package:flutter_web/pages/sd/sd_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_web/pages/sd/sd_controller.dart';

class SDBinding extends Bindings{
  @override
  void dependencies(){
    Get.put<SDController>(SDController());
  }
}
