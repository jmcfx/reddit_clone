import 'package:flutter/material.dart';
import 'package:reddit_app/features/auth/screens/login_screen.dart';
import 'package:reddit_app/features/community/screens/community_screen.dart';
import 'package:reddit_app/features/community/screens/create_community_screen.dart';
import 'package:reddit_app/features/home/screens/home_screen.dart';
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
        child: CommunityScreen(name: route.pathParameters['name']!))
  },
);
