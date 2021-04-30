import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../extensions/string_ext.dart';
import 'http_image_helper.dart';

class DioHttpImageHelperImplementation implements HttpImageHelper {
  @override
  MultipartFile imageToMultiPartFile(
      {required String path, required String filename}) {
    return _toMultiPartFile(mimeType: 'image', filename: filename, path: path);
  }

  @override
  MultipartFile fileToMultiPartFile(
      {required String path, required String filename}) {
    return _toMultiPartFile(
        mimeType: 'application', filename: filename, path: path);
  }

  @override
  FormData mapToFormData(Map<String, dynamic> map) {
    return FormData.fromMap(map);
  }

  MultipartFile _toMultiPartFile(
      {required String mimeType,
      required String filename,
      required String path}) {
    return MultipartFile.fromFileSync(
      path,
      filename: filename,
      contentType: MediaType(mimeType, path.getExtensionType()),
    );
  }
}
