import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:flutter_web/pages/matte/matte_controller.dart';

class Zoom_Slider extends StatefulWidget{
  final MatteController matteController = Get.find<MatteController>();
  Zoom_Slider({
    Key? key,
    this.current_value=1.0,
    required this.zoomFunction,
  }):super(key: key);
  double current_value;
  final Function(double) zoomFunction;
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<Zoom_Slider>{
  @override
  Widget build(BuildContext context){
    return SliderTheme(data: SliderTheme.of(context).copyWith(
      trackHeight:2, thumbShape: RoundSliderThumbShape(enabledThumbRadius:7),),
      child: Slider(value: widget.current_value,
        min:1.0, max:10.0,
        onChanged: (data){
          widget.zoomFunction(data);
          setState(() {
            widget.current_value = data;
          });
        }));
  }
}