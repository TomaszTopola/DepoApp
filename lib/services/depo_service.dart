import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:depo_app/services/server_properties.dart';

class DepoService{

  static Future<List<dynamic>> getAllNoGdpr() async {
    // await Future.delayed(const Duration(seconds: 3));
    // return [];
    List<dynamic> result;
    try{
      var url = Uri.http('${ServerProperties.domain}:${ServerProperties.port}', '/api/no-gdpr/depo/');
      var response = await http.get(url);
      result = await jsonDecode(response.body);
    }catch(err){
      return [];
    }
    return result;
  }
}