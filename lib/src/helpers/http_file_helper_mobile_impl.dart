import 'package:http_parser/http_parser.dart';
import 'package:dionisio/dionisio.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';

class DioHttpFileHelperMobileImpl implements HttpFileHelper {
  @override
  MultipartFile imageToMultiPartFile({
    required String path,
    required String filename,
    Uint8List? bytes,
  }) {
    return _toMultiPartFile(
      mimeType: 'image',
      filename: filename,
      path: path,
    );
  }

  @override
  MultipartFile fileToMultiPartFile({
    required String path,
    required String filename,
    Uint8List? bytes,
  }) {
    return _toMultiPartFile(
      mimeType: 'application',
      filename: filename,
      path: path,
    );
  }

  @override
  FormData mapToFormData(Map<String, dynamic> map) {
    return FormData.fromMap(map);
  }

  MultipartFile _toMultiPartFile({
    required String mimeType,
    required String filename,
    required String path,
    // ignore: unused_element
    Uint8List? bytes,
  }) {
    return MultipartFile.fromFileSync(
      path,
      filename: filename,
      contentType: MediaType(mimeType, path.getExtensionType()),
    );
  }
}
