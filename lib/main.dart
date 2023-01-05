import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'Screen1.dart';
import 'Screen2.dart';

void main() {
  runApp(const MyApp());
}

GoRouter router() {
  return GoRouter(
    initialLocation: "/screen1",
    routes: [
      GoRoute(path: "/screen1", builder: (context, state) => const Screen1()),
      GoRoute(path: "/screen2", builder: (context, state) => const Screen2())
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: MaterialApp.router(
      title: "Is this some good architecture???",
      routerConfig: router(),
    ));
  }
}
