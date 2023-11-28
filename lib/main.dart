import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_image_labeling_app/controllers/caption_controller.dart';
import 'package:google_mlkit_image_labeling_app/controllers/image_label_controller.dart';

void main() {
  Get.put(ImageLabelController());
  Get.put(CaptionController());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImageLabelController controller=Get.find();
  final CaptionController capController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Caption Generator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(() =>controller.image.value==null? Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
                ),
                child: Center(child: Text('No Image Found',style: TextStyle(color: Colors.white),)))
              :Image.file(controller.image.value!)
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: (){
                controller.pickImage();
              }, child: Text('Pick Image')
              ),
              Text('->'),
              ElevatedButton(onPressed: (){
                controller.labelImage();
              }, child: Text('Label Image')),
             
                ],
              ),
              Obx(() => controller.labels.isNotEmpty?SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.labels.map((label) =>Text('# ${label.label} ',style: TextStyle(fontSize: 16,color: Colors.blueAccent,fontWeight: FontWeight.bold),)).toList(),
                ),
              ):Container()
              ),
              Obx((){
                if(capController.isLoading.value){
                  return CircularProgressIndicator();
                }else if(capController.botResponse==''){
                  return Container();
                }else{
                  return Column(
                    children: [Text(capController.botResponse.toString(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)],
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}