import 'package:flutter_test/flutter_test.dart';
import 'package:data_state/data_state.dart';
import 'test_widget_sample.dart';

void main() {
  const delay = Duration(milliseconds: 100);
  
  group('Using DataState', () {
    group('starting with loading state', () {
      test('validate the initial state', () {
        final dataState = DataState();

        expect(dataState.state, StateType.loading);
      });

      testWidgets('validate handleState method', (WidgetTester tester) async {
        final dataState = DataState<String>();

        await tester.pumpWidget(TestWidgetHandleState(dataState: dataState));

        dataState.setSuccessState('test');
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Success');
          expect(dataState.state, StateType.success);
          expect(textWidget, findsOneWidget);
        });

        dataState.setErrorState(Exception());
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Error');
          expect(dataState.state, StateType.error);
          expect(textWidget, findsOneWidget);
        });

        dataState.setLoadingState();
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Loading');
          expect(dataState.state, StateType.loading);
          expect(textWidget, findsOneWidget);
        });
      });

      testWidgets('validate handleStateLoadableWithData method',
          (WidgetTester tester) async {
        final dataState = DataState<String>();

        await tester.pumpWidget(
            TestWidgetHandleStateLoadableWithData(dataState: dataState));

        dataState.setSuccessState('test');
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Success');
          expect(dataState.state, StateType.success);
          expect(textWidget, findsOneWidget);
        });

        dataState.setErrorState(Exception());
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Error');
          expect(dataState.state, StateType.error);
          expect(textWidget, findsOneWidget);
        });

        dataState.setLoadingState();
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Loading');
          expect(dataState.state, StateType.loading);
          expect(textWidget, findsOneWidget);
        });
      });

      test('validate handleReactionState method', () async {
        const success = 'data';
        final error = Exception();
        final dataState = DataState<String>();

        final dispose = dataState.handleReactionState(
          loading: (loading) {
            expect(dataState.state, StateType.loading);
          },
          success: (data) {
            expect(dataState.state, StateType.success);
            expect(data, success);
          },
          error: (e) {
            expect(dataState.state, StateType.error);
            expect(e, error);
          },
        );

        await Future.delayed(delay)
            .then((value) => dataState.setSuccessState(success));
        await Future.delayed(delay)
            .then((value) => dataState.setErrorState(error));
        await Future.delayed(delay)
            .then((value) => dataState.setLoadingState());

        dispose();
      });
    });

    group('starting with success state', () {
      const initialData = 'test';
      test('validate the initial state', () {
        final dataState = DataState<String>.startWithSuccess(data: initialData);

        expect(dataState.state, StateType.success);
        expect(dataState.data, initialData);
      });

      testWidgets('validate handleState method', (WidgetTester tester) async {
        final dataState = DataState.startWithSuccess(data: initialData);

        await tester.pumpWidget(TestWidgetHandleState(dataState: dataState));

        final textWidget = find.text('Success');
        expect(textWidget, findsOneWidget);

        dataState.setErrorState(Exception());
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Error');
          expect(dataState.state, StateType.error);
          expect(textWidget, findsOneWidget);
        });

        dataState.setLoadingState();
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Loading');
          expect(dataState.state, StateType.loading);
          expect(textWidget, findsOneWidget);
        });

        dataState.setSuccessState('test');
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Success');
          expect(dataState.state, StateType.success);
          expect(textWidget, findsOneWidget);
        });
      });

      testWidgets('validate handleStateLoadableWithData method',
          (WidgetTester tester) async {
        final dataState = DataState.startWithSuccess(data: initialData);

        await tester.pumpWidget(
            TestWidgetHandleStateLoadableWithData(dataState: dataState));

        final textWidget = find.text('Success');
        expect(textWidget, findsOneWidget);

        dataState.setErrorState(Exception());
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Error');
          expect(dataState.state, StateType.error);
          expect(textWidget, findsOneWidget);
        });

        dataState.setLoadingState();
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Loading');
          expect(dataState.state, StateType.loading);
          expect(textWidget, findsOneWidget);
        });

        dataState.setSuccessState('test');
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Success');
          expect(dataState.state, StateType.success);
          expect(textWidget, findsOneWidget);
        });
      });

      test('validate handleReactionState method', () async {
        const success = 'data';
        final error = Exception();
        final dataState = DataState.startWithSuccess(data: initialData);

        final dispose = dataState.handleReactionState(
          loading: (loading) {
            expect(dataState.state, StateType.loading);
          },
          success: (data) {
            expect(dataState.state, StateType.success);
            expect(data, success);
          },
          error: (e) {
            expect(dataState.state, StateType.error);
            expect(e, error);
          },
        );

        await Future.delayed(delay)
            .then((value) => dataState.setSuccessState(success));
        await Future.delayed(delay)
            .then((value) => dataState.setErrorState(error));
        await Future.delayed(delay)
            .then((value) => dataState.setLoadingState());

        dispose();
      });
    });

    group('starting with error state', () {
      final initialError = Exception('test');

      test('validate the initial state', () {
        final dataState = DataState<String>.startWithError(error: initialError);

        expect(dataState.state, StateType.error);
        expect(dataState.error, initialError);
      });

      testWidgets('validate handleState method', (WidgetTester tester) async {
        final dataState = DataState<String>.startWithError(error: initialError);

        await tester.pumpWidget(TestWidgetHandleState(dataState: dataState));

        final textWidget = find.text('Error');
        expect(textWidget, findsOneWidget);

        dataState.setLoadingState();
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Loading');
          expect(dataState.state, StateType.loading);
          expect(textWidget, findsOneWidget);
        });

        dataState.setSuccessState('test');
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Success');
          expect(dataState.state, StateType.success);
          expect(textWidget, findsOneWidget);
        });

        dataState.setErrorState(Exception());
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Error');
          expect(dataState.state, StateType.error);
          expect(textWidget, findsOneWidget);
        });
      });

      testWidgets('validate handleStateLoadableWithData method',
          (WidgetTester tester) async {
        final dataState = DataState<String>.startWithError(error: initialError);

        await tester.pumpWidget(
            TestWidgetHandleStateLoadableWithData(dataState: dataState));

        final textWidget = find.text('Error');
        expect(textWidget, findsOneWidget);

        dataState.setLoadingState();
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Loading');
          expect(dataState.state, StateType.loading);
          expect(textWidget, findsOneWidget);
        });

        dataState.setSuccessState('test');
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Success');
          expect(dataState.state, StateType.success);
          expect(textWidget, findsOneWidget);
        });

        dataState.setErrorState(Exception());
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Error');
          expect(dataState.state, StateType.error);
          expect(textWidget, findsOneWidget);
        });
      });

      test('validate handleReactionState method', () async {
        const success = 'data';
        final error = Exception();
        final dataState = DataState<String>.startWithError(error: initialError);

        final dispose = dataState.handleReactionState(
          loading: (loading) {
            expect(dataState.state, StateType.loading);
          },
          success: (data) {
            expect(dataState.state, StateType.success);
            expect(data, success);
          },
          error: (e) {
            expect(dataState.state, StateType.error);
            expect(e, error);
          },
        );

        await Future.delayed(delay)
            .then((value) => dataState.setSuccessState(success));
        await Future.delayed(delay)
            .then((value) => dataState.setErrorState(error));
        await Future.delayed(delay)
            .then((value) => dataState.setLoadingState());

        dispose();
      });
    });
  });

  group('Using DataStateCustom', () {
    group('starting with loading state', () {
      test('validate the initial state', () {
        final dataState = DataStateCustom();

        expect(dataState.state, StateType.loading);
      });

      testWidgets('validate handleState method', (WidgetTester tester) async {
        final dataState = DataStateCustom<String, Exception>();

        await tester
            .pumpWidget(TestWidgetHandleStateCustom(dataState: dataState));

        dataState.setSuccessState('test');
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Success');
          expect(dataState.state, StateType.success);
          expect(textWidget, findsOneWidget);
        });

        dataState.setErrorState(Exception());
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Error');
          expect(dataState.state, StateType.error);
          expect(textWidget, findsOneWidget);
        });

        dataState.setLoadingState();
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Loading');
          expect(dataState.state, StateType.loading);
          expect(textWidget, findsOneWidget);
        });
      });

      testWidgets('validate handleStateLoadableWithData method',
          (WidgetTester tester) async {
        final dataState = DataStateCustom<String, Exception>();

        await tester.pumpWidget(
            TestWidgetHandleStateLoadableWithDataCustom(dataState: dataState));

        dataState.setSuccessState('test');
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Success');
          expect(dataState.state, StateType.success);
          expect(textWidget, findsOneWidget);
        });

        dataState.setErrorState(Exception());
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Error');
          expect(dataState.state, StateType.error);
          expect(textWidget, findsOneWidget);
        });

        dataState.setLoadingState();
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Loading');
          expect(dataState.state, StateType.loading);
          expect(textWidget, findsOneWidget);
        });
      });

      test('validate handleReactionState method', () async {
        const success = 'data';
        final error = Exception();
        final dataState = DataStateCustom<String, Exception>();

        final dispose = dataState.handleReactionState(
          loading: (loading) {
            expect(dataState.state, StateType.loading);
          },
          success: (data) {
            expect(dataState.state, StateType.success);
            expect(data, success);
          },
          error: (e) {
            expect(dataState.state, StateType.error);
            expect(e, error);
          },
        );

        await Future.delayed(delay)
            .then((value) => dataState.setSuccessState(success));
        await Future.delayed(delay)
            .then((value) => dataState.setErrorState(error));
        await Future.delayed(delay)
            .then((value) => dataState.setLoadingState());

        dispose();
      });
    });

    group('starting with success state', () {
      const initialData = 'test';
      test('validate the initial state', () {
        final dataState = DataStateCustom<String, Exception>.startWithSuccess(
            data: initialData);

        expect(dataState.state, StateType.success);
        expect(dataState.data, initialData);
      });

      testWidgets('validate handleState method', (WidgetTester tester) async {
        final dataState = DataStateCustom<String, Exception>.startWithSuccess(
            data: initialData);

        await tester
            .pumpWidget(TestWidgetHandleStateCustom(dataState: dataState));

        final textWidget = find.text('Success');
        expect(textWidget, findsOneWidget);

        dataState.setErrorState(Exception());
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Error');
          expect(dataState.state, StateType.error);
          expect(textWidget, findsOneWidget);
        });

        dataState.setLoadingState();
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Loading');
          expect(dataState.state, StateType.loading);
          expect(textWidget, findsOneWidget);
        });

        dataState.setSuccessState('test');
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Success');
          expect(dataState.state, StateType.success);
          expect(textWidget, findsOneWidget);
        });
      });

      testWidgets('validate handleStateLoadableWithData method',
          (WidgetTester tester) async {
        final dataState = DataStateCustom<String, Exception>.startWithSuccess(
            data: initialData);

        await tester.pumpWidget(
            TestWidgetHandleStateLoadableWithDataCustom(dataState: dataState));

        final textWidget = find.text('Success');
        expect(textWidget, findsOneWidget);

        dataState.setErrorState(Exception());
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Error');
          expect(dataState.state, StateType.error);
          expect(textWidget, findsOneWidget);
        });

        dataState.setLoadingState();
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Loading');
          expect(dataState.state, StateType.loading);
          expect(textWidget, findsOneWidget);
        });

        dataState.setSuccessState('test');
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Success');
          expect(dataState.state, StateType.success);
          expect(textWidget, findsOneWidget);
        });
      });

      test('validate handleReactionState method', () async {
        const success = 'data';
        final error = Exception();
        final dataState = DataStateCustom<String, Exception>.startWithSuccess(
            data: initialData);

        final dispose = dataState.handleReactionState(
          loading: (loading) {
            expect(dataState.state, StateType.loading);
          },
          success: (data) {
            expect(dataState.state, StateType.success);
            expect(data, success);
          },
          error: (e) {
            expect(dataState.state, StateType.error);
            expect(e, error);
          },
        );

        await Future.delayed(delay)
            .then((value) => dataState.setSuccessState(success));
        await Future.delayed(delay)
            .then((value) => dataState.setErrorState(error));
        await Future.delayed(delay)
            .then((value) => dataState.setLoadingState());

        dispose();
      });
    });

    group('starting with error state', () {
      final initialError = Exception('test');

      test('validate the initial state', () {
        final dataState = DataStateCustom<String, Exception>.startWithError(
            error: initialError);

        expect(dataState.state, StateType.error);
        expect(dataState.error, initialError);
      });

      testWidgets('validate handleState method', (WidgetTester tester) async {
        final dataState = DataStateCustom<String, Exception>.startWithError(
            error: initialError);

        await tester
            .pumpWidget(TestWidgetHandleStateCustom(dataState: dataState));

        final textWidget = find.text('Error');
        expect(textWidget, findsOneWidget);

        dataState.setLoadingState();
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Loading');
          expect(dataState.state, StateType.loading);
          expect(textWidget, findsOneWidget);
        });

        dataState.setSuccessState('test');
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Success');
          expect(dataState.state, StateType.success);
          expect(textWidget, findsOneWidget);
        });

        dataState.setErrorState(Exception());
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Error');
          expect(dataState.state, StateType.error);
          expect(textWidget, findsOneWidget);
        });
      });

      testWidgets('validate handleStateLoadableWithData method',
          (WidgetTester tester) async {
        final dataState = DataStateCustom<String, Exception>.startWithError(
            error: initialError);

        await tester.pumpWidget(
            TestWidgetHandleStateLoadableWithDataCustom(dataState: dataState));

        final textWidget = find.text('Error');
        expect(textWidget, findsOneWidget);

        dataState.setLoadingState();
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Loading');
          expect(dataState.state, StateType.loading);
          expect(textWidget, findsOneWidget);
        });

        dataState.setSuccessState('test');
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Success');
          expect(dataState.state, StateType.success);
          expect(textWidget, findsOneWidget);
        });

        dataState.setErrorState(Exception());
        await tester.pump(delay).then((_) {
          final textWidget = find.text('Error');
          expect(dataState.state, StateType.error);
          expect(textWidget, findsOneWidget);
        });
      });

      test('validate handleReactionState method', () async {
        const success = 'data';
        final error = Exception();
        final dataState = DataStateCustom<String, Exception>.startWithError(
            error: initialError);

        final dispose = dataState.handleReactionState(
          loading: (loading) {
            expect(dataState.state, StateType.loading);
          },
          success: (data) {
            expect(dataState.state, StateType.success);
            expect(data, success);
          },
          error: (e) {
            expect(dataState.state, StateType.error);
            expect(e, error);
          },
        );

        await Future.delayed(delay)
            .then((value) => dataState.setSuccessState(success));
        await Future.delayed(delay)
            .then((value) => dataState.setErrorState(error));
        await Future.delayed(delay)
            .then((value) => dataState.setLoadingState());

        dispose();
      });
    });
  });
}
