import 'package:json_annotation/json_annotation.dart';

part 'general_list_response.g.dart';

@JsonSerializable()
class GeneralListResponse {

  @JsonKey(name: 'message')
  late final dynamic message;

  @JsonKey(name: 'status')
  late final int status;

  @JsonKey(name: 'data')
  late final List<dynamic>? data;

  GeneralListResponse(this.data, {required this.message,required this.status});

  factory GeneralListResponse.fromJson(Map<String, dynamic> json) => _$GeneralListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralListResponseToJson(this);

}