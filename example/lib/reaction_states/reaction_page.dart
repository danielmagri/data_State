import 'package:example/reaction_states/reaction_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class ReactionPage extends StatefulWidget {
  const ReactionPage({Key? key}) : super(key: key);

  @override
  State<ReactionPage> createState() => _ReactionPageState();
}

class _ReactionPageState extends State<ReactionPage> {
  final controller = ReactionController();

  List<ReactionDisposer>? reactionsDisposers;

  @override
  void initState() {
    reactionsDisposers = [
      controller.dataState.handleReactionState(
        loading: loadingDialog,
      )
    ];
    super.initState();
  }

  @override
  void dispose() {
    reactionsDisposers?.forEach((dispose) {
      dispose();
    });
    super.dispose();
  }

  void loadingDialog(bool show) {
    if (show) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(width: 32),
                  Text("Loading"),
                ],
              ),
            ),
          );
        },
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('States using reaction'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: controller.random,
              child: const Text('Random'),
            ),
            const SizedBox(height: 24),
            Observer(
                builder: (_) =>
                    controller.dataState.handleStateLoadableWithData(
                      loading: successWidget,
                      success: successWidget,
                    ))
          ],
        ),
      ),
    );
  }

  Widget successWidget(int? data) => Text('$data');
}
