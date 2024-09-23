import '/network/api_service.dart';
import 'package:dio/dio.dart' as dio;

class AppUrl {
  static const String baseUrl = 'https://tookary.com/app/api';
  static const String mediaUrl = 'https://tookary.com/app/';
  static ApiService apiService = ApiService(dio.Dio(),AppUrl.baseUrl);
}
