import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../globals.dart';

import '../models/project.dart';

class ProjectService {
  static Future<List<Project>> fetchProjects() async {
    final response = await http.get(Uri.parse('http://44.214.230.69:8000/sub_admin_sites/?email=$loggedInUserEmail'));  //  http://44.214.230.69:8000/sub_admin_sites/?email=abby1@gmail.com

    if (response.statusCode == 200) {
      print("enter");
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Project.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
