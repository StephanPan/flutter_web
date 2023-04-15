import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter_web/pages/matte/signaturepainter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_web/routes/app_pages.dart';
import 'package:flutter_web/network/ai_api.dart';
import 'package:flutter_web/network/dio_builder.dart';
import 'package:flutter_web/utils/image_handler.dart';
import 'package:flutter_web/utils/object_util.dart';
import 'package:file_saver/file_saver.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
class MatteController extends GetxController{
  double image_scale = 1.0;
  Uint8List? imageFile;
  bool? refineMaskFinished = false;
  Uint8List? seg_result;
  Uint8List? maskImage;
  bool? seg_success = false;
  bool? refine_mask = false;
  int step = 0;
  List<Offset> points = <Offset>[];

  AIApi aiApi = AIApi(dio!);
  void zoomImage(double zoom_scale){
    image_scale = zoom_scale;
  }
  void pickImage() async{
    Uint8List? pickimage = await ImagePickerWeb.getImageAsBytes();
    // imageFile = pickimage;
    // update(['image_view']);
    if (pickimage == null || pickimage.isEmpty){
      print('pick image failed');
    }
    else{
      imageFile = pickimage;
      String? imageBase64String = ImageHandler.imageFileToBase64(imageFile!);
      
      aiApi.salient_seg(imageBase64String!).then((value) {
        if(ObjectUtil.isEmptyString(value)){
          print('process failed');
          seg_result = imageFile;
          seg_success = false;
          update(['image_view']);
          return;
        }
        seg_result = base64Decode(value!);
        seg_success = true;
        update(['image_view']);
      }).catchError((error) {
        print('connected failed');
        print(error);
        seg_result = imageFile;
        seg_success = false;
        update(['image_view']);
      });
      
    }
  } 

  void update_painter(Offset localPosition){
    points = new List.from(points)..add(localPosition);
    update(['painter']);
  }

  void update_mask (){
    refine_mask = refine_mask == false ? true : false;
    update(['image_view']);
    print(refine_mask);
  }
  Future<ui.Image> get_rendered(BuildContext context){
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);

    Rect rect = Offset.zero & Size(512,512);
    canvas.clipRect(rect);
    print('points: ${points.length}');
    // SigaturePainter painter = SigaturePainter(points);
    Paint paint = new Paint()
      ..color = Color.fromRGBO(100,188,252,0.25)
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = 16.0
      ..strokeJoin = StrokeJoin.round;
    for (int i = 0; i < points.length-1;i++){
      if (points[i].dx>=0 && points[i].dy>=0 && points[i+1].dx >= 0 && points[i+1].dy >=0){
        canvas.drawLine(points[i], points[i+1], paint);
      }
    };
    ui.Picture picture = recorder.endRecording();
   
    // var size = Size(context.size!.width,context.size!.height);
    // painter.paint(canvas, size);
    return picture.toImage(512, 512);
  }

  void paint_over(BuildContext context){
    save_mask(context);
    step = 1;
    update(['gesture_detect']);
    Get.toNamed(Routes.SD, arguments: {"imageFile": imageFile});
  }

  void save_mask(BuildContext context) async{
    ui.Image renderedImage = await get_rendered(context);
    var pngbytes = await renderedImage.toByteData(format: ui.ImageByteFormat.png);
   
    maskImage = pngbytes!.buffer.asUint8List();
    print('maskimage');
    print(maskImage==null);
    
    // final directory = await getTemporaryDirectory();
    // final file = File('${directory}/image.png');
    // print(directory);
    // await file.writeAsBytes(maskImage!);
  }


  void saveProduct() {
    
    if(imageFile != null){
      print('saveproduct');
      print(maskImage==null);
      Get.toNamed(Routes.SD, arguments: {"imageFile": imageFile, "maskImage": maskImage});
    }
  }
}