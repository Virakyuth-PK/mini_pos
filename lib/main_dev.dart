import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'flutter_fire/firebase_options_dev.dart';

import 'flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FConfig.appFlavor = Flavor.dev;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await runner.main();
}
