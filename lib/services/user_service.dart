import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:depo_app/services/server_properties.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserService{

  static const String _tokenKey = 'depo_api_token';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<bool> login(String login, String pass) async {
    var url = Uri.http('${ServerProperties.domain}:${ServerProperties.port}', '/api/users/login');
    var response = await http.post(
      url,
      body:{
        '_id': login,
        'password': pass,
      }
    );

    if (response.body.isEmpty) return false;
    if (response.statusCode.toString() != '201') return false;

    var res = await jsonDecode(response.body);
    var token = res['token'];

    await _storage.write(key: _tokenKey, value: token);
    String? readToken = await _storage.read(key: _tokenKey);

    if(readToken!=token) return false;

    return true;
  }

  static Future<bool> isTokenValid() async{
    String? token = await _storage.read(key: 'depo_api_token');
    if (token == null) return false;

    return JwtDecoder.isExpired(token);
  }

}