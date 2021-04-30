import 'package:dio/dio.dart';

abstract class HttpImageHelper {
  MultipartFile imageToMultiPartFile(
      {required String path, required String filename});

  MultipartFile fileToMultiPartFile(
      {required String path, required String filename});

  FormData mapToFormData(Map<String, dynamic> map);
}
