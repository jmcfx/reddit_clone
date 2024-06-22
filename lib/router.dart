import 'package:flutter/material.dart';
import 'package:reddit_app/features/auth/screens/login_screen.dart';
import 'package:reddit_app/features/community/screens/add_mods_screen.dart';
import 'package:reddit_app/features/community/screens/community_screen.dart';
import 'package:reddit_app/features/community/screens/create_community_screen.dart';
import 'package:reddit_app/features/community/screens/edit_community_screen.dart';
import 'package:reddit_app/features/community/screens/mod_tools_screen.dart';
import 'package:reddit_app/features/home/screens/home_screen.dart';
import 'package:reddit_app/features/post/screens/add_post_type_screen.dart';
import 'package:reddit_app/features/post/screens/comments_screen.dart';
import 'package:reddit_app/features/user_profile/screens/edit_profile_screen.dart';
import 'package:reddit_app/features/user_profile/screens/user_profile_screen.dart';
import 'package:routemaster/routemaster.dart';

// logged out route....
final loggedOutRoute =
    RouteMap(routes: {'/': (_) => const MaterialPage(child: LoginScreen())});
//logIn route.....
final loggedInRoute = RouteMap(
  routes: {
    //homeScreen route...
    '/': (_) => const MaterialPage(child: HomeScreen()),
    //createCommunityScreen route.....
    '/create-community-screen': (_) =>
        const MaterialPage(child: CreateCommunityScreen()),
    //communityScreen route....
    '/r/:name': (route) => MaterialPage(
        child: CommunityScreen(name: route.pathParameters['name']!)),
    //mod tools route....
    '/mod-tools/:name': (routeData) => MaterialPage(
            child: ModToolsScreen(
          name: routeData.pathParameters['name']!,
        )),

    // EditCommunityScreen route ...
    '/edit-community/:name': (routeData) => MaterialPage(
            child: EditCommunityScreen(
          name: routeData.pathParameters['name']!,
        )),

    //UserProfileScreen route....
    '/u/:uid': (routeData) => MaterialPage(
            child: UserProfileScreen(
          uid: routeData.pathParameters['uid']!,
        )),
    // edit profile screen route ....
    '/edit-profile/:uid': (routeData) => MaterialPage(
          child: EditProfileScreen(
            uid: routeData.pathParameters['uid']!,
          ),
        ),
        //
         '/add-post/:type': (routeData) => MaterialPage(
          child: AddPostTypeScreen(
            type: routeData.pathParameters['type']!,
          ),
        ),

      //add mod screen .....
       '/add-mods/:name': (routeData) => MaterialPage(
          child: AddModsScreen(
            name: routeData.pathParameters['name']!,
          ),
        ),
           // comment screen ....
        '/post/:postId/comments' :(route) => MaterialPage(
      child: CommentsScreen(
        postId: route.pathParameters['postId']!,
      ),
    ),
  },
);
