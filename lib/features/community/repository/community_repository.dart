import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_app/core/constants/firebase_constants.dart';
import 'package:reddit_app/core/failure.dart';
import 'package:reddit_app/core/providers/firebase_providers.dart';
import 'package:reddit_app/core/type_def.dart';
import 'package:reddit_app/models/community_model.dart';

final communityRepositoryProvider = Provider((ref) {
  return CommunityRepository(fireStore: ref.watch(fireStoreProvider));
});

class CommunityRepository {
  final FirebaseFirestore _fireStore;

  CommunityRepository({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  FutureVoid createCommunity(Community community) async {
    try {
      var communityDoc = await _communities.doc(community.name).get();
      if (communityDoc.exists) {
        throw " Community with the same Name exists! ";
      }
      return right(_communities.doc(community.name).set(community.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  CollectionReference get _communities =>
      _fireStore.collection(FirebaseConstants.communitiesCollection);
}
