import 'package:get/route_manager.dart';
import 'package:flutter_web/pages/home/home_binding.dart';
import 'package:flutter_web/pages/home/home_page.dart';
import 'package:flutter_web/pages/matte/matte_binding.dart';
import 'package:flutter_web/pages/matte/matte_page.dart';
import 'package:flutter_web/pages/sd/sd_binding.dart';
import 'package:flutter_web/pages/sd/sd_page.dart';

abstract class AppPages{
  static final pages = [
  GetPage(name: Routes.HOME,
  page: () => HomePage(),
  binding:HomeBinding(),
  ),
  
  GetPage(name: Routes.MATTE, 
  page: () => MattePage(), 
  binding: MatteBinding()),

  GetPage(name: Routes.SD, 
  page: () => SDPage(), 
  binding: SDBinding()),
  ];
}

abstract class Routes{
  static const HOME = '/home';
  static const MATTE = '/matte';
  static const SD = '/sd';
}