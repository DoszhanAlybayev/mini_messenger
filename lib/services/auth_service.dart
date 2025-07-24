import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<void> signOut() async {
    return await _auth.signOut();
  }

  User? getCurrrentUser() {
    return _auth.currentUser;
  }
}

Future<void> signUp(String email, String password) async {
  UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);

  // Добавляем пользователя в Firestore
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userCredential.user!.uid)
      .set({
        'uid': userCredential.user!.uid,
        'email': email,
        'createdAt': Timestamp.now(),
      });
}
