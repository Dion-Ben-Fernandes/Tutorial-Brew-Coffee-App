import 'package:brew_crew_flutter_firebase/screens/wrapper.dart';
import 'package:brew_crew_flutter_firebase/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('main');
    return StreamProvider<User>.value(
      value: AuthServices().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
