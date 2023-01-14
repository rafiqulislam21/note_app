import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jiffy/jiffy.dart';
import 'package:note_app/models/note_model.dart';

class CustomCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onTap;

  const CustomCard({Key? key, required this.note, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("🕒  ${Jiffy(note.createdAt).fromNow()}"),
            Text("✏ ${Jiffy(note.updatedAt).fromNow()}")
          ],
        ),
        onTap: onTap,
        title: MarkdownBody(
          data: note.text ?? "",
        ),
      ),
    );
  }
}
