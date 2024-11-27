import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_par_fans/model/perfume.dart';

const String PERFUMES_COLLECTION_REF = "perfumes";

class Database {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _perfumesRef;

  DatabaseService() {
    _perfumesRef =
        _firestore.collection(PERFUMES_COLLECTION_REF).withConverter<Perfume>(
            fromFirestore: (snapshot, _) => Perfume.fromJson(
                  snapshot.data()!,
                ),
            toFirestore: (perfume, _) => perfume.toJson());
  }

  Stream<QuerySnapshot> getPerfumes() {
    return _perfumesRef.snapshots();
  }

  void addPerfume(Perfume perfume) async {
    _perfumesRef.add(perfume);
  }
}
