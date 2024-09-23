import 'package:json_annotation/json_annotation.dart';

part 'general_map_response.g.dart';

@JsonSerializable()
class GeneralMapResponse {

  @JsonKey(name: 'message')
  late final dynamic message;

  @JsonKey(name: 'status')
  late final int status;

  @JsonKey(name: 'data')
  late final Map<String,dynamic>? data;

  GeneralMapResponse(this.data, {required this.message,required this.status});

  factory GeneralMapResponse.fromJson(Map<String, dynamic> json) => _$GeneralMapResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralMapResponseToJson(this);

}