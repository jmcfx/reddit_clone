// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({
   super.key, required this.name,
  });
  final String name;

// r/memes
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold();
  }
}
