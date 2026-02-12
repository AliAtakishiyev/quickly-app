import 'package:flutter/material.dart';
import 'package:quickly_app/features/quickly/ui/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff17171F),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar()
          ],
        )
        ),
    );
  }
}
