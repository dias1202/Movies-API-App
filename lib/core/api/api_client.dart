import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_constants.dart';

class ApiClient {
  final http.Client client;

  ApiClient({http.Client? client}) : client = client ?? http.Client();

  Future<Map<String, dynamic>> get(
    String path, [
    Map<String, String>? params,
  ]) async {
    final queryParameters = {
      'api_key': ApiConstants.apiKey,
      if (params != null) ...params,
    };

    final uri = Uri.parse(
      '${ApiConstants.baseUrl}$path',
    ).replace(queryParameters: queryParameters);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed GET ${uri.toString()} (status ${response.statusCode})',
      );
    }
  }
}
