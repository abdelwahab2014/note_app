import '../model/import.dart';

 // add note function
  Future addNote(String collectionName,noteContent) async {
    await FirebaseFirestore.instance.collection(collectionName).add({
      // key: value here!!
      'NoteContent': noteContent,
    });
  }

   //Delete Note
  Future deleteNote(String docsID, String collectionName) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Define the reference to the document you want to delete
    final DocumentReference documentReference =
        firestore.collection(collectionName).doc(docsID);

// Call the delete method
    await documentReference.delete();
  }


  
  //Update Note
  Future updateNote(String docsID, String collectionName,noteContent) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

// Define the reference to the document you want to delete
    final DocumentReference documentReference =
        firestore.collection(collectionName).doc(docsID);

// Call the delete method
    await documentReference.update({
      'NoteContent':noteContent,
    });
  }