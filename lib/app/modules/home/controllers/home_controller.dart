import 'package:chat_mentor/app/data/chatgpt_api_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/chatgpt_api_client.dart';
import '../../../data/chatgpt_api_response.dart';

class HomeController extends GetxController {
  var sendBtnDisabled = false.obs;
  var chatGptApiResponse = ChatGptApiResponse().obs;
  var messages = <String>[].obs;

  /// init client
  ChatGptApiClient client = ChatGptApiClient(
      "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",
      ChatGptApiRequest(
          messages: [Messages(content: '扮演英语老师禁止说与英语无关的事情：', role: 'user')],
          stop: ["我：", "老师："]));
  TextEditingController textController = TextEditingController();

  sendMessage() async {
    sendBtnDisabled.value = true;
    messages.value.add('我：${textController.text}');
    chatGptApiResponse.value = await client.sendMessage(textController.text);
    if ((chatGptApiResponse.value.choices ?? []).isNotEmpty) {
      messages.value.add(
          "老师：${chatGptApiResponse.value.choices?.first.message?.content}");
    }

    sendBtnDisabled.value = false;
    textController.clear();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
