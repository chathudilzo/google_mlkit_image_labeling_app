import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_image_labeling_app/controllers/image_label_controller.dart';

void main() {
  Get.put(ImageLabelController());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Caption Generator'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() =>controller.image.value==null? Text('No Image Found')
            :Image.file(controller.image.value!)
            ),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){
              controller.pickImage();
            }, child: Text('Pick Image')
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              controller.labelImage();
            }, child: Text('Label Image')),
            SizedBox(height: 20,),
            Obx(() => controller.labels.isNotEmpty?Column(
              children: controller.labels.map((label) =>Text(label.label)).toList(),
            ):Container()
            )
          ],
        ),
      ),
    );
  }
}