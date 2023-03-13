import 'dart:convert';

import 'chatgpt_api_request.dart';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ChatGptApiResponse {
  ChatGptApiResponse({
    this.id,
    this.object,
    this.created,
    this.model,
    this.usage,
    this.choices,
  });

  factory ChatGptApiResponse.fromJson(Map<String, dynamic> json) {
    final List<Choices>? choices = json['choices'] is List ? <Choices>[] : null;
    if (choices != null) {
      for (final dynamic item in json['choices']!) {
        if (item != null) {
          choices.add(Choices.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ChatGptApiResponse(
      id: asT<String?>(json['id']),
      object: asT<String?>(json['object']),
      created: asT<int?>(json['created']),
      model: asT<String?>(json['model']),
      usage: json['usage'] == null
          ? null
          : Usage.fromJson(asT<Map<String, dynamic>>(json['usage'])!),
      choices: choices,
    );
  }

  String? id;
  String? object;
  int? created;
  String? model;
  Usage? usage;
  List<Choices>? choices;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'object': object,
        'created': created,
        'model': model,
        'usage': usage,
        'choices': choices,
      };
}

class Usage {
  Usage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
        promptTokens: asT<int?>(json['prompt_tokens']),
        completionTokens: asT<int?>(json['completion_tokens']),
        totalTokens: asT<int?>(json['total_tokens']),
      );

  int? promptTokens;
  int? completionTokens;
  int? totalTokens;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'prompt_tokens': promptTokens,
        'completion_tokens': completionTokens,
        'total_tokens': totalTokens,
      };
}

class Choices {
  Choices({
    this.message,
    this.finishReason,
    this.index,
  });

  factory Choices.fromJson(Map<String, dynamic> json) => Choices(
        message: json['message'] == null
            ? null
            : Messages.fromJson(asT<Map<String, dynamic>>(json['message'])!),
        finishReason: asT<String?>(json['finish_reason']),
        index: asT<int?>(json['index']),
      );

  Messages? message;
  String? finishReason;
  int? index;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'message': message,
        'finish_reason': finishReason,
        'index': index,
      };
}
