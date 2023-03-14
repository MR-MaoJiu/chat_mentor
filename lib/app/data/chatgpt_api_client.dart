library chatgpt_api_client;

import 'package:chat_mentor/app/data/chatgpt_api_response.dart';
import 'package:dio/dio.dart';

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
    await dio.get(
        'https://agent-openai.ccrui.dev/dashboard/billing/credit_grants',
        options: Options(headers: {
          'content-type': 'application/json',
          'authorization': 'Bearer $apiKey'
        }));
  }

  Future<ChatGptApiResponse> sendMessage(String message) async {
    const _url = 'https://agent-openai.ccrui.dev/v1/chat/completions';
    chatGptApiRequest.messages.first.content += '$message\n';
    print("============${chatGptApiRequest.toJson()}");

    var responseBody = await dio.post(_url,
        data: chatGptApiRequest.toJson(),
        options: Options(headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $apiKey'
        }));
    print("===========${responseBody.data}");
    ChatGptApiResponse chatGptApiResponse =
        ChatGptApiResponse.fromJson(responseBody.data);
    if ((chatGptApiResponse.choices ?? []).isNotEmpty) {
      chatGptApiRequest.messages.first.content +=
          "${chatGptApiResponse.choices!.first.message!.content.trim()}\n";
    }

    return chatGptApiResponse;
    // print("===========${}");
  }

  Future<Response> checkVersion() async {
    return await dio.get(
      'https://gitee.com/MaoJiuXianSen/chat_mentor/raw/master/version.json',
    );
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
