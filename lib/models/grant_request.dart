import 'package:json_annotation/json_annotation.dart';
//import 'package:givt_mobile_apps/models/temp_user.dart';
part 'grant_request.g.dart';

@JsonSerializable()
class GrantRequest {
  @JsonKey(name: 'grant_type')
  final String grantType;
  final String userName;
  final String password;

  GrantRequest(
      {required this.grantType,
      required this.userName,
      required this.password});

  factory GrantRequest.fromData(
      String grant, String username, String password) {
    return GrantRequest(
      grantType: grant,
      userName: username,
      password: password,
    );
  }
  factory GrantRequest.fromJson(Map<String, dynamic> json) =>
      _$GrantRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GrantRequestToJson(this);
}
