library chatgpt_api_client;

import 'package:chat_mentor/app/data/chatgpt_api_response.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import 'chatgpt_api_request.dart';

class ChatGptApiClient {
  final String apiKey;
  final ChatGptApiRequest chatGptApiRequest;
  Dio dio = Dio()..options.connectTimeout = const Duration(seconds: 30);

  ChatGptApiClient(this.apiKey, this.chatGptApiRequest) {
    authorization();
  }

  cleanMessages() {
    chatGptApiRequest.messages.clear();
  }

  authorization() async {
    try {
      await dio.get(
          'https://agent-openai.ccrui.dev/dashboard/billing/credit_grants',
          options: Options(headers: {
            'content-type': 'application/json',
            'authorization': 'Bearer $apiKey',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST,GET,DELETE,PUT,OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type'
          }));
    } catch (e) {
      getx.Get.snackbar(
        '系统提示',
        "当前Key注册失效请更新Key",
      );
    }
  }

  Future<ChatGptApiResponse> sendMessage(String message) async {
    ChatGptApiResponse chatGptApiResponse;
    try {
      const _url = 'https://agent-openai.ccrui.dev/v1/chat/completions';
      chatGptApiRequest.messages.first.content += '$message\n';
      print("============${chatGptApiRequest.toJson()}");

      var responseBody = await dio.post(_url,
          data: chatGptApiRequest.toJson(),
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer $apiKey',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'POST,GET,DELETE,PUT,OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type'
          }));
      print("===========${responseBody.data}");
      chatGptApiResponse = ChatGptApiResponse.fromJson(responseBody.data);
      if ((chatGptApiResponse.choices ?? []).isNotEmpty) {
        chatGptApiRequest.messages.first.content +=
            "${chatGptApiResponse.choices!.first.message!.content.trim()}\n";
      }
    } catch (e) {
      getx.Get.snackbar(
        '系统提示',
        "当前Key注册失效请更新Key",
      );
      chatGptApiResponse = ChatGptApiResponse();
    }

    return chatGptApiResponse;
    // print("===========${}");
  }

  Future<Response> checkVersion() async {
    return await dio.get(
        'https://gitee.com/MaoJiuXianSen/chat_mentor/raw/master/version.json',
        options: Options(headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'POST,GET,DELETE,PUT,OPTIONS',
          'Access-Control-Allow-Headers': 'Content-Type'
        }));
  }
}
// String decodeUniconByString(String event) {
//   var re = RegExp(
//     r'(%(?<asciiValue>[0-9A-Fa-f]{2}))'
//     r'|(\\u(?<codePoint>[0-9A-Fa-f]{4}))'
//     r'|.',
//   );
//   var matches = re.allMatches(event);
//   var codePoints = <int>[];
//   for (var match in matches) {
//     var codePoint =
//         match.namedGroup('asciiValue') ?? match.namedGroup('codePoint');
//     if (codePoint != null) {
//       codePoints.add(int.parse(codePoint, radix: 16));
//     } else {
//       codePoints += match.group(0)!.runes.toList();
//     }
//   }
//   return String.fromCharCodes(codePoints);
// }
