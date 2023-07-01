import 'package:breaking_bad/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GOT(
    appRouter: AppRouter(),
  ));
}

class GOT extends StatelessWidget {
  const GOT({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo
      ),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
