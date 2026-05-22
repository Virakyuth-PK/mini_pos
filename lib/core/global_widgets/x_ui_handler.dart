import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin XUIControl<T extends StatefulWidget> on State<T> {
  Widget buildWithErrorHandling(
    BuildContext context,
    WidgetBuilder builder, {
    Widget? errorUI,
  }) {
    try {
      // Attempt to build the widget
      final widget = builder(context);

      // Check for null values
      if (widget == null) {
        throw Exception('Widget returned null');
      }

      return widget;
    } catch (e, stackTrace) {
      // Log the error (optional)
      debugPrint('Error occurred: $e');
      debugPrint('Stack trace: $stackTrace');

      // Return the error UI
      return errorUI ??
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 48),
                SizedBox(height: 8),
                Text(
                  'An error occurred: $e',
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
    }
  }
}
