import 'package:flutter/material.dart';
import 'package:flutter_diabetics/screens/wrapper.dart';
import 'package:flutter_diabetics/services/auth.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
