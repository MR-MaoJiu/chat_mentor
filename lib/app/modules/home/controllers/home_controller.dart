import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_mentor/app/data/chatgpt_api_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/chatgpt_api_client.dart';
import '../../../data/chatgpt_api_response.dart';

class HomeController extends GetxController {
  var sendBtnDisabled = true.obs;
  var chatGptApiResponse = ChatGptApiResponse().obs;
  var messages = <Widget>[].obs;
  String command = "你是英语外教，请确定学生英语等级后回使用相应的等级使用英语回答学生问题并纠正学生语法错误：";
  // "你是英语老师禁止说与英语无关的事情,确定学生等级后开始给学生出一天选择题，学生答对后继续下一题，否则跟学生讲解一下继续出下一题：";
  // "你是英语老师禁止说与英语无关的事情，先询问英语等级调整相关教学方案，初学者可以先中文教学，禁止说多余的话：";

  /// init client
  late ChatGptApiClient client;
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  var title = "私教老师".obs;
  var isFirstOpen = true.obs;
  var key = "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".obs;
  final box = GetStorage();
  sendMessage() async {
    if (textController.text.trim().isNotEmpty) {
      sendBtnDisabled.value = true;
      messages.value.add(BubbleSpecialThree(
        text: textController.text,
        color: Colors.blue,
        isSender: true,
      ));
      String _msg = textController.text;
      textController.clear();

      Future.delayed(const Duration(milliseconds: 500), () {
        scrollController.jumpTo(
          scrollController.position.maxScrollExtent,
        );
      });
      title.value = "对方正在输入中...";
      chatGptApiResponse.value = await client.sendMessage(_msg);
      sendBtnDisabled.value = false;
      if ((chatGptApiResponse.value.choices ?? []).isNotEmpty) {
        messages.value.add(BubbleSpecialThree(
          text:
              "${chatGptApiResponse.value.choices?.first.message?.content.trim()}",
          color: const Color(0xFFE8E8EE),
          isSender: false,
        ));
        title.value = "私教老师";
        Future.delayed(const Duration(milliseconds: 20), () {
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent,
          );
        });
      }
    }
  }

  getkey() async {
    ClipboardData? text = await Clipboard.getData(Clipboard.kTextPlain);
    if (text != null && (text.text ?? "").contains("sk-")) {
      key.value = text.text ?? "";
      // print("================${key.value}");
      box.write('keys', key.value);
      Get.snackbar(
        'Key已更改',
        "已改为：${key.value}",
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    key.value = box.read('keys') ??
        "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";
    client = ChatGptApiClient(
        key.value,
        ChatGptApiRequest(
            messages: [Messages(content: command, role: 'user')],
            stop: ["我：", "老师："]));
    client.checkVersion().then((value) {
      String version = value.data['version'];
      String update = value.data['update'];
      String url = value.data['url'];
      String _key = value.data['key'];
      if (_key != key.value) {
        key.value = _key;
        box.write('keys', _key);
      }

      PackageInfo.fromPlatform().then((value) {
        // print("=================$version==${value.version}");
        if (version != value.version) {
          Get.snackbar('有新版本啦', "本次更新内容为：\n$update", onTap: (s) {
            launchUrl(Uri.parse(url));
          });
        }
      });
    });
    getkey();
  }
}
