import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

import 'auth_util.dart';

class ChatAPPTestFirebaseUser {
  ChatAPPTestFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

ChatAPPTestFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<ChatAPPTestFirebaseUser> chatAPPTestFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<ChatAPPTestFirebaseUser>(
      (user) {
        currentUser = ChatAPPTestFirebaseUser(user);
        updateUserJwtTimer(user);
        return currentUser!;
      },
    );
