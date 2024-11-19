// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) =>
    UserProfileResponse(
      id: json['Id'] as String,
      name: json['Name'] as String,
      email: json['Email'] as String,
      mobile: json['Mobile'] as String,
    );

Map<String, dynamic> _$UserProfileResponseToJson(
        UserProfileResponse instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Email': instance.email,
      'Mobile': instance.mobile,
    };
