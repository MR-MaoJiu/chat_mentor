import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class ChatGptApiRequest {
  ChatGptApiRequest({
    this.model,
    this.maxTokens,
    this.temperature,
    this.topP,
    required this.messages,
    this.stream,
    this.presencePenalty,
    this.stop,
  });

  factory ChatGptApiRequest.fromJson(Map<String, dynamic> json) {
    final List<Messages>? messages =
        json['messages'] is List ? <Messages>[] : null;
    if (messages != null) {
      for (final dynamic item in json['messages']!) {
        if (item != null) {
          messages.add(Messages.fromJson(asT<Map<String, dynamic>>(item)!));
        }
      }
    }
    return ChatGptApiRequest(
      model: asT<String>(json['model'])!,
      maxTokens: asT<int?>(json['max_tokens']),
      temperature: asT<double?>(json['temperature']),
      topP: asT<double?>(json['top_p']),
      messages: messages!,
      stream: asT<bool?>(json['stream']),
      presencePenalty: asT<int?>(json['presence_penalty']),
      stop: asT<List<String>?>(json['stop']),
    );
  }

  /// ID of the model to use. You can use the List models API to see all of your available models
  /// or see our Model overview for descriptions of them.
  String? model;

  /// The maximum number of tokens to generate in the completion.
  /// The token count of your prompt plus max_tokens cannot exceed the model's context length.
  /// Most models have a context length of 2048 tokens (except for the newest models, which support 4096).
  int? maxTokens;

  /// What sampling temperature to use, between 0 and 2.
  /// Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic.
  /// We generally recommend altering this or top_p but not both.
  double? temperature;

  /// An alternative to sampling with temperature, called nucleus sampling,
  /// where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
  /// We generally recommend altering this or temperature but not both.
  double? topP;

  ///chat with GPT's messages
  List<Messages> messages;

  /// Whether to stream back partial progress.
  /// If set, tokens will be sent as data-only server-sent events as they become available, with the stream terminated by a data: [DONE] message.
  bool? stream;

  /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
  /// [See more information about frequency and presence penalties.](https://platform.openai.com/docs/api-reference/parameter-details )
  int? presencePenalty;

  /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
  final List<String>? stop;
  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'model': model ?? "gpt-3.5-turbo",
        'max_tokens': maxTokens ?? 1024,
        'temperature': temperature ?? 0.2,
        'top_p': topP ?? 1,
        'messages': messages,
        'stream': stream ?? false,
        'presence_penalty': presencePenalty ?? 0,
        'stop': stop,
      };
}

class Messages {
  Messages({
    required this.role,
    required this.content,
  });

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        role: asT<String>(json['role'])!,
        content: asT<String>(json['content'])!,
      );

  /// GPT's role
  String? role;

  /// GPT's messages content
  String content;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'role': role,
        'content': content,
      };
}
