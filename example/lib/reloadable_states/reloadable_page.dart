import 'package:example/reloadable_states/reloadable_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ReloadableStatesPage extends StatefulWidget {
  const ReloadableStatesPage({Key? key}) : super(key: key);

  @override
  State<ReloadableStatesPage> createState() => _ReloadableStatesPageState();
}

class _ReloadableStatesPageState extends State<ReloadableStatesPage> {
  final controller = ReloadableController();

  @override
  void initState() {
    controller.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reloadable states'),
      ),
      body: Center(
        child: Observer(
          builder: (context) =>
              controller.dataState.handleStateLoadableWithData(
            loading: (data) {
              return Stack(
                children: [
                  if (data != null) list(data),
                  Positioned.fill(
                    child: Container(
                        color: Colors.black45,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator()),
                  ),
                ],
              );
            },
            success: (data) => list(data),
            error: (error) {
              return const Text('Error');
            },
          ),
        ),
      ),
    );
  }

  Widget list(List<Color> data) => NotificationListener<ScrollEndNotification>(
        onNotification: (notification) {
          final metrics = notification.metrics;
          if (metrics.atEdge && metrics.pixels == metrics.maxScrollExtent) {
            controller.fetchData();
          }
          return true;
        },
        child: ListView.builder(
          // important to keep the scroll position
          key: const PageStorageKey('list'),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) => Container(
            color: data[index],
            height: 100,
          ),
        ),
      );
}
