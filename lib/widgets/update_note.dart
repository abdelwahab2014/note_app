import '../auth/note_operation.dart';
import '../model/import.dart';

class UpdateNote extends StatefulWidget {
  const UpdateNote(
      {super.key,
      required this.noteID,
      required this.userEmail,
      required this.noteController});
  final String noteID;
  final String userEmail;
  final TextEditingController noteController;

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    //double screenHeight = MediaQuery.of(context).size.height;
    double iconSize = screenWidht * 0.06;

    return GestureDetector(
      onTap: () {
        Get.defaultDialog(
            title: "update note",
            content: TextField(
              decoration: InputDecoration(
                hintText: "Type here to update",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(screenWidht * 0.02),
                  ),
                ),
              ),
              controller: widget.noteController,
              enableIMEPersonalizedLearning: true,
              onChanged: (value) {
                if (value != '') {
                  updateNote(widget.noteID, widget.userEmail,
                      widget.noteController.text.trim());
                }
              },
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  if (widget.noteController.text == "") {
                    error("Note can't be empty");
                  } else {
                    updateNote(widget.noteID, widget.userEmail,
                        widget.noteController.text.trim());

                    Get.back();
                    success("Note Updated");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(screenWidht * 0.02),
                  ),
                  child: Icon(
                    Icons.edit,
                    size: iconSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ]);
      },
      child: Icon(
        Icons.edit,
        color: Colors.greenAccent,
        size: iconSize,
      ),
    );
  }
}
