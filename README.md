# compute_important_demo_api

A new Flutter project.

## Getting Started

1. Compute Vs Isolate Flutter

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

2. ISOLATE

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
