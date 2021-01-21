import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class FireStoreServices {
  FireStoreServices._();
  static final instance = FireStoreServices._();

  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.collection(path);

    print('$path: $data');
    await reference.doc().set(data);
  }
  Future<void>setDataWithID({@required String path,
    @required String docID,
    @required Map<String, dynamic> data,})async{
    final reference = FirebaseFirestore.instance.collection(path).doc(docID);


    print('$path: $data');
    await reference.set(data);
  }
  Future<void> updateData({
    @required String path,
    @required String docID,
    @required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.collection(path).doc(docID);


    print('$path: $data');
    await reference.update(data);
  }

  Future<void> deleteData({@required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('delete: $path');
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
    Query queryBuilder(Query query),
    int sort(T lhs, T rhs),
  }) {
    Query query = FirebaseFirestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }
}
