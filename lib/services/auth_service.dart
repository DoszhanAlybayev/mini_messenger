import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> signUp(String email, String password) async {
  UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);

  // Добавляем пользователя в Firestore
  await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
    'uid': userCredential.user!.uid,
    'email': email,
    'createdAt': Timestamp.now(),
  });
}
