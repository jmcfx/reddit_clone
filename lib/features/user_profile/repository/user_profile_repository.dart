import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_app/core/constants/firebase_constants.dart';
import 'package:reddit_app/core/failure.dart';
import 'package:reddit_app/core/providers/firebase_providers.dart';
import 'package:reddit_app/core/type_def.dart';
import 'package:reddit_app/models/user_model.dart';

final userProfileRepositoryProvider = Provider((ref) {
  return UserProfileRepository(fireStore: ref.watch(fireStoreProvider));
});

class UserProfileRepository {
  final FirebaseFirestore _fireStore;
   UserProfileRepository({required FirebaseFirestore fireStore}) : _fireStore = fireStore;


CollectionReference get _users =>
      _fireStore.collection(FirebaseConstants.usersCollection);  

  FutureVoid editProfile(UserModel user) async {
    try {
      return right(_users.doc(user.uid).update(user.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

}
