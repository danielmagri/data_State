import 'package:data_state/data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TestWidgetHandleState extends StatelessWidget {
  const TestWidgetHandleState({
    required this.dataState,
    Key? key,
  }) : super(key: key);

  final DataState<String> dataState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DataState Demo',
      home: Scaffold(
        body: Observer(
          builder: (context) => dataState.handleState(
            loading: () {
              return const Text('Loading');
            },
            success: (data) {
              return const Text('Success');
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

class TestWidgetHandleStateLoadableWithData extends StatelessWidget {
  const TestWidgetHandleStateLoadableWithData({
    required this.dataState,
    Key? key,
  }) : super(key: key);

  final DataState<String> dataState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DataState Demo',
      home: Scaffold(
        body: Observer(
          builder: (context) => dataState.handleStateLoadableWithData(
            loading: (data) {
              return const Text('Loading');
            },
            success: (data) {
              return const Text('Success');
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

class TestWidgetHandleStateCustom extends StatelessWidget {
  const TestWidgetHandleStateCustom({
    required this.dataState,
    Key? key,
  }) : super(key: key);

  final DataStateCustom<String, Exception> dataState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DataState Demo',
      home: Scaffold(
        body: Observer(
          builder: (context) => dataState.handleState(
            loading: () {
              return const Text('Loading');
            },
            success: (data) {
              return const Text('Success');
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

class TestWidgetHandleStateLoadableWithDataCustom extends StatelessWidget {
  const TestWidgetHandleStateLoadableWithDataCustom({
    required this.dataState,
    Key? key,
  }) : super(key: key);

  final DataStateCustom<String, Exception> dataState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DataState Demo',
      home: Scaffold(
        body: Observer(
          builder: (context) => dataState.handleStateLoadableWithData(
            loading: (data) {
              return const Text('Loading');
            },
            success: (data) {
              return const Text('Success');
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
