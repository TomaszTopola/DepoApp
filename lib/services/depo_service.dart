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

  static Future<double> countDepos(String sdm, String status) async{
    double result;
    try{
      var url = Uri.http(
        '${ServerProperties.domain}:${ServerProperties.port}',
        '/api/no-gdpr/depo/',
        {//PARAMS
          'depo_status': status,
          'sdm': sdm,
        }
      );
      var response = await http.get(url);
      List<dynamic> decoded = await jsonDecode(response.body);
      result = decoded.length.toDouble();
    }catch(err){
      return -1;
    }
    return result;
  }
}