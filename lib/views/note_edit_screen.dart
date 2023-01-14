import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:note_app/controllers/note_controller.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/views/widgets/custom_app_bar.dart';
import 'package:note_app/views/widgets/custom_button.dart';
import 'package:note_app/views/widgets/custom_textfield.dart';

class NoteEditScreen extends StatefulWidget {
  final NoteModel? note;
  final int? id;

  const NoteEditScreen({super.key, this.note, this.id});

  @override
  State<NoteEditScreen> createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late TextEditingController noteBodyTextController;
  final noteController = Get.put(NoteController());

  @override
  void initState() {
    noteBodyTextController =
        TextEditingController(text: widget.note?.text ?? "");

    noteBodyTextController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    noteBodyTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: widget.note == null ? "Add note" : "Edit note"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTextField(
                  hintText: "Enter your input here ... (ex: # h1, ## h2)",
                  controller: noteBodyTextController),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    icon: Icons.add,
                    label: widget.note == null ? "Add note" : "Update note",
                    onPressed: () {
                      if (noteBodyTextController.text.isEmpty) {
                        Get.snackbar("Warning!", "Note body is required!",
                            colorText: Colors.red);
                      } else {
                        if (widget.note == null) {
                          // adding new note
                          noteController
                              .postData(body: noteBodyTextController.text)
                              .then((value) {
                            Navigator.pop(context);
                          });
                        } else {
                          // updating existing note
                          noteController
                              .updateData(
                                  text: noteBodyTextController.text,
                                  note: widget.note)
                              .then((value) {
                            Navigator.pop(context);
                          });
                        }
                      }
                    },
                  ),
                  widget.note == null
                      ? const SizedBox()
                      : CustomButton(
                          icon: Icons.delete_forever,
                          label: "Delete",
                          color: Colors.red,
                          onPressed: () {
                            noteController
                                .deleteData(id: widget.note?.id)
                                .then((value) {
                              Navigator.pop(context);
                            });
                          },
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
