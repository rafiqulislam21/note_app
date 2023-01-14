import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  // for scroll to top button in the note list page
  final ScrollController scrollController =
      ScrollController(keepScrollOffset: true);
  // for scroll to top button in the note list page
  final showbtn = false.obs;

  @override
  void onInit() {
    scrollController.addListener(() {
      //scroll listener
      //Back to top botton will show on scroll offset 0.0
      double showoffset = 0.0;
      if (scrollController.offset > showoffset) {
        showbtn.value = true;
      } else {
        showbtn.value = false;
      }
    });

    super.onInit();
  }
}
