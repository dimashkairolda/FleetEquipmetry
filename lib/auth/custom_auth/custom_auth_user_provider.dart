import 'package:rxdart/rxdart.dart';

import '/backend/schema/structs/index.dart';
import 'custom_auth_manager.dart';

class Equip2AuthUser {
  Equip2AuthUser({
    required this.loggedIn,
    this.uid,
    this.userData,
  });

  bool loggedIn;
  String? uid;
  UserStruct? userData;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<Equip2AuthUser> equip2AuthUserSubject =
    BehaviorSubject.seeded(Equip2AuthUser(loggedIn: false));
Stream<Equip2AuthUser> equip2AuthUserStream() =>
    equip2AuthUserSubject.asBroadcastStream().map((user) => currentUser = user);
