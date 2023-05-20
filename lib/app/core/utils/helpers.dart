import 'package:movies_app/app/core/values/constants.dart';

class AppHelpers {
  static String getImageUrl(String path) 
    => path.contains("www") ? path.substring(1) : Constants.imageBaseUrl + path;
}