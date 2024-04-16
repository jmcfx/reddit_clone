import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({super.key});
  
  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community-screen');
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: ListTile(
          title: const Text('Create community'),
          leading: const Icon(Icons.add),
          onTap: () => navigateToCreateCommunity(context),
        ),
      ),
    );
  }
}
