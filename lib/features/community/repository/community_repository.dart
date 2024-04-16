import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reddit_app/core/constants/firebase_constants.dart';
import 'package:reddit_app/core/type_def.dart';

class CommunityRepository {
  final FirebaseFirestore _fireStore;

  CommunityRepository({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  FutureVoid createCommunity() async {
    try {} on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {}
  }

  CollectionReference get _communities =>
      _fireStore.collection(FirebaseConstants.communitiesCollection);
}
