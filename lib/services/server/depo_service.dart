import 'dart:convert';
import 'package:depo_app/services/server/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:depo_app/services/server/server_properties.dart';

class DepoService{

  static const String tokenKey = UserService.tokenKey;
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<List<dynamic>> getAllDepos(String sdm) async {
    // await Future.delayed(const Duration(seconds: 3));
    // return [];
    List<dynamic> result;
    try{
      String? token = await _storage.read(key: tokenKey);
      var url = Uri.http(
        '${ServerProperties.domain}:${ServerProperties.port}',
        '/api/depo/',
        {
          'sdm': sdm,
        }
      );
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token'
        }
      );
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

  static Future<dynamic> postDepo(dynamic depo) async{
    try{
      String? token = await _storage.read(key: tokenKey);
      var url = Uri.http(
          '${ServerProperties.domain}:${ServerProperties.port}',
          '/api/depo/',
      );
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(depo),
      );
      if(response.statusCode == 201) return "201 - Utworzono depozyt!";
      if(response.statusCode == 401) return "401 - Nie masz uprawnień do edytowania depozytów w SDM ${depo["sdm"]}";
      if(response.statusCode == 409) return "409 - Konflikt - duplikat ID depozytu";
    }catch(err){
      return -1;
    }
  }

  static Future<dynamic> patchDepo(dynamic depo) async{
    try{
      String? token = await _storage.read(key: tokenKey);
      var url = Uri.http(
        '${ServerProperties.domain}:${ServerProperties.port}',
        '/api/depo/${depo["_id"]}',
      );
      var response = await http.patch(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(depo),
      );
      if(response.statusCode == 201) return "201 - Zaktualizowano depozyt!";
      if(response.statusCode == 401) return "401 - Nie masz uprawnień do edytowania depozytów w SDM ${depo["sdm"]}";
      if(response.statusCode == 404) return "404 - Nie udało się odnaleźć depozytu o ID ${depo["_id"]}.";
    }catch(err){
      return -1;
    }
  }

  static String getStatusString(String status){
    if(status=="ACTIVE") return 'depozyt aktywny';
    if(status=="CONTACTED") return 'podjęto kontakt';
    if(status=="OUTDATED") return 'przeterminowany';
    if(status=="DISPOSED") return 'zgoda na utylizację';
    if(status=="ARCHIVED_DISPOSED") return 'archiwum - zutylizowano';
    if(status=="ARCHIVED") return 'archiwum';
    return 'Błąd przetwarzania statusu.';
  }

  static Icon getDepoStatusIcon(dynamic depo){
    if(depo['depo_status'] == "CONTACTED") return const Icon(Icons.email);
    if(depo['depo_status'] == "CONTACTED") return const Icon(Icons.email);
    if(depo['depo_status'] == "OUTDATED") return const Icon(Icons.hourglass_bottom);
    if(depo['depo_status'] == "DISPOSED") return const Icon(Icons.delete);
    if(depo['depo_status'] == "ARCHIVED") return const Icon(Icons.archive);
    if(depo['depo_status'] == "ARCHIVED_DISPOSED") return const Icon(Icons.auto_delete_sharp);
    return const Icon(Icons.inventory);
  }
}