import 'package:get/get.dart';
import 'package:flutter_web/pages/matte/matte_controller.dart';

class MatteBinding extends Bindings{
  @override
  void dependencies(){
    Get.put<MatteController>(MatteController());
  }
}
