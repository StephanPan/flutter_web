import 'package:flutter/material.dart';
import 'package:flutter_web/pages/sd/sd_controller.dart';
import 'package:flutter_web/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math';
import './result_page.dart';
// class SDPage extends StatefulWidget{

//   SDPage({Key? key}):super(key: key);
//   @override
//   _SDState createState()=> _SDState();
// }

class SDPage extends StatelessWidget{
  final SDController sdcontroller = Get.find<SDController>();
  final TextEditingController _positivecontroller = TextEditingController();
  final TextEditingController _negtivecontroller = TextEditingController();
  // late CustomImageCropController controller;

  // @override
  // void initState(){
  //   super.initState();
  //   // controller = CustomImageCropController();
  // }
  // @override
  // void dispose(){
  //   controller.dispose();
  //   super.dispose();
  // }
  // PhotoViewController photoviewcontroller = PhotoViewController()
  //     ..outputStateStream.listen(listener);
  // double scaleCopy;
  // void listener(PhotoViewControllerValue value){
  //   setState((){
  //     scaleCopy = value.scale;
  //   })
  // }
  Widget build(BuildContext context){
    MediaQueryData media = MediaQuery.of(context);
    
    return 
      Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(onPressed: ()=>{Get.offAllNamed(Routes.HOME)}, child: Text('Home',style: TextStyle(color: Colors.black),)),
          TextButton(onPressed: ()=>{}, child: Text('Pricing',style: TextStyle(color: Colors.black),)),
          TextButton(onPressed: ()=>{}, child: Text('Help',style: TextStyle(color: Colors.black),)),
          TextButton(onPressed: ()=>{}, child: Text('Log in',style: TextStyle(color: Colors.black),)),
        ],
      ),
      body: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(child: 
        Column(children: [
        Container(
          height: 650,
     
          child: Row(children: [
            Container(
              alignment: Alignment.topLeft,
              width: media.size.width/5,
             
              color: Colors.white,
              child:
              Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      color: Colors.yellow,
                      width: 120,
                      child: Text("Customize",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text('Describe your product', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text('Your product is ...', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  ),
                  TextField(
                    controller: _positivecontroller,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'in the middle of a desert next to cacti',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                       
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                       
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text('List what you don\'t want', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                  ),
                  
                  TextField(
                    controller: _negtivecontroller,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Add things or attributes you don\'t want',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                       
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                       
                      ),
                    ),
                  ),
                  
                ],),
              )
              ),
            Container(
              width: media.size.width*0.8,
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Container(
                  
                  height: 65,
                  width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Create Instagram-worthy snapshots for any products with the click of a button",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    ),
                    Text("Move your product around the canvas, select a theme, then click Generate.",
                    style: TextStyle(fontSize: 15),
                    maxLines: 1,)
                  ]),
                ),
                UnconstrainedBox(
                    child: Container(
                      color: Colors.grey,
                    height: 512,
                    width: 512,
                    child: GetBuilder<SDController>(
                      id:'image_view',
                      builder: (sdcontroller){
                        // return sdcontroller.imageFile!=null
                        // ? 
                        return Container(
                          child: CustomImageCrop(
                            cropController: sdcontroller.controller,
                            image: MemoryImage(sdcontroller.imageFile!),
                            shape: CustomCropShape.Square,
                            cropPercentage: 1.0,
                            canRotate: true,
                            canMove: true,
                            canScale: true,
                            customProgressIndicator: const CupertinoActivityIndicator(),
                            ),);
                        // : Container();
                      }),
                    
                ),
                  ),
                
                Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.refresh), onPressed: sdcontroller.controller.reset),
              IconButton(
                  icon: const Icon(Icons.zoom_in),
                  onPressed: () =>
                      sdcontroller.controller.addTransition(CropImageData(scale: 1.1))),
              IconButton(
                  icon: const Icon(Icons.zoom_out),
                  onPressed: () =>
                      sdcontroller.controller.addTransition(CropImageData(scale: 0.9))),
              IconButton(
                  icon: const Icon(Icons.rotate_left),
                  onPressed: () =>
                      sdcontroller.controller.addTransition(CropImageData(angle: -pi / 90))),
              IconButton(
                  icon: const Icon(Icons.rotate_right),
                  onPressed: () =>
                      sdcontroller.controller.addTransition(CropImageData(angle: pi / 90))),
              IconButton(
                icon: const Icon(Icons.crop),
                onPressed: () async {
                  final image = await sdcontroller.controller.onCropImage();
                  // sdcontroller.cropImage();
                  Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ResultScreen(image: image!)));
                  
                },
              ),
            ],
          ),
                  
              ]),
            )
          ]),
        ),
        Container(
          height: 512,
          decoration: BoxDecoration(    
            border: Border(top: BorderSide(color:Colors.grey, width: 0.5))
          ),
          child: Row(children: [
            Expanded(child: Container(
              child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(3),
              height: 500,
            
              child: Image(image: AssetImage('images/test.jpg')),
            ),
            Container(
              padding: EdgeInsets.all(3),
              height: 500,
           
              child: Image(image: AssetImage('images/test.jpg')),
            ),
            Container(
              padding: EdgeInsets.all(3),
              height: 500,
           
              child: Image(image: AssetImage('images/test.jpg')),
            ),
         
          ],
        ),
            )),
         
            Container(
              width: media.size.width*0.1,
              alignment: Alignment.topCenter,
              child: Expanded(child: ElevatedButton(
                child: Text('Generate'),
                onPressed: () => {sdcontroller.generateImage(_positivecontroller.text, _negtivecontroller.text)}),)),
            
          ]),
        )
      ],),),) 
        
      
    );
    
  }
}

// import 'dart:math';

// import 'package:custom_image_crop/custom_image_crop.dart';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';


// class SDPage extends StatelessWidget {
//   const SDPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const MyHomePage(title: 'Custom crop example'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   final String title;

//   const MyHomePage({
//     required this.title,
//     Key? key,
//   }) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   late CustomImageCropController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = CustomImageCropController();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         systemOverlayStyle: SystemUiOverlayStyle.dark,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: CustomImageCrop(
//               cropController: controller,
//               // image: const AssetImage('assets/test.png'), // Any Imageprovider will work, try with a NetworkImage for example...
//               image: const NetworkImage(
//                   'https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png'),
//               shape: CustomCropShape.Square,
//               canRotate: true,
//               canMove: true,
//               canScale: true,
//               customProgressIndicator: const CupertinoActivityIndicator(),
//             ),
//           ),
//           Row(
//             children: [
//               IconButton(
//                   icon: const Icon(Icons.refresh), onPressed: controller.reset),
//               IconButton(
//                   icon: const Icon(Icons.zoom_in),
//                   onPressed: () =>
//                       controller.addTransition(CropImageData(scale: 1.33))),
//               IconButton(
//                   icon: const Icon(Icons.zoom_out),
//                   onPressed: () =>
//                       controller.addTransition(CropImageData(scale: 0.75))),
//               IconButton(
//                   icon: const Icon(Icons.rotate_left),
//                   onPressed: () =>
//                       controller.addTransition(CropImageData(angle: -pi / 4))),
//               IconButton(
//                   icon: const Icon(Icons.rotate_right),
//                   onPressed: () =>
//                       controller.addTransition(CropImageData(angle: pi / 4))),
//               IconButton(
//                 icon: const Icon(Icons.crop),
//                 onPressed: () async {
//                   final image = await controller.onCropImage();
                  
//                 },
//               ),
//             ],
//           ),
//           SizedBox(height: MediaQuery.of(context).padding.bottom),
//         ],
//       ),
//     );
//   }
// }