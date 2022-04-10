A powerful state machine for [MobX](https://pub.dev/packages/mobx) management, which can be used in almost any application state.

It has 3 states - loading, success, error - and is perfect to be used on infinite list, action buttons, with shimmers, refresh logic, etc.

## Features

- [Simple states](#simple-states)
- [Reloadable states](#reloadable-states)
- [States using _reaction_](#states-using-reaction)

## Requirements

This package just work with the [MobX](https://pub.dev/packages/mobx).
And minimum Dart SDK 2.16.

## Usage

### Simple states

To deal with simple logics, like showing a list of string.

Crate the `DataState` on the _mobx controller file_:

```dart
final dataState = DataState<List<String>>();

Future<void> fetchData() async {
  dataState.setLoadingState();

  try {
    final data = await Future.delayed(const Duration(seconds: 3))
        .then((_) => ['String 1', 'String 2', 'String 3']);
    dataState.setSuccessState(data);
  } catch (e) {
    dataState.setErrorState(e);
  }
}
```

Then add on your view the _Observer_ to present the list:

```dart
final controller = ControllerInstance();

@override
void initState() {
  fetchData();
  //...
  super.initState();
}

@override
Widget build(context) {
  //...
  Observer(
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
}
```

See the full code [here](https://github.com/danielmagri/data_state/tree/master/example/lib/simple_states).

### Reloadable states

Use the `handleStateLoadableWithData` method when wants use data on the loading widget callback.
On an infinite list or refresh logic for example.

```dart
Observer(
  builder: (context) => controller.dataState.handleStateLoadableWithData(
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
);
```

See the full example code [here](https://github.com/danielmagri/data_state/tree/master/example/lib/reloadable_states).

### States using _reaction_

To handle states only once after it changes, the `handleReactionState` is the soluction. Just set on the `initState` and remimber to dispose it on `dispose` method.

For example, to show a full dialog:

```dart
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
```

See the full example code [here](https://github.com/danielmagri/data_state/tree/master/example/lib/reaction_states).
