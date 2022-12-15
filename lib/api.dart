import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart ' as http;

class Model {
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  const Model({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
  }
}

class Api {
  static Future<String> getUser(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('statusCode--> ' + response.body);
      return response.body;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
