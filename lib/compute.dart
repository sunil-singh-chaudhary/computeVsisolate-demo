import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../api.dart';

class ComputeService {
  Future<List<Model>> fetchUser() async {
    String response =
        await Api.getUser("https://jsonplaceholder.typicode.com/comments");
    return await compute(deserializeJsons, response);
  }
  List<Model> deserializeJsons(String response) {
    // return List<Model>.fromJson(jsonDecode(response));

    return List<Model>.from(
        json.decode(response).map((x) => Model.fromJson(x)));
  }
}
