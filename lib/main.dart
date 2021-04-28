// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart';

import 'app.dart';
import 'common/repository/remote_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = BlocObserver();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Pokedex Bloc');
    setWindowMinSize(const Size(375, 667)); //iPhone 1x
    setWindowMaxSize(Size.infinite);
  }

  runApp(App(
    repository: RemoteRepository(),
  ));
}
