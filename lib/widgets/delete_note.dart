import 'package:note_app/model/import.dart';

import '../auth/note_operation.dart';

class DeleteNote extends StatefulWidget {
  const DeleteNote({super.key, required this.noteID, required this.userEmail});
  final String noteID;
  final String userEmail;

  @override
  State<DeleteNote> createState() => _DeleteNoteState();
}

class _DeleteNoteState extends State<DeleteNote> {
  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.width;
    double iconSize = screenWidht * 0.06;
    //double fontSize = screenWidht * 0.02;
    // double space = screenHeight * 0.02;
    // double padding = screenHeight * 0.02;
    return GestureDetector(
      onTap: () {
        // get docs id/delete note
        Get.defaultDialog(
          title: "Your note will deleted ",
          content: const Text(""),

          // Cancel & confirme button
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.cancel_rounded,
                color: Colors.blue,
                size: iconSize,
              ),
            ),
            GestureDetector(
              onTap: () {
                deleteNote(widget.noteID, widget.userEmail);
                Get.back();
                success("Note deleted");
              },
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.red,
                size: iconSize,
              ),
            ),
          ],
        );
      },
      child: Icon(
        Icons.delete_forever,
        color: Colors.red,
        size: iconSize,
      ),
    );
  }
}
//Widget deleteNote =
//