import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/project.dart';

class ProjectService {
  static Future<List<Project>> fetchProjects() async {
    final response = await http.get(Uri.parse('http://44.214.230.69:8000/get_active_inactive/'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Project.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load projects');
    }
  }
}
