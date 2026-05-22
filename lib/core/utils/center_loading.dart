import 'package:flutter/material.dart';

import 'app_color.dart';

class CenterLoading extends StatelessWidget {
  const CenterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: AppColor.primaryColor),
    );
  }
}
