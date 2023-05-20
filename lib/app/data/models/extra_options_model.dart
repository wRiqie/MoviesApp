class ExtraOptionsModel {
  final String? baseUrl;
  final String? contentType;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? queryParameters;
  final int? receiveTimeout;
  final int? connectTimeout;
  final dynamic responseType;
  final dynamic data;

  ExtraOptionsModel({
    this.baseUrl,
    this.contentType,
    this.headers,
    this.queryParameters,
    this.receiveTimeout,
    this.connectTimeout,
    this.responseType,
    this.data,
  });
}
