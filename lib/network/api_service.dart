import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '/network/interceptor/logging_interceptor.dart';
import '/network/response/general_list_response.dart';
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

  @POST('/googlecontinue')
  @MultiPart()
  Future<GeneralMapResponse> googlecontinue(@Body() FormData formData);

  @POST('/forgetpassword')
  Future<GeneralMapResponse> forgetpassword(@Body() Map<String, dynamic> body);

  @POST('/products')
  Future<GeneralListResponse> products(@Body() Map<String, dynamic> body);

  @POST('/relatedproducts')
  Future<GeneralListResponse> relatedproducts(@Body() Map<String, dynamic> body);

  @POST('/freight')
  Future<GeneralListResponse> freight(@Body() Map<String, dynamic> body);

  @POST('/freightdiscounted')
  Future<GeneralListResponse> freightdiscounted(@Body() Map<String, dynamic> body);

  @POST('/slider')
  Future<GeneralListResponse> slider(@Body() Map<String, dynamic> body);

  @POST('/categories')
  Future<GeneralListResponse> categories(@Body() Map<String, dynamic> body);

  @POST('/pages')
  Future<GeneralListResponse> pages(@Body() Map<String, dynamic> body);

  @POST('/getacall')
  Future<GeneralMapResponse> getacall(@Body() Map<String, dynamic> body);

  @POST('/contact')
  Future<GeneralMapResponse> contact(@Body() Map<String, dynamic> body);

  @POST('/coupons')
  Future<GeneralListResponse> coupons(@Body() Map<String, dynamic> body);

  @POST('/reviews')
  Future<GeneralListResponse> reviews(@Body() Map<String, dynamic> body);

  @POST('/reviewadd')
  Future<GeneralMapResponse> reviewadd(@Body() Map<String, dynamic> body);

  // APIs EndPoints Request Bodies With/Without Token

  @POST('/cartlist')
  Future<GeneralListResponse> cartlist(@Body() Map<String, dynamic> body);

  @POST('/cartupdate')
  Future<GeneralListResponse> cartupdate(@Body() Map<String, dynamic> body);

  @POST('/cartadd')
  Future<GeneralListResponse> cartadd(@Body() Map<String, dynamic> body);

  // APIs EndPoints Request Bodies With Token

  @POST('/notifications')
  Future<GeneralListResponse> notifications(@Body() Map<String, dynamic> body);

  @POST('/notificationstatus')
  Future<GeneralMapResponse> notificationstatus(@Body() Map<String, dynamic> body);

  @POST('/signout')
  Future<GeneralMapResponse> signout(@Body() Map<String, dynamic> body);

  @POST('/deleteprofile')
  Future<GeneralMapResponse> deleteprofile(@Body() Map<String, dynamic> body);

  @POST('/dashboard')
  Future<GeneralMapResponse> dashboard(@Body() Map<String, dynamic> body);

  @POST('/orders')
  Future<GeneralListResponse> orders(@Body() Map<String, dynamic> body);

  @POST('/order')
  Future<GeneralMapResponse> order(@Body() Map<String, dynamic> body);

  @POST('/tickets')
  Future<GeneralListResponse> tickets(@Body() Map<String, dynamic> body);

  @POST('/ticketadd')
  @MultiPart()
  Future<GeneralMapResponse> ticketadd(@Body() FormData body);

  @POST('/ticketreply')
  @MultiPart()
  Future<GeneralMapResponse> ticketreply(@Body() FormData body);

  @POST('/updateprofile')
  @MultiPart()
  Future<GeneralMapResponse> updateprofile(@Body() FormData body);

  @POST('/addresssuggestions')
  Future<GeneralListResponse> addresssuggestions(@Body() Map<String, dynamic> body);
}
