import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/model/colors.dart';
import 'package:get/get.dart';
import '../auth/note_operation.dart';
import '../model/bg.dart';
import '../widgets/delete_note.dart';
import '../widgets/success_error.dart';
import '../widgets/update_note.dart';
import 'view_note.dart';

class Note extends StatefulWidget {
  const Note({super.key});

  @override
  NoteState createState() => NoteState();
}

class NoteState extends State<Note> {
  // note Controller
  final _noteController = TextEditingController();
  // Dispose
  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
    //...
  }

  @override
  Widget build(BuildContext context) {
    double screenWidht = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    double iconSize = screenWidht * 0.06;
    double space = screenHeight * 0.02;
    double padding = screenHeight * 0.02;
    // ! prevent null values
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          currentUser.email.toString(),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: const Icon(
                  Icons.logout_rounded,
                  color: MyColors.whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(currentUser.email.toString())
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final notes = snapshot.data!.docs;
            return SizedBox(
              height: screenHeight * 2,
              width: screenWidht,
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return Container(
                    decoration: BoxDecoration(
                      gradient: noteBG,
                     
                      borderRadius: BorderRadius.all(
                        Radius.circular(screenWidht * 0.02),
                      ),
                    ),
                    margin: EdgeInsets.all(screenWidht * 0.02),
                    child: ListTile(
                      title: Padding(
                        padding: EdgeInsets.all(padding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Note content here
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(()=> ViewNote(noteContent: note.data()['NoteContent'],),);
                                },
                                child: Text(
                                  note.data()['NoteContent'],
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                // Update note here
                                  UpdateNote(noteID:notes[index].id ,userEmail: currentUser.email.toString(),
                                  noteController:_noteController ,),
                             
                                SizedBox(
                                  width: space,
                                ),
                                // delete note
                                DeleteNote(noteID:notes[index].id ,userEmail: currentUser.email.toString(),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      // Add note here
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
          Get.defaultDialog(
              title: "Add note",
              content: SizedBox(
                height: screenHeight * 0.1,
                width: screenWidht,
                child: TextField(
                  decoration: InputDecoration(
                    //counterText: "${_enteredText.length}/120",
                    hintText: "Type your note here",
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(screenWidht * 0.02),
                      ),
                    ),
                  ),
                  controller: _noteController,
                  autocorrect: true,
                  autofocus: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(120),
                  ],
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: () {
                    if (_noteController.text == "") {
                      error("Note can't be empty");
                    } else {
                      addNote(currentUser.email.toString(), _noteController.text.trim());

                      Get.back();
                      success("Note added");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(screenWidht * 0.02),
                    ),
                    child: Icon(
                      Icons.add,
                      size: iconSize,
                      color: Colors.greenAccent,
                    ),
                  ),
                ),
              ]);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
