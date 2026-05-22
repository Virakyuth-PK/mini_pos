import 'package:get/get.dart';

GetPage customGetPage({
  required String name,
  required GetPageBuilder page,
  Bindings? binding,
  List<Bindings> bindings = const [],
  List<GetMiddleware>? middlewares,
  Transition? transition,
}) {
  // Combine middlewares if provided
  final combinedMiddlewares = [...?middlewares];

  // Return the GetPage object
  return GetPage(
    name: name,
    page: page,
    binding: binding,
    bindings: bindings,
    transition: transition,
    middlewares: combinedMiddlewares,
  );
}
