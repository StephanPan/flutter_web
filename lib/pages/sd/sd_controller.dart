import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/network/ai_api.dart';
import 'package:flutter_web/network/dio_builder.dart';
import 'package:flutter_web/utils/image_handler.dart';
import 'package:flutter_web/utils/object_util.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
class SDController extends GetxController{
  double image_scale = 1.0;
  Uint8List? imageFile;
  Uint8List? maskImage;
  Uint8List? resultImage;
  AIApi aiApi = AIApi(dio!);
  late CustomImageCropController controller;

  @override
  void onInit(){
    
    print('sd init');
    controller = CustomImageCropController();
    if (Get.arguments != null){
      print('111');
      imageFile = Get.arguments["imageFile"];
      maskImage = Get.arguments["maskImage"];
      print(imageFile==null);
      update(['image_view']);
    }
    super.onInit();
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  void zoomImage(double zoom_scale){
    image_scale = zoom_scale;
  }
  void pickImage() async{
    Uint8List? pickimage = await ImagePickerWeb.getImageAsBytes();
    if (pickimage != null){
      imageFile = pickimage;
      update(['image_view']);
    }
  }

  void cropImage() async{
    final image = await controller.onCropImage();
    imageFile = image as Uint8List?;
    update(['image_view']);
    
    
  }

  void generateImage(String positive_prompt, String negtive_prompt) async{
    
    String? imageBase64String = ImageHandler.imageFileToBase64(imageFile!);
    aiApi.text2image(imageBase64String!, positive_prompt, negtive_prompt).then((value) {
      if(ObjectUtil.isEmptyString(value)){
        print('process failed');
        resultImage = imageFile;
        return;
      }
      resultImage = base64Decode(value!);
  
      update(['image_view']);
    });
    
  }
  
}