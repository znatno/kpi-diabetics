import 'package:flutter/material.dart';
import 'package:flutter_diabetics/screens/home/settings_form.dart';
import 'package:flutter_diabetics/services/auth.dart';
import 'package:flutter_diabetics/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_diabetics/screens/home/brew_list.dart';
import 'package:flutter_diabetics/models/brew.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          title: Text('Diabetics App'),
          backgroundColor: Colors.blue[400],
          elevation: 0,
          actions: [
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person, color: Colors.white,),
                label: Text('Log Out', style: TextStyle(color: Colors.white)),
            ),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings, color: Colors.white),
                label: Text('Settings', style: TextStyle(color: Colors.white),)
            )
          ],
        ),
        body: Container(
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('assets/coffee_bg.png'),
            //     fit: BoxFit.cover
            //   ),
            // ),
            child: BrewList()
        ),
      ),
    );
  }
}
