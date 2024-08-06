import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:turnstileadmin_v2/globals.dart' as globals;
import '../../../globals.dart';


class APIService {
  static const String baseUrl = 'http://44.214.230.69:8000/login_new/'; // Replace with your API base URL

  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl'),
        body: {'email': email, 'password': password},
      );

      print('Request URL: $baseUrl');
      print('Request Body: ${jsonEncode({'email': email, 'password': password})}'); // Mask password
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        globals.loggedInUserEmail = email;
        print(loggedInUserEmail);


        // Parse the JSON response body
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        // Check the message field for success indication
        if (responseBody.containsKey('message') && responseBody['message'] == 'Login successful') {
          return true;
        } else {
          // Handle other success scenarios if needed
          return false;
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }


}


