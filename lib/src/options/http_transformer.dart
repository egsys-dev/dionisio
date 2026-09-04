typedef HttpTransformer<T> = T Function(Map<String, dynamic> data);

typedef HttpTransformerError<T> = T Function(
  Map<String, dynamic>? data,
  int? statusCode,
);
