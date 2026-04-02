import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start EtryKZ Group Code

class EtryKZGroup {
  static String getBaseUrl() => 'https://etry.kz/api/v1';
  static Map<String, String> headers = {};
  static DefectsCall defectsCall = DefectsCall();
}

class DefectsCall {
  Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    final baseUrl = EtryKZGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Defects',
      apiUrl: '${baseUrl}/defect',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  List<String>? objecttype(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? objecttitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.object_info[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

/// End EtryKZ Group Code

class AuthCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
  }) async {
    final ffApiRequestBody = '''
{
  "ecosystem": "QMT",
  "type": "EMAIL",
  "value": "${username}",
  "password": "${password}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Auth',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/auth/authenticate?grant_type=credentials',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? accesstoken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.access_token''',
      ));
  static String? refreshtoken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.refresh_token''',
      ));
}

class AuthRefreshCall {
  static Future<ApiCallResponse> call({
    String? refresh = '',
  }) async {
    final ffApiRequestBody = '''
{
  "grant_type": "refresh_token",
  "refresh_token": "${refresh}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'AuthRefresh',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/auth/authenticate?grant_type=refresh_token&refresh_token=${refresh}',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? accesstoken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.access_token''',
      ));
  static String? refreshtoken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.refresh_token''',
      ));
}

class GetDefectsAPICall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? search = '',
    String? column = '',
    String? page = '',
    String? classifications = '',
    String? status = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDefectsAPI',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/defects/preview?workspace_id=${work}&page=1&limit=${page}${search}${column}${classifications}${status}${search}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetEngineAndOdometerCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? equipid = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEngineAndOdometer',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/equipments/${equipid}/latest-exploitation-data',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetReglamentsAPICall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? period = '',
    String? regulationform = '',
    String? page = '',
    String? equipment = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetReglamentsAPI',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/regulation/history/preview?workspace_id=${work}&page=1&limit=${page}${regulationform}${period}${equipment}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetReglamentsAPIScheduleCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? period = '',
    String? regulationform = '',
    String? page = '',
    String? equipment = '',
    String? work = '',
    String? status = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetReglamentsAPISchedule',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/regulation/schedule/preview?workspace_id=${work}&page=1&limit=${page}${regulationform}${period}${equipment}${status}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetTokenInfoCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetTokenInfo',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/auth/sessions/${access}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetWorkspaceIDCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? userId = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetWorkspaceID',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/workspace/members?user_id=${userId}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetSTOCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? workspace = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetSTO',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/workspaces/${workspace}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetServiceStationsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? workspace = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetServiceStations',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/counterparty/service-station',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetLanLonCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetLanLon',
      apiUrl: 'https://gps.equipmetry.kz/api/v1/gps/objects/${id}/position',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'JWT ${access}',
        'Source': 'GEOTEK',
        'Token': '${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GpsEquipAuthCall {
  static Future<ApiCallResponse> call() async {
    final ffApiRequestBody = '''
{
  "username": "fleet@qmt.kz",
  "password": "raar2324"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GpsEquipAuth',
      apiUrl: 'https://gps.equipmetry.kz/api/v1/token/auth',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GpsEquipAuthTwoCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    final ffApiRequestBody = '''
{
  "source": "GEOTEK",
  "username": "eguipmety",
  "password": "1q2w3e4r",
  "access_token": null
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GpsEquipAuthTwo',
      apiUrl: 'https://gps.equipmetry.kz/api/v1/gps/auth',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'JWT ${access}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetProjectInfoCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetProjectInfo',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/equipment-release/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class RoleCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Role',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/roles/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class WarehouseCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Warehouse',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/warehouse',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class InvoicesCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
    String? storehouse = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Invoices',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/invoice?storehouse_order_id=${storehouse}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ProvidersCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Providers',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/provider?state=ACTIVE',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetProjectZayavkaCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? search = '',
    String? customer = '',
    String? region = '',
    String? project = '',
    String? payment = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetProjectZayavka',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/equipment-release?workspace_id=${work}${search}${customer}${region}${project}${payment}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetCTOCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? search = '',
    String? date = '',
    String? status = '',
    String? page = '',
    String? work = '',
    String? station = '',
    String? work1 = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCTO',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/application/preview?${work}&type=REPAIR&page=1&limit=${page}${station}${search}${status}${date}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'Workspace': '${work1}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetCTODefectCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? search = '',
    String? work1 = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCTODefect',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/application/preview?defect_id=${search}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'Workspace': '${work1}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetDefectsAPINaryadCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? search = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDefectsAPINaryad',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/defects?workspace_id=${work}${search}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetServiceMaintenanceCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
    String? page = '',
    String? status = '',
    String? title = '',
    String? classification = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetServiceMaintenance',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/service/maintenances/preview?workspace_id=${work}&page=${page}&limit=10${status}${title}${classification}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'Workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetServiceMaintenanceCountCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
    String? page = '',
    String? status = '',
    String? title = '',
    String? classification = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetServiceMaintenanceCount',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/service/maintenances/count?workspace_id=${work}&page=${page}&limit=10${status}${title}${classification}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'Workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetRaportsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? date = '',
    int? page,
    String? column = '',
    String? region = '',
    String? project = '',
    String? search = '',
    String? customer = '',
    String? expstatus = '',
    String? techstatus = '',
    String? inspstatus = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetRaports',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/history/equipments?workspace_id=${work}&state=ACTIVE&page=${page}&limit=10&created_at=${date}${search}${column}${region}${project}${customer}${expstatus}${techstatus}${inspstatus}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? dataa(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetExpenseJournalCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? page = '',
    String? work = '',
    String? number = '',
    String? search = '',
    String? date = '',
    String? sum = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetExpenseJournal',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/expense-journal?${number}&workspace_id=${work}&page=1&limit=${page}${search}${date}${sum}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? dataa(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetExpenseJournalAllCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? page = '',
    String? work = '',
    String? number = '',
    String? search = '',
    String? date = '',
    String? column = '',
    String? classification = '',
    String? brand = '',
    String? cost = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetExpenseJournalAll',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/expense-journal?workspace_id=${work}&page=1&limit=${page}${search}${cost}${date}${column}${classification}${brand}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? dataa(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetExpenseJournalCountCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? page = '',
    String? work = '',
    String? number = '',
    String? search = '',
    String? date = '',
    String? sum = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetExpenseJournalCount',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/expense-journal/count?workspace_id=${work}${number}&page=${page}&limit=10${search}${date}${sum}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? dataa(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetSTATSCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? date = '',
    String? column = '',
    String? region = '',
    String? project = '',
    String? customer = '',
    String? expstatus = '',
    String? techstatus = '',
    String? inspstatus = '',
    String? search = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetSTATS',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/history/equipments/analytics/general?workspace_id=${work}&created_at=${date}${column}${region}${project}${search}${customer}${expstatus}${techstatus}${inspstatus}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? dataa(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetSTATSNaryadsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? date = '',
    String? search = '',
    String? status = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetSTATSNaryads',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets/analytics/general?workspace_id=${work}&source=DEFECT${search}${status}${date}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? dataa(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
}

class GetRaportSectorsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetRaportSectors',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/equipment/sectors',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetClassificationsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetClassifications',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/classifications?parent_id=null&workspace_id=${work}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetReglamentFormsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetReglamentForms',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/regulation/form/preview?workspace_id=${work}&state=ACTIVE',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetClassificationsAllCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetClassificationsAll',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/classifications?workspace_id=${work}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetBrandsAllCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetBrandsAll',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/brands?workspace_id=${work}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetCompaniesAllCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCompaniesAll',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/companies?workspace_id=${work}&state=ACTIVE',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetModelsAllCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetModelsAll',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/models?workspace_id=${work}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetRaportsColumnCopyCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? columnId = '',
    String? regionId = '',
    String? projectId = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetRaportsColumn Copy',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/equipments/overview',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {
        'column_id': columnId,
      },
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetServiceTasksCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? programid = '',
    String? equipmentid = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetServiceTasks',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/service/maintenances/preview?program_id=${programid}&equipment_id=${equipmentid}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetServicetasksCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetServicetasks',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/service/tasks/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetColumnsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetColumns',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/equipment/columns?workspace_id=${work}&state=ACTIVE',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetEquipmentsReglamentCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEquipmentsReglament',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/equipments/select-data?workspace_id=${work}&state=ACTIVE',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetCustomerCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCustomer',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/customer?workspace_id=${work}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? id(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetPaymentMethodCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetPaymentMethod',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/payment-method?workspace_id=${work}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetProjectsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetProjects',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/projects',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetInspectionsShablonCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetInspectionsShablon',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/maintenance/templates',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class PostInspectionsShablonCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PostInspectionsShablon',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/maintenance/templates',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ChangeRegionCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson, true);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'changeRegion',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/history/equipments',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class CTOCommandCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic bodyJson,
    String? work = '',
    String? command = '',
    String? id = '',
  }) async {
    final body = _serializeJson(bodyJson, true);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CTOCommand',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/application/${id}/${command}',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class FirebasePostCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
    String? userid = '',
    String? firebasetoken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "user_id": "${userid}",
  "token": "${firebasetoken}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'FirebasePost',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/firebase-token',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class FirebaseUpdateCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
    String? userid = '',
    String? firebasetoken = '',
  }) async {
    final ffApiRequestBody = '''
{
  "user_id": "${userid}",
  "token": "${firebasetoken}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'FirebaseUpdate',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/firebase-token/${userid}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class FirebaseDeleteCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
    String? userid = '',
    String? firebasetoken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'FirebaseDelete',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/firebase-token/675bc16c89f1fa8f844b57af',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class CTOCreateCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CTOCreate',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/application',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class NaryadTaskCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
    int? taskid,
    bool? variable,
    String? id = '',
  }) async {
    final ffApiRequestBody = '''
{
  "status": ${variable}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'NaryadTask',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets/${id}/task/${taskid}/finish',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ChangeProjectCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic bodyJson,
    String? id = '',
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson, true);
    final ffApiRequestBody = '''
{
  "equipments": ${body}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'changeProject',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/equipment-release/${id}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetDefectsbyIdCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDefectsbyId',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/defects/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetCTObyIdCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCTObyId',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/application/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetMaintanancesDetailedCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetMaintanancesDetailed',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/service/maintenances/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetEquipsByIDCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEquipsByID',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/equipments/${id}/detailed',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetDefectsbyTicketIdCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? ticketId = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDefectsbyTicketId',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/defects',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {
        'ticket_id': ticketId,
      },
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetTicketsByEquipIdCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? equip = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetTicketsByEquipId',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets?workspace_id=${work}&subject_id=${equip}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {
        'ticket_id': equip,
      },
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetDefectsbyEquipIdCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? ticketId = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDefectsbyEquipId',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/defects/preview?workspace_id=${work}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {
        'equipment_id': ticketId,
      },
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}
class GetStoreHouseHistoryCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetStoreHouseHistory',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/object/${id}/history',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  
}

class GetProcurementHistoryCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetProcurementHistory',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${id}/history',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  
}

class GetDefectsHistoryCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDefectsHistory',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/defect/${id}/history',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetNaryadsByIdCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetNaryadsById',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets/${id}/detailed',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetMemberCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetMember',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/users/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetNaryadsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? search = '',
    String? page = '',
    String? work = '',
    String? status = '',
    String? period = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetNaryads',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets/preview?workspace_id=${work}&page=1&limit=${page}${search}${status}${period}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetAppromentCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? search = '',
    String? page = '',
    String? work = '',
    String? period = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetApproment',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/approval/preview?workspace_id=${work}&type=INCOMING&page=${page}&limit=10&object_type=ALL${search}${period}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAppromentCountCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? search = '',
    String? page = '',
    String? work = '',
    String? period = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetAppromentCount',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/approval/count?workspace_id=${work}&type=INCOMING&object_type=ALL&page=${page}&limit=10&object_type=ALL${search}${period}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class NaryadsStartCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    final ffApiRequestBody = '''
{
  "area": 9,
  "equipment": 408,
  "type": "<type>",
  "title": "<title>",
  "reason": "<reason>",
  "is_fixed_on_place": false,
  "is_emergency_situation": false,
"spare_parts":[]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'NaryadsStart',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets/${id}/start',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class MaintenancesCompleteCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
    int? lastmaintenance,
  }) async {
    final ffApiRequestBody = '''
{
  "id": "${id}",
  "last_maintenance": ${lastmaintenance},
  "last_maintenance_date": "${dateTimeFormat("y-MM-ddTH:mm:ss", DateTime.now())}Z",
  "completed_tasks": []
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'MaintenancesComplete',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/service/maintenances/${id}/complete',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'Workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class MaintenancesMissedCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    final ffApiRequestBody = '''
{
  "id": "${id}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'MaintenancesMissed',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/service/maintenances/${id}/miss',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'Workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class NaryadsPauseCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    final ffApiRequestBody = '''
{
  "area": 9,
  "equipment": 408,
  "type": "<type>",
  "title": "<title>",
  "reason": "<reason>",
  "is_fixed_on_place": false,
  "is_emergency_situation": false,
"spare_parts":[]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'NaryadsPause',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets/${id}/pause',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class NaryadsCommentCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? text = '',
    String? id = '',
    String? work = '',
  }) async {
    final ffApiRequestBody = '''
{
  "text": "${text}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'NaryadsComment',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets/${id}/comment',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class NaryadsFinishCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    final ffApiRequestBody = '''
{
  "area": 9,
  "equipment": 408,
  "type": "<type>",
  "title": "<title>",
  "reason": "<reason>",
  "is_fixed_on_place": false,
  "is_emergency_situation": false,
"spare_parts":[]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'NaryadsFinish',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets/${id}/finish',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class NaryadsRejectCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    final ffApiRequestBody = '''
{
  "area": 9,
  "equipment": 408,
  "type": "<type>",
  "title": "<title>",
  "reason": "<reason>",
  "is_fixed_on_place": false,
  "is_emergency_situation": false,
"spare_parts":[]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'NaryadsReject',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets/${id}/reject',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class NaryadsFinalizeCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    final ffApiRequestBody = '''
{
  "area": 9,
  "equipment": 408,
  "type": "<type>",
  "title": "<title>",
  "reason": "<reason>",
  "is_fixed_on_place": false,
  "is_emergency_situation": false,
"spare_parts":[]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'NaryadsFinalize',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets/${id}/finalize',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<int>? areaID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? equipID(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? type(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].type''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? reason(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].reason''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? event(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].event''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? areatitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].area_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].equipment_info.type_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? authorid(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? authorfirstname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.first_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? authorlastname(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].author_info.last_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<bool>? isfixedonplace(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_fixed_on_place''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List<bool>? isemergencysituation(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].is_emergency_situation''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<bool>(x))
          .withoutNulls
          .toList();
  static List? fixedby(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_by''',
        true,
      ) as List?;
  static List? fixedon(dynamic response) => getJsonField(
        response,
        r'''$.data[:].fixed_on''',
        true,
      ) as List?;
  static List<String>? status(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].status''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetMileagesCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetMileages',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/mileages?equipment_id=${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetUsersCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetUsers',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/users?workspace_id=${work}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetUsersZakupchikCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetUsers',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/users?workspace_id=${work}&is_buyer=true',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetEmployeesCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEmployees',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/employees?workspace_id=${work}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetUserbyUdCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetUserbyUd',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/users/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class DeleteMileagesCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteMileages',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/mileages/${id}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateDefectAllIncludedCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateDefectAllIncluded',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/defects',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}



class CreateProcurementCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateProcurement',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/procurement',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class CreateProcurementApprovalCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateProcurement',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/approval',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class SendToApprovementCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic bodyJson,
    String? work = '',
    String? id = '',
    List<String>? approverIds,
    String? publication_approval_id = '',
  }) async {
    final body = _serializeJson(bodyJson);
    
    return ApiManager.instance.makeApiCall(
      callName: 'SendToApprovement',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${id}/send-to-approvement',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: '''{
        "approver_ids": ${_serializeList(approverIds)},
        "publication_approval_id": "$publication_approval_id"
      }''',
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class ChooseKPCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic bodyJson,
    String? work = '',
    String? id = '',
    List<String>? approverIds,
    List<dynamic> offers_selected = const [],
    String? publication_approval_id = '',
  }) async {
    
    
    return ApiManager.instance.makeApiCall(
      callName: 'ChooseKP',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${id}/kp/select',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: '''{
"offers_selected": ${_serializeJson(offers_selected, true)},
        "approver_ids": ${_serializeList(approverIds)},
        "publication_approval_id": "$publication_approval_id"
      }''',
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class ConfirmPaymentProcurementCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    
    String? work = '',
    String? id = '',
    String? counterpartId = '',
    
  }) async {
    
    
    return ApiManager.instance.makeApiCall(
      callName: 'ChooseKP',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${id}/payment/confirm',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: '''{
"counterparty_id": "$counterpartId"
        
      }''',
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class SendGoodsProcurementCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    
    String? work = '',
    String? id = '',
    
  }) async {
    
    
    return ApiManager.instance.makeApiCall(
      callName: 'ChooseKP',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${id}/order/send',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
     
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}


class CreateEquipmentCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateEquipment',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/equipments',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class CreateNaryadsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? title = '',
    String? subjectid = '',
    List<String>? assigneeList,
    String? targetdate = '',
    String? acceptor = '',
    String? location = '',
    String? defectid = '',
    dynamic todoJson,
    dynamic sparepartsJson,
    String? work = '',
    String? maintenanceId,
  }) async {
    final assignee = _serializeList(assigneeList);
    final todo = _serializeJson(todoJson, true);
    final spareparts = _serializeJson(sparepartsJson, true);
    final ffApiRequestBody = '''
{
  "workspace_id": "6658100482bdfc1c969c7455",
  "title": "${title}",
  "subject": {
    "title": "",
    "subject_type": "EQUIPMENT",
    "subject_id": "${subjectid}"
  },
  "assignees": ${assignee},
  "approvers": null,
  "target_date": "${targetdate}",
  "comments": null,
  "acceptor_user_id": "${acceptor}",
  "location": "${location}",
  "todo": ${todo},
  "inventory_items": ${spareparts},
  "safety_instruments": null,
  "safety_instructions": null,
  "defect_ids": [
    "${defectid}"
  ],
  "maintenance_id": ${maintenanceId != null ? '"${maintenanceId}"' : null}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateNaryads',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'Workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class CreateNaryadsMaintenanceCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? title = '',
    String? subjectid = '',
    List<String>? assigneeList,
    String? targetdate = '',
    String? acceptor = '',
    String? location = '',
    String? defectid = '',
    dynamic todoJson,
    dynamic sparepartsJson,
    String? work = '',
    String? maintenanceId = '',
  }) async {
    final assignee = _serializeList(assigneeList);
    final todo = _serializeJson(todoJson, true);
    final spareparts = _serializeJson(sparepartsJson, true);
    final ffApiRequestBody = '''
{
  "workspace_id": "6658100482bdfc1c969c7455",
  "title": "${title}",
  "subject": {
    "title": "",
    "subject_type": "EQUIPMENT",
    "subject_id": "${subjectid}"
  },
  "assignees": ${assignee},
  "approvers": null,
  "target_date": "${targetdate}",
  "comments": null,
  "acceptor_user_id": "${acceptor}",
  "location": "${location}",
  "todo": ${todo},
  "inventory_items": ${spareparts},
  "safety_instruments": null,
  "safety_instructions": null,
  "defect_ids": [],
  "mileage": null,
  "moto_hours": null,
  "media": [],
  "maintenance_id": "${maintenanceId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateNaryads',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'Workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class EditNaryadsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? title = '',
    String? subjectid = '',
    List<String>? assigneeList,
    String? targetdate = '',
    String? acceptor = '',
    String? location = '',
    String? defectid = '',
    dynamic todoJson,
    dynamic sparepartsJson,
    String? work = '',
    String? naryadid = '',
  }) async {
    final assignee = _serializeList(assigneeList);
    final todo = _serializeJson(todoJson, true);
    final spareparts = _serializeJson(sparepartsJson, true);
    final ffApiRequestBody = '''
{
  "workspace_id": "6658100482bdfc1c969c7455",
  "title": "${title}",
  "subject": {
    "title": "",
    "subject_type": "EQUIPMENT",
    "subject_id": "${subjectid}"
  },
  "assignees": ${assignee},
  "approvers": null,
  "target_date": "${targetdate}",
  "comments": null,
  "acceptor_user_id": "${acceptor}",
  "location": "${location}",
  "todo": ${todo},
  "inventory_items": ${spareparts},
  "safety_instruments": null,
  "safety_instructions": null,
  "defect_ids": [
    "${defectid}"
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'EditNaryads',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets/${naryadid}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': '${access}',
        'Workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class DeleteNaryadsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? naryadid = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteNaryads',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/operation/tickets/${naryadid}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': '${access}',
        'Workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class CreateMileageCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? equipmentId = '',
    int? value,
    String? source = '',
    String? type = '',
    String? work = '',
  }) async {
    final ffApiRequestBody = '''
{
  "equipment_id": "${equipmentId}",
  "type": "${type}",
  "value": ${value},
  "source": "${source}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateMileage',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/mileages',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class DeleteDefectsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteDefects',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/defects/${id}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic detail(dynamic response) => getJsonField(
        response,
        r'''$''',
      );
}

class GetCategoriesCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCategories',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/defect/categories',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? area(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static int? id(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.data[:].id''',
      ));
}

class UsersCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'users',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/users?workspace_id=${work}&access_state=no_access&state=ACTIVE',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? eQuipment(dynamic response) => getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?;
  static List<String>? title(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? childrentitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].children[:].title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
}

class GetDetailedDefectsCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? defect = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDetailedDefects',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/defects/${defect}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? userid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? firstname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.first_name''',
      ));
  static String? lastname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.last_name''',
      ));
  static String? patronymic(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.patronymic''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  static int? departmentid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.department_info.id''',
      ));
  static String? departmenttitle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.department_info.title''',
      ));
}

class GetDetailedReglamentCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDetailedReglament',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/regulation/history/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? userid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? firstname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.first_name''',
      ));
  static String? lastname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.last_name''',
      ));
  static String? patronymic(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.patronymic''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  static int? departmentid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.department_info.id''',
      ));
  static String? departmenttitle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.department_info.title''',
      ));
}

class PutDetailedReglamentCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
    dynamic jsonJson,
  }) async {
    final json = _serializeJson(jsonJson, true);
    final ffApiRequestBody = '''
{
  "structure": ${json}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PutDetailedReglament',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/regulation/history/${id}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? userid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? firstname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.first_name''',
      ));
  static String? lastname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.last_name''',
      ));
  static String? patronymic(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.patronymic''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  static int? departmentid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.department_info.id''',
      ));
  static String? departmenttitle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.department_info.title''',
      ));
}

class PutDetailedReglamentPassedCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
    dynamic jsonJson,
  }) async {
    final json = _serializeJson(jsonJson, true);
    final ffApiRequestBody = '''
{
  "status": "PASSED",
  "structure": ${json}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'PutDetailedReglamentPassed',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/regulation/history/${id}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? userid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? firstname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.first_name''',
      ));
  static String? lastname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.last_name''',
      ));
  static String? patronymic(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.patronymic''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  static int? departmentid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.department_info.id''',
      ));
  static String? departmenttitle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.department_info.title''',
      ));
}

class DeleteDetailedReglamentCopyCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
    dynamic jsonJson,
  }) async {
    final json = _serializeJson(jsonJson, true);

    return ApiManager.instance.makeApiCall(
      callName: 'DeleteDetailedReglament Copy',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/regulation/history/${id}',
      callType: ApiCallType.DELETE,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? userid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? firstname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.first_name''',
      ));
  static String? lastname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.last_name''',
      ));
  static String? patronymic(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.patronymic''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  static int? departmentid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.department_info.id''',
      ));
  static String? departmenttitle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.department_info.title''',
      ));
}

class DeleteDetailedReglamentCopyCopyCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
    int? inaa = 2,
  }) async {
    final ffApiRequestBody = '''
{
  "workspace_id": "675bc1aa89f1fa8f844b57b0",
  "title": "Проверка кузова автомобиля",
  "description": null,
  "structure": [
    {
      "title": "Раздел 1",
      "questions": [
        {
          "title": "Состояния кузова",
          "type": "scale",
          "is_required": true,
          "options": [],
          "logics": [
            {
              "actions": [
                "attach_media"
              ],
              "type": "lt",
              "option_key": null,
              "value": "меньше чем",
              "value_cmp_1": "2",
              "value_cmp_2": null
            }
          ],
          "is_date": null,
          "is_time": null,
          "unit_of_measurement": null,
          "from": "1",
          "to": "10"
        },
        {
          "title": "Дата проверки",
          "type": "date_time",
          "is_required": true,
          "options": [],
          "logics": [],
          "is_date": true,
          "is_time": false,
          "unit_of_measurement": null,
          "from": null,
          "to": null
        },
        {
          "title": "Время проверки",
          "type": "date_time",
          "is_required": false,
          "options": [],
          "logics": [],
          "is_date": false,
          "is_time": true,
          "unit_of_measurement": null,
          "from": null,
          "to": null
        },
        {
          "title": "Фото машины",
          "type": "media",
          "is_required": false,
          "options": [],
          "logics": [],
          "is_date": null,
          "is_time": null,
          "unit_of_measurement": null,
          "from": null,
          "to": null
        }
      ]
    }
  ],
  "equipment": {
    "by": "equipment",
    "is_all_equipment": false,
    "classifications": [],
    "is_all_brand": false,
    "brands": [],
    "is_all_model": false,
    "models": [],
    "equipments": [
      {
        "id": "675bcfb289f1fa8f844b5800",
        "title": "Автобус Daewoo BS 106 A  (048YLE04)",
        "classification": "Автобус",
        "classification_id": "66584a0282bdfc1c969c7465",
        "brand": "Daewoo",
        "brand_id": "6658a28882bdfc1c969c74ac",
        "model": "BS 106 A",
        "model_id": "6658a4f882bdfc1c969c74af",
        "license_plate_number": "048YLE04",
        "year": 2017,
        "avatar": "https://minio.fleet.equipmetry.kz/equipmetry/67c576f586aebeb51a19d353.jpg"
      }
    ]
  },
  "period": {
    "period": "daily",
    "count": 3,
    "start_time": "08:00",
    "every_n_hours": "4",
    "weekdays": [
      [],
      [],
      [],
      []
    ],
    "month_days": [],
    "date": null,
    "by": "days"
  },
  "performer": {
    "by": "user",
    "positions": [],
    "users": [
      {
        "id": "675bc16c89f1fa8f844b57af",
        "title": "Идекеев Елнур"
      }
    ]
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'DeleteDetailedReglament Copy Copy',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/regulation/form',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? userid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? firstname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.first_name''',
      ));
  static String? lastname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.last_name''',
      ));
  static String? patronymic(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.patronymic''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  static int? departmentid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.department_info.id''',
      ));
  static String? departmenttitle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.department_info.title''',
      ));
}

class StartReglamentCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
    dynamic bodyJson,
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
{
  "schedule": ${body}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'StartReglament',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/regulation/history',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? userid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.id''',
      ));
  static String? firstname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.first_name''',
      ));
  static String? lastname(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.last_name''',
      ));
  static String? patronymic(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.patronymic''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.email''',
      ));
  static int? departmentid(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.department_info.id''',
      ));
  static String? departmenttitle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.department_info.title''',
      ));
}

class GetEquipmentsTreeCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
    String? classification = '',
    String? brand = '',
    String? model = '',
    String? column = '',
    String? search = '',
    int? page,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetEquipmentsTree',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/equipments/preview?workspace_id=${work}&page=1&limit=${page}${search}${classification}${brand}${model}${column}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? equipid(dynamic response) => getJsonField(
        response,
        r'''$''',
        true,
      ) as List?;
}

class GetCatalogIdCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? classificationId = '',
    String? brandId = '',
    String? modelId = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCatalogId',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/catalog-references',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {
        'classification_id': classificationId,
        'brand_id': brandId,
        'model_id': modelId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].id''',
      ));
  static String? catalogid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].catalog_id''',
      ));
  static String? classificationid(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$[:].classification_id''',
      ));
  static String? brandid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].brand_id''',
      ));
  static String? modelid(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].model_id''',
      ));
  static dynamic params(dynamic response) => getJsonField(
        response,
        r'''$[:].param_vals''',
      );
}

class GetSparePartsCatalogCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? folderId = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetSparePartsCatalog',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/machinery-spare-parts',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {
        'folder_id': folderId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List? data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?;
  static List<int>? id(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List? responses(dynamic response) => getJsonField(
        response,
        r'''$.data[:].responses''',
        true,
      ) as List?;
  static List<String>? regulationtitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regulation_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? equiptitle(dynamic response) => (getJsonField(
        response,
        r'''$.data[:].regulation_info.equipment_info.title''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetCatalogRootCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCatalogRoot',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/catalogs/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? createdat(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.created_at''',
      ));
  static int? referencescount(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.references_count''',
      ));
  static int? folderscount(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.folders_count''',
      ));
  static String? type(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.type''',
      ));
  static String? description(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.description''',
      ));
  static String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.name''',
      ));
  static String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.id''',
      ));
}

class GetFoldersCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? catalogId = '',
    String? parentId = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetFolders',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/folders',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {
        'catalog_id': catalogId,
        'parent_id': parentId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? id(dynamic response) => (getJsonField(
        response,
        r'''$[:].id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? catalogid(dynamic response) => (getJsonField(
        response,
        r'''$[:].catalog_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$[:].name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? image(dynamic response) => (getJsonField(
        response,
        r'''$[:].image''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<int>? level(dynamic response) => (getJsonField(
        response,
        r'''$[:].level''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? childrencount(dynamic response) => (getJsonField(
        response,
        r'''$[:].children_count''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<int>? sparepartscount(dynamic response) => (getJsonField(
        response,
        r'''$[:].spare_parts_count''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<int>(x))
          .withoutNulls
          .toList();
  static List<String>? parentid(dynamic response) => (getJsonField(
        response,
        r'''$[:].parent_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class UsersListCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'UsersList',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/users?workspace_id=${work}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class StatusfixedCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    String? work = '',
  }) async {
    final ffApiRequestBody = '''
{
  "status": "APPROVED"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'statusfixed',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/defects/${id}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class EditDefectCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    String? id = '',
    List<String>? mediaList,
    String? categoryId = '',
    String? date = '',
    String? description = '',
    String? equipmentId = '',
    int? mileage,
    int? motoHours,
    dynamic sparePartsJson,
    String? title = '',
    dynamic todoJson,
    String? work = '',
    List<String>? assigneesList,
  }) async {
    final media = _serializeList(mediaList);
    final assignees = _serializeList(assigneesList);
    final spareParts = _serializeJson(sparePartsJson, true);
    final todo = _serializeJson(todoJson, true);
    final ffApiRequestBody = '''
{
  "title": "${title}",
  "description": "${description}",
  "equipment_id": "${equipmentId}",
  "category_id": ${categoryId},
  "date": "${date}",
  "mileage": ${mileage},
  "moto_hours": ${motoHours},
  "todo": ${todo},
  "spare_parts": ${spareParts},
  "media": ${media},
  "ticket_id": null,
  "source": null,
"assignee_ids":${assignees}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'editDefect',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/defects/${id}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': '${access}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.TEXT,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SessionCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'session',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/auth/sessions/${access}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class UploadPhotosCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    FFUploadedFile? files,
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'UploadPhotos',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/object/upload',
      callType: ApiCallType.POST,
      headers: {
        'workspace': '${work}',
        'Authorization': '${access}',
      },
      params: {
        'files': files,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic path(dynamic response) => getJsonField(
        response,
        r'''$.path''',
      );
}

class GPSTokenCall {
  static Future<ApiCallResponse> call() async {
    final ffApiRequestBody = '''
{
  "subUserId": 0,
  "userName": "Eguipmety",
  "password": "1q2w3e4r"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GPSToken',
      apiUrl: 'https://s5.geotek.pro/api/Token',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json-patch+json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? access(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.accessToken''',
      ));
}

class GeocoderReverseCall {
  static Future<ApiCallResponse> call({
    String? lat = '',
    String? lon = '',
    String? access = '',
  }) async {
    final ffApiRequestBody = '''
[
  {
    "lat": ${lat},
    "lng": ${lon}
  }
]''';
    return ApiManager.instance.makeApiCall(
      callName: 'GeocoderReverse',
      apiUrl: 'https://s5.geotek.pro/api/Geocoder/Reverse',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${access}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? address(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$[:].address''',
      ));
}

class ObjectstatusCall {
  static Future<ApiCallResponse> call({
    int? id,
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'objectstatus',
      apiUrl: 'https://s5.geotek.pro/api/ObjectsStatus/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? lat(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.points[:].lat''',
      ));
  static String? lan(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.points[:].lng''',
      ));
  static String? speed(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.points[:].speed''',
      ));
  static String? moto(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.stat[:].motohours''',
      ));
  static String? avgspeed(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.stat[:].avgspeed''',
      ));
  static String? maxspeed(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.stat[:].maxspeed''',
      ));
  static String? mileage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.stat[:].mileage''',
      ));
  static String? fuelperkm(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.stat[:].fuelperkm''',
      ));
}

class ObjectstatusCopyCall {
  static Future<ApiCallResponse> call({
    int? id,
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'objectstatus Copy',
      apiUrl: 'https://s5.geotek.pro/api/ObjectsStatus',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? lat(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.points[:].lat''',
      ));
  static String? lan(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.points[:].lng''',
      ));
  static String? speed(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.points[:].speed''',
      ));
  static String? moto(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.stat[:].motohours''',
      ));
  static String? avgspeed(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.stat[:].avgspeed''',
      ));
  static String? maxspeed(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.stat[:].maxspeed''',
      ));
  static String? mileage(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.stat[:].mileage''',
      ));
  static String? fuelperkm(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.stat[:].fuelperkm''',
      ));
}

class CheckCall {
  static Future<ApiCallResponse> call({
    String? access = '',
    int? id,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'check',
      apiUrl: 'https://s5.geotek.pro/api/Objects/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ProfileCall {
  static Future<ApiCallResponse> call({
    String? access = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Profile',
      apiUrl: 'https://s5.geotek.pro/api/Geozones',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json-patch+json',
        'Authorization': 'Bearer ${access}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CentrZatratCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'CentrZatrat',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/storehouse/cost-center?workspace_id=${work}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateCentrZatratDefectCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? defectid = '',
    String? zatratid = '',
    dynamic tmcJson,
    String? work = '',
    List<String>? assigneesList,
  }) async {
    final assignees = _serializeList(assigneesList);
    final tmc = _serializeJson(tmcJson);
    final ffApiRequestBody = '''
{
  "items_requested": ${tmc},
  "references": {
    "${defectid}": {
      "subject_type": "DEFECT"
    }
  },
  "cost_center_id": "${zatratid}",
  "assignee_ids": ${assignees}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateCentrZatratDefect',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/storehouse/orders',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CreateCentrZatratMaintenanceCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? maintenanceid = '',
    String? zatratid = '',
    dynamic tmcJson,
    String? work = '',
  }) async {
    final tmc = _serializeJson(tmcJson);
    final ffApiRequestBody = '''
{
  "items_requested": ${tmc},
  "references": {
    "${maintenanceid}": {
      "subject_type": "MAINTENANCE"
    }
  },
  "cost_center_id": "${zatratid}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CreateCentrZatratMaintenance',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/storehouse/orders',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class OutOfStockCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'OutOfStock',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/storehouse/orders/${id}/items/out-of-stock',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ReceiveCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Receive',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/inventory/receive',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SendZakupCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SendZakup',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/storehouse/orders/${id}/purchase-stage',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class VseZakuplenoCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VseZakupleno',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/storehouse/orders/${id}/items/out-of-stock',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SendInvoiceCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
${body}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SendInvoice',
      apiUrl: 'https://fleet.equipmetry.kz/api/v1/workspace/approval',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class OutOfStockTMCCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    dynamic bodyJson,
    String? work = '',
  }) async {
    final body = _serializeJson(bodyJson);
    final ffApiRequestBody = '''
{
  "items_out_of_stock": ${body}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'OutOfStock TMC',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/storehouse/orders/${id}/items/out-of-stock',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PurchaseStageCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'PurchaseStage',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/storehouse/orders/${id}/purchase-stage',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetDefectStoreHouseOrderCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetDefectStoreHouseOrder',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/storehouse/orders?subject_type=DEFECT&reference_id=${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}
class GetProcurementCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? work = '',
    String? search = '',
    int? page = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetProcument',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/procurement/preview?workspace_id=${work}&page=${page}&limit=10&status_category=ACTIVE${search}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetProcurementCountCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? work = '',
    String? search = '',
    int? page = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetProcurementCount',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/procurement/count?workspace_id=${work}&page=${page}&limit=10&status_category=ACTIVE${search}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetStoreHouseCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? work = '',
    String? equipment = '',
    String? search = '',
    int? page = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetStoreHouse',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/storehouse/orders/preview?workspace_id=${work}&page=${page}&limit=10${equipment}${search}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}
class GetStoreHouseCountCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? work = '',
    String? equipment = '',
    String? search = '',
    int? page = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetStoreHouse',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/storehouse/orders/count?workspace_id=${work}&page=${page}&limit=10${equipment}${search}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetStoreHouseDetailedCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetStoreHouseDetailed',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/storehouse/orders/${id}/detailed',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetApprovementDetailedCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetApprovementDetailed',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/approval/${id}/detailed',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetProcurementDetailedCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetProcurementDetailed',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${id}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

class GetProcurementAwaitingCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? work = '',
    String? search = '',
    int? page = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetProcurementAwaiting',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/procurement/preview?workspace_id=${work}&page=${page}&limit=10&status_category=AWAITING${search}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetProcurementAwaitingCountCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? work = '',
    String? search = '',
    int? page = 1,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetProcurementAwaitingCount',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/procurement/count?workspace_id=${work}&page=${page}&limit=10&status_category=AWAITING${search}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class PublishProcurementCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? id = '',
    String? work = '',
  }) async {
    const ffApiRequestBody = '{"status": "PUBLISHED"}';
    return ApiManager.instance.makeApiCall(
      callName: 'PublishProcurement',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${id}',
      callType: ApiCallType.PUT,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetProcurementParameterCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? work = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'GetProcurementParameter',
      apiUrl:
          'https://fleet.equipmetry.kz/api/v1/workspace/procurement/parameter?workspace_id=${work}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': '${token}',
        'workspace': '${work}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
