import 'package:compute_important_demo_api/SpawnService.dart';
import 'package:compute_important_demo_api/api.dart';
import 'package:compute_important_demo_api/compute.dart';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Model> _userList = [];
  String? md5Hash;

  //create object first for easily access later

  final computeService = ComputeService();
  final spawnService = SpawnService();

  void _compute() {
    computeService.fetchUser().then((listofData) {
      setState(() {
        _userList = listofData;
      });
    });
  }

  void _spawn() {
    spawnService.fetchUser().then((value) {
      setState(() {
        _userList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(child: listViewData(_userList)),
            //  Text(_userList[0].email ?? 'No data'),  //generated error before getting value it is null i.e

            // Text(model_list.length == 0
            //     ? 'No Email Found'
            //     : model_list[0].email.toString()),         //it worked

            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
                onPressed: _compute, child: const Text("Using Compute")),
            ElevatedButton(
                onPressed: _compute, child: const Text("Using Spawn")),
          ],
        ),
      ),
    );
  }

  Widget listViewData(List<Model> _userList) {
    return ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, int index) {
          return ListTile(
            title: Text("${_userList[index].email}"),
          );
        });
  }
}
