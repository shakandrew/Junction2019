import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:greenlist/screens/start/index.dart';
import 'package:greenlist/services/sembastHydratedStorage.dart';
import 'package:greenlist/styles.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'blocs/index.dart';
import 'screens/main/index.dart';
import 'screens/splash.dart';
import 'services/database.dart';

bool isInDebugMode = false;
void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runZoned<Future<void>>(() async {
    startHome();
  }, onError: (error, stackTrace) async {
    print('Caught error: $error');
    print(stackTrace);
  });
}

class MyHydratedBlocDelegate extends HydratedBlocDelegate {
  MyHydratedBlocDelegate() : super(SembastHydratedStorage());
}

void startHome() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBase().open();
  MyHydratedBlocDelegate delegate = MyHydratedBlocDelegate();
  await (delegate.storage as SembastHydratedStorage).load();
  await (delegate.storage as SembastHydratedStorage).clear();
  BlocSupervisor.delegate = delegate;
  InitBloc().add(InitInitEvent());

  runApp(
    MaterialApp(
      title: 'GreenList',
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: greenColor,
        primaryColor: greenColor,
        canvasColor: whiteColor,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Builder(
        builder: (context) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return Container(
              color: Colors.black,
              child: Text(
                "Unexpected error",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.white),
              ),
            );
          };
          return BlocBuilder(
            bloc: InitBloc(),
            builder: (context, InitState state) {
              if (state.uuid == null) {
                return StartScreen();
              }
              if (state.inited) {
                return MainScreen();
              }
              return SplashScreen();
            },
          );
        },
      ),
    ),
  );
}
