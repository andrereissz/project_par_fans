import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_par_fans/model/perfumeReview.dart';
import 'package:project_par_fans/model/user.dart';

const String REVIEWS_COLLECTION_REF = "reviews";
const String USERS_COLLECTION_REF = "users";

class Database {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _perfumesRef;
  late final CollectionReference _usersRef;

  DatabaseService() {
    _perfumesRef =
        _firestore.collection(REVIEWS_COLLECTION_REF).withConverter<PerfumeReview>(
            fromFirestore: (snapshot, _) => PerfumeReview.fromJson(
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

  void addPerfume(PerfumeReview perfume) async {
    _perfumesRef.add(perfume);
  }

  Stream<QuerySnapshot> getUsers() {
    return _usersRef.snapshots();
  }

  void addUser(User user) async {
    _usersRef.add(user);
  }
}
