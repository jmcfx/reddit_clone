import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reddit_app/core/constants/firebase_constants.dart';
import 'package:reddit_app/core/failure.dart';
import 'package:reddit_app/core/providers/firebase_providers.dart';
import 'package:reddit_app/core/type_def.dart';
import 'package:reddit_app/models/post_model.dart';

final postRepositoryProvider = Provider((ref) {
  return PostRepository(fireStore: ref.watch(fireStoreProvider));
});

class PostRepository {
  final FirebaseFirestore _fireStore;
  PostRepository({required FirebaseFirestore fireStore})
      : _fireStore = fireStore;

  CollectionReference get _posts =>
      _fireStore.collection(FirebaseConstants.postsCollection);

      FutureVoid addPost(Post post) async {
    try {
      return right(_posts.doc(post.id).set(post.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
