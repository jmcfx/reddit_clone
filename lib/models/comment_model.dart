
class Comment {
  final String id , text , postId , userName , profilePic;
  final DateTime createdAt;
  Comment({
    required this.id,
    required this.text,
    required this.postId,
    required this.userName,
    required this.profilePic,
    required this.createdAt,
  });

  Comment copyWith({
    String? id,
    String? text,
    String? postId,
    String? userName,
    String? profilePic,
    DateTime? createdAt,
  }) {
    return Comment(
      id: id ?? this.id,
      text: text ?? this.text,
      postId: postId ?? this.postId,
      userName: userName ?? this.userName,
      profilePic: profilePic ?? this.profilePic,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'postId': postId,
      'userName': userName,
      'profilePic': profilePic,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      postId: map['postId'] ?? '',
      userName: map['userName'] ?? '',
      profilePic: map['profilePic'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
    );
  }


  @override
  String toString() {
    return 'Comment(id: $id, text: $text, postId: $postId, userName: $userName, profilePic: $profilePic, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Comment &&
      other.id == id &&
      other.text == text &&
      other.postId == postId &&
      other.userName == userName &&
      other.profilePic == profilePic &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      text.hashCode ^
      postId.hashCode ^
      userName.hashCode ^
      profilePic.hashCode ^
      createdAt.hashCode;
  }
}
