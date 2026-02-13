import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quickly_app/features/quickly/ui/widgets/create_note_dialog.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xff2D3138),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(
                        0.1,
                      ), // Shadow color with opacity
                      spreadRadius: 3, // How much shadow spreads
                      blurRadius: 12, // How blurry the shadow is
                      offset: Offset(
                        0,
                        4,
                      ), // Horizontal and vertical offset (x, y)
                    ),
                  ],
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SvgPicture.asset(
                    "assets/icons/note_icon.svg",
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ),

            Text(
              "No notes yet",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 32,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 12),

            Text(
              "Create your first note by tapping the button below.",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Color(0xff808999),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 24),

            SizedBox(
              height: 48,
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff30AAE9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  showDialog(context: context, builder: (context) => CreateNoteDialog(note: null,));
                },
                child: Text(
                  "Create Note",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
