import 'package:flutter/material.dart';

class GoBack extends StatelessWidget {
  const GoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.topLeft,
      child: TextButton.icon(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: Color(0xff808999)),
        label: Text("Back", style: TextStyle(color: Color(0xff808999))),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
      ),
    );
  }
}
