import 'package:flutter/material.dart';

import 'flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FConfig.appFlavor = Flavor.dev;
  await runner.main();
}
