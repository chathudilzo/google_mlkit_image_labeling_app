import 'dart:io';

import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_image_labeling_app/controllers/caption_controller.dart';
import 'package:image_picker/image_picker.dart';

class ImageLabelController extends GetxController{
  RxList<ImageLabel> labels=<ImageLabel>[].obs;
  Rx<File?> image=Rx<File?>(null);


  Future<void> pickImage()async{
    try{
      final imagePicker=ImagePicker();
    final pickedImage=await imagePicker.pickImage(source: ImageSource.gallery);

    if(pickedImage!=null){
      image.value=File(pickedImage.path);
      labels.clear();
    }
    }catch(error){
      print(error.toString());

    }
  }

  Future<void> labelImage()async{
    try{
      if(image.value!=null){

      final inputImage=InputImage.fromFile(image.value!);
      final imageLabeler=GoogleMlKit.vision.imageLabeler();

      final List<ImageLabel>detectedLabels=await imageLabeler.processImage(inputImage);
      print(detectedLabels);
      labels.value=detectedLabels;

      imageLabeler.close();

      if(labels.isNotEmpty){
        final List<String> caps=labels.map((label) =>label.label ).toList();
        if(caps.isNotEmpty){
          final CaptionController controller=Get.find();

          controller.getCaptions(caps);
        }
      }
    }
    }catch(error){
      print('ERROR:::'+error.toString());
    }
  }
}