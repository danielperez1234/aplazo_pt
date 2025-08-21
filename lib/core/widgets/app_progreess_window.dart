import 'package:flutter/material.dart';

class AppProgreessWindow extends StatelessWidget {
  const AppProgreessWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withAlpha(25),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
