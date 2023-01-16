// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movies_app/app/data/api/error_response.dart';

class ProviderResponse<T> {
  final T content;
  final ErrorResponse? error;
  
  ProviderResponse({
    required this.content,
    this.error,
  });
}
