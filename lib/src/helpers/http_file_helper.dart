import 'dart:typed_data';

import 'package:dio/dio.dart';

abstract class HttpFileHelper {
  MultipartFile imageToMultiPartFile(
      {Uint8List? bytes, required String path, required String filename});

  MultipartFile fileToMultiPartFile(
      {Uint8List? bytes, required String path, required String filename});

  FormData mapToFormData(Map<String, dynamic> map);
}
