import 'dart:convert';

class ResponseModel {
  final String status;
  final dynamic params;
  final String? message;

  ResponseModel({
    required this.status,
    required this.params,
    this.message,
  });

  static const success = 'success';
  static const failure = 'failure';

  bool get isFailure => status == failure;
  bool get isSuccess => status == success;

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      status: map['status'],
      message: map['message'],
      params: map['params'],
    );
  }

  factory ResponseModel.fromJson(String source) =>
      ResponseModel.fromMap(json.decode(source));
}
