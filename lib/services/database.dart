import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_par_fans/model/perfume.dart';
import 'package:project_par_fans/model/user.dart';

const String PERFUMES_COLLECTION_REF = "perfumes";
const String USERS_COLLECTION_REF = "users";

class Database {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _perfumesRef;
  late final CollectionReference _usersRef;

  DatabaseService() {
    _perfumesRef =
        _firestore.collection(PERFUMES_COLLECTION_REF).withConverter<Perfume>(
            fromFirestore: (snapshot, _) => Perfume.fromJson(
                  snapshot.data()!,
                ),
            toFirestore: (perfume, _) => perfume.toJson());
    _usersRef = _firestore.collection(USERS_COLLECTION_REF).withConverter<User>(
        fromFirestore: (snapshot, _) => User.fromJson(
              snapshot.data()!,
            ),
        toFirestore: (user, _) => user.toJson());
  }

  Stream<QuerySnapshot> getPerfumes() {
    return _perfumesRef.snapshots();
  }

  void addPerfume(Perfume perfume) async {
    _perfumesRef.add(perfume);
  }

  Stream<QuerySnapshot> getUsers() {
    return _usersRef.snapshots();
  }

  void addUser(User user) async {
    _usersRef.add(user);
  }
}
