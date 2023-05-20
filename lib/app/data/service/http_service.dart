import 'package:movies_app/app/data/models/extra_options_model.dart';

abstract class HttpService {
  Future<dynamic> get(
    String path, {
    ExtraOptionsModel? options,
  });
}
