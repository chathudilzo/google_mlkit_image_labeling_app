import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CaptionController extends GetxController{
  
  RxString botResponse=''.obs;
  RxBool isLoading=false.obs;


  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await dotenv.load(fileName:'.env');

  }

  Future<void> getCaptions(List<String>data)async{
    try{
      isLoading.value=true;
      botResponse.value='';
      final apiKey=dotenv.env['GPT_API_KEY'];
      final openAi=OpenAI.instance.build(token: apiKey,baseOption:HttpSetup(receiveTimeout: const Duration(seconds: 5)),enableLog: true);

      String req='Generate few creative captions for a image which has list of image labels as folows${data.join('+')} no need to use label names in the caption';

      final request=CompleteText(prompt: req,model: TextDavinci3Model(), maxTokens: 200);

      final response = await openAi.onCompletion(request:request);
      //print(response!.choices[0].toJson().values);
      //print(response!.choices[0].toJson().values.first);

      botResponse.value=response!.choices[0].toJson().values.first;
      print('BotRESPONSE IS');
      print(botResponse);
      isLoading.value=false;
    }catch(error){
      print(error.toString());
    }
  }
  
}