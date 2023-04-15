import 'package:flutter/material.dart';
import 'package:flutter_web/pages/matte/signaturepainter.dart';
import 'package:flutter_web/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter_web/pages/matte/matte_controller.dart';
import 'package:flutter_web/common/widget/zoom_slider.dart';
import 'package:flutter/src/widgets/basic.dart';

class MattePage extends StatelessWidget{
  final MatteController matteController = Get.find<MatteController>();
  
  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    var appbar = AppBar(
        backgroundColor: Colors.white,
        leadingWidth: media.size.width/3,
        leading: Container(alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 2),
          child: Text('Add your products',
                  style: TextStyle(color:Colors.black, fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'JosefinSans'),),
          ),
        actions: [IconButton(onPressed: ()=>{Get.offAllNamed(Routes.HOME)}, icon: Icon(Icons.close), color: Colors.black,)],
        
      );
    return Scaffold(
      appBar: appbar,
      body: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          child: Container(
       
        child: Row(
         
          children: [
          Container(
            constraints: BoxConstraints(maxWidth: media.size.width*0.8),
            width: media.size.width*0.8,
            child: GetBuilder<MatteController>(
              id: "image_view",
              builder: (matteController) {
                return matteController.refine_mask == false
                ? matteController.imageFile != null
                  ? UnconstrainedBox(
                    child: Container(
                      width: 512,
                      height: 512,
                      // alignment: Alignment.topCenter,
                      child: Image.memory(matteController.imageFile!, fit: BoxFit.contain,),
                    ),
                  )
                  : GestureDetector(
                    onTap: () => {matteController.pickImage()},
                    child: UnconstrainedBox(
                    child: Container(
                      width: 300,
                      height: 300,
                      alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(style:BorderStyle.solid, color: Colors.grey)),
                    child: Text('upload a photo of your product'),)
                    
                  ),)
                : Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    UnconstrainedBox(

                    child: Container(
                      // alignment: Alignment.topCenter,
                      color: Colors.red,
                      width: 512,
                      height: 512,
                      child: Image.memory(matteController.imageFile!, fit: BoxFit.contain,),
                    ),
                  ),
                  UnconstrainedBox(
                    child: Container(
                      width: 512,
                      height: 512,
                      
                      child: Stack(
                        children: [
                          GetBuilder<MatteController>(
                            id: "gesture_detect",
                            builder: (matteController) {
                              return matteController.step==0
                              ? GestureDetector(
                                onPanUpdate: (DragUpdateDetails details) {
                                  RenderBox referenceBox = context.findRenderObject() as RenderBox;
                                  Offset localPosition = referenceBox.globalToLocal(details.globalPosition);
                                  matteController.update_painter(Offset(localPosition.dx-(media.size.width*0.8-512)/2, localPosition.dy-appbar.preferredSize.height-(media.size.height-appbar.preferredSize.height-512)/2));
                                },
                                onPanEnd: (DragEndDetails details) {
                                  matteController.update_painter(Offset(-1,-1));
                                },
                              )
                              : Container();
                            }),
                          GetBuilder<MatteController>(
                            id: "painter",
                            builder: (matteController) {
                              return Container(
                             
                                child: 
                                CustomPaint(
                          
                                  painter: SigaturePainter(matteController.points)),
                              );
                            })
                        ],
                      )
                    ),
                  )
                  ],
                );
              },),),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(left: BorderSide(color: Colors.grey))
            ),
            alignment: Alignment.centerRight,
            width: media.size.width/5,
            height: media.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                child: Text('zoom', style: TextStyle(fontSize: 20),),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                height: 50,
                child: Zoom_Slider(zoomFunction: matteController.zoomImage)
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),),
                  child: Text('Refine background', style: TextStyle(fontSize: 20, color: Colors.black, backgroundColor: Colors.white),), 
                  onPressed: ()=>{matteController.update_mask()},
                  ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: 
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.white),),
                  child: Text('Save product', style: TextStyle(fontSize: 20, color: Colors.black, backgroundColor: Colors.white),), 
                  onPressed: ()=>{
                    matteController.paint_over(context)},),
              )

            ]),
          )
        ]),
      ),
        ),
      ),
    );
  }
}