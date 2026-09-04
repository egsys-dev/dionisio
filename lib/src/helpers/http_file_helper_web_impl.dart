import 'package:http_parser/http_parser.dart';
import 'package:dionisio/dionisio.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';

class DioHttpFileHelperWebImpl implements HttpFileHelper {
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
      bytes: bytes,
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
      bytes: bytes,
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
    Uint8List? bytes,
  }) {
    if (bytes == null) {
      throw Exception();
    }

    return MultipartFile.fromBytes(
      bytes.toList(),
      filename: filename,
      contentType: MediaType(mimeType, path.getExtensionType()),
    );
  }
}
