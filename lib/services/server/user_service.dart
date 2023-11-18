import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:depo_app/services/server/server_properties.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserService{

  static const String tokenKey = 'depo_api_token';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<bool> login(String login, String pass) async {
    try{
      var url = Uri.http('${ServerProperties.domain}:${ServerProperties.port}', '/api/users/login');
      var response = await http.post(
          url,
          body: json.encode({
            '_id': login,
            'password': pass,
          }),
          headers: {
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            'Accept': '*/*'
          }
      );

      if (response.body.isEmpty) return false;
      if (response.statusCode.toString() != '201') return false;

      var res = await jsonDecode(response.body);
      var token = res['token'];

      await _storage.write(key: tokenKey, value: token);
      String? readToken = await _storage.read(key: tokenKey);

      if(readToken!=token) return false;

      return true;
    } catch (err){
      print(err);
      return false;
    }
  }

  static Future<void> logout() async{
    _storage.delete(key: tokenKey);
  }

  static Future<bool> isTokenValid() async{
    String? token = await _storage.read(key: tokenKey);

    // print('token: $token');
    // print('token: ${JwtDecoder.decode(token!)}');

    if (token == null || token == '') return false;
    DateTime expiresAt = JwtDecoder.getExpirationDate(token);

    return expiresAt.isAfter(DateTime.now());
  }

  static Future<dynamic> getKeepers() async{
    var url = Uri.http(
      '${ServerProperties.domain}:${ServerProperties.port}',
      '/api/users/',
    );
    try{
      String? token = await _storage.read(key: tokenKey);
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token'
        }
      );
      var decoded = await jsonDecode(response.body);
      return decoded;
    }catch(err){
      return -1;
    }

  }

  static Future<dynamic> getKeeperName(String id) async{
    var url = Uri.http(
      '${ServerProperties.domain}:${ServerProperties.port}',
      '/api/users/${id.toString()}',
    );
    try{
      String? token = await _storage.read(key: tokenKey);
      var response = await http.get(
          url,
          headers: {
            'Authorization': 'Bearer $token'
          }
      );
      var decoded = await jsonDecode(response.body);
      return decoded;
    }catch(err){
      return -1;
    }

  }

}