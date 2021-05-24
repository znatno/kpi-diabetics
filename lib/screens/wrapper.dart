import 'package:flutter/material.dart';
import 'package:flutter_diabetics/screens/authenticate/authenticate.dart';
import 'package:flutter_diabetics/screens/home/home.dart';
import 'package:flutter_diabetics/screens/home/home_btns.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    // return either Home or Auth widget
    if (user == null) {
      return Authenticate();
    } else {
      return HomeBtns();
    }

  }
}
