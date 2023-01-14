import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:note_app/controllers/global_controller.dart';
import 'package:note_app/controllers/note_controller.dart';
import 'package:note_app/views/note_edit_screen.dart';
import 'package:note_app/views/widgets/custom_app_bar.dart';
import 'package:note_app/views/widgets/custom_card.dart';
import 'package:note_app/views/widgets/empty_widget.dart';

class NoteListScreen extends StatelessWidget {
  final controller = Get.put(GlobalController());
  final noteController = Get.put(NoteController());

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Please confirm!'),
      content: const Text('Do You really want to exit?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            'No',
            style: TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () => SystemNavigator.pop(),
          // onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }

  NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
          appBar: CustomAppBar(
            actions: <Widget>[
              SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    onChanged: (value) async {
                      await Future<void>.delayed(
                          const Duration(milliseconds: 400));
                      // filtering data list
                      noteController.filterData(query: value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search here... ",
                      prefixIcon: const Icon(Icons.search_rounded),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: Scrollbar(
              child: Obx(
                () => AnimatedCrossFade(
                  duration: const Duration(milliseconds: 500),
                  crossFadeState: noteController.noteListFiltered.isEmpty
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: const EmptyWidget(),
                  secondChild: RefreshIndicator(
                    onRefresh: () async {
                      // Api call here if data from rest api
                      //swipe to refresh feature
                      // return Future<void>.delayed(const Duration(seconds: 3));
                    },
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      controller: controller.scrollController,
                      itemCount: noteController.noteListFiltered.length,
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemBuilder: (context, index) {
                        return CustomCard(
                          note: noteController.noteListFiltered[index],
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NoteEditScreen(
                                          id: index,
                                          note: noteController
                                              .noteListFiltered[index],
                                        )));
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(() => AnimatedOpacity(
                    duration: const Duration(milliseconds: 1000),
                    //show/hide animation
                    opacity: controller.showbtn.value ? 1.0 : 0.0,
                    //set obacity to 1 on visible, or hide
                    child: FloatingActionButton(
                      heroTag: 1,
                      onPressed: () {
                        controller.scrollController.animateTo(
                            //go to top of scroll, o offset
                            0,
                            duration: const Duration(milliseconds: 500),
                            //duration of scroll
                            curve: Curves.easeInCirc //scroll type
                            );
                      },
                      isExtended: false,
                      enableFeedback: true,
                      mini: true,
                      tooltip: "Scroll to top!",
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.white,
                      ),
                    ),
                  )),
              FloatingActionButton(
                heroTag: 2,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NoteEditScreen()));
                },
                isExtended: true,
                mini: true,
                tooltip: "Add new note",
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          )),
    );
  }
}
