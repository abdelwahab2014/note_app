import '../model/import.dart';
//import '../widgets/update_note.dart';

class ViewNote extends StatelessWidget {
  const ViewNote({super.key, required this.noteContent});
  final String noteContent;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Card(
              color: MyColors.orangeColor,
              child: Text(noteContent),
            ),
            Row(
                // children: [
                //   // Update note here
                //     UpdateNote(noteID:notes[index].id ,userEmail: currentUser.email.toString(),
                //     noteController:_noteController ,),

                //   SizedBox(
                //     width: space,
                //   ),
                //   // delete note
                //   DeleteNote(noteID:notes[index].id ,userEmail: currentUser.email.toString(),),
                // ],
                ),
          ],
        ),
      ),
    );
  }
}
