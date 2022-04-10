import 'package:example/simple_states/simple_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SimpleStatesPage extends StatefulWidget {
  const SimpleStatesPage({Key? key}) : super(key: key);

  @override
  State<SimpleStatesPage> createState() => _SimpleStatesPageState();
}

class _SimpleStatesPageState extends State<SimpleStatesPage> {
  final controller = SimpleController();

  @override
  void initState() {
    controller.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple states'),
      ),
      body: Center(
        child: Observer(
          builder: (context) => controller.dataState.handleState(
            loading: () {
              return const CircularProgressIndicator();
            },
            success: (data) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => Text(
                  data[index],
                  textAlign: TextAlign.center,
                ),
              );
            },
            error: (error) {
              return const Text('Error');
            },
          ),
        ),
      ),
    );
  }
}
