import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_product/features/authenticate/blocs/login_bloc.dart';
import 'package:management_product/features/authenticate/screens/login_screen.dart';
import 'package:management_product/features/home/screens/home_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginBloc()),
        ],
        child: const ManagementProductApp()),
    ),
  );
}

class ManagementProductApp extends StatefulWidget {
  const ManagementProductApp({Key? key}) : super(key: key);

  @override
  State<ManagementProductApp> createState() => _ManagementProductAppState();
}

class _ManagementProductAppState extends State<ManagementProductApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
