enum Method {
  POST('POST'),
  GET('GET'),
  PUT('PUT'),
  DELETE('DELETE'),
  PATCH('PATCH'),
  HEAD('HEAD');

  final String value;

  const Method(this.value);
}
