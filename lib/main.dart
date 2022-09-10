import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Pages/error_screen.dart';
import 'Pages/loading_screen.dart';
import 'Pages/auth_checker.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

//  This is a FutureProvider that will be used to check whether the firebase has been initialized or not
final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyClaDCsF1iJv5dY622kmsHFPA7iqyDhK8o",
      appId: "1:861503365786:android:6aadb52ad234f3bb4f7523",
      messagingSenderId: "XXX",
      projectId: "aumet-flutter-assessment",
    ),
  );
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseinitializerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: initialize.when(
          data: (data) {
            return const AuthChecker();
          },
          loading: () => const LoadingScreen(),
          error: (e, stackTrace) => ErrorScreen(e, stackTrace)),
    );
  }
}
