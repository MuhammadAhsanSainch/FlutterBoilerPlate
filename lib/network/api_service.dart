import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '/network/interceptor/logging_interceptor.dart';
import '/network/response/general_map_response.dart';
import 'app_url.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: AppUrl.baseUrl) // Enter Your API Base URL

abstract class ApiService {
  factory ApiService(Dio dio, baseUrl) {
    dio.options = BaseOptions(
        receiveTimeout: const Duration(seconds: 50000),
        connectTimeout: const Duration(seconds: 50000),
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        /* If needed headers */
        headers: {'Content-Type': 'application/json', 'Authorization': 'Basic RVhFSWRlYXMgSW50ZXJuYXRpb25hbCB3d3cuZXhlaWRlYXMubmV0'});

    dio.interceptors.add(Logging());
    return _ApiService(dio, baseUrl: AppUrl.baseUrl);
  }

  // APIs EndPoints Request Bodies without Token

  @POST('/signin')
  Future<GeneralMapResponse> signin(@Body() Map<String, dynamic> body);

  @POST('/signup')
  @MultiPart()
  Future<GeneralMapResponse> signup(@Body() FormData formData);

}
