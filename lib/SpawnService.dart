import 'dart:convert';
import 'dart:isolate';

import '../api.dart';

class SpawnService {
  Future<List<Model>> fetchUser() async {
    ReceivePort port = ReceivePort();
    String userData =
        await Api.getUser("https://jsonplaceholder.typicode.com/comments");
    await Isolate.spawn<List<dynamic>>(
        deserializePerson, [port.sendPort, userData]);
    return await port.first;
  }

  void deserializePerson(List<dynamic> values) {
    SendPort sendPort = values[0];
    String response = values[1];

    sendPort.send(
        List<Model>.from(json.decode(response).map((x) => Model.fromJson(x))));
  }
}
