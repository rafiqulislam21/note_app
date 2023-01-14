import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/note_list_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    initialize();
    return Scaffold(
      backgroundColor: Get.theme.primaryColor.withOpacity(0.9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: Get.theme.primaryColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(500)),
              child: const Padding(
                  padding: EdgeInsets.all(45),
                  child: Text(
                    "BB1",
                    style: TextStyle(fontSize: 100, color: Colors.white),
                  )),
            ),
            const Spacer(),
            const Text(
              "Note App",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Text(
              "backbone.one",
              style:
                  TextStyle(fontSize: 14, color: Colors.white, letterSpacing: 6
                      // letterSpacing: 2
                      ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  initialize() async {
    await 2.delay();
    Get.off(
      NoteListScreen(),
      duration: const Duration(seconds: 1),
    );
  }
}
