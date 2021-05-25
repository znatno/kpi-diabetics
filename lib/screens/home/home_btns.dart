import 'package:flutter/material.dart';
import 'package:flutter_diabetics/screens/home/add_food_record.dart';
import 'package:flutter_diabetics/screens/home/add_glucose_record.dart';
import 'package:flutter_diabetics/screens/home/settings_form.dart';
import 'package:flutter_diabetics/services/auth.dart';
import 'package:flutter_diabetics/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_diabetics/screens/home/brew_list.dart';
import 'package:flutter_diabetics/models/brew.dart';

class HomeBtns extends StatelessWidget {

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

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
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
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ввід - заповнення форм
              Row(
                children: [
                  // Ввід прийому їжі
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                Scaffold(
                                  appBar: AppBar(
                                    title: Text("Ввід прийому їжі"),
                                  ),
                                  body: Container(
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                                    child: AddFoodRecordForm(),
                                  )
                                )
                            )
                        );
                      },
                      child: Text('Ввід прийому їжі'),
                  ),
                  SizedBox(width: 12,),
                  // Ввід заміру цукру
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                Scaffold(
                                    resizeToAvoidBottomInset: false,
                                    appBar: AppBar(
                                    title: Text("Ввід заміру цукру"),
                                  ),
                                    body: Container(
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                                    child: AddGlucoseRecordForm(),
                                  )
                                )
                            )
                        );
                      },
                      child: Text('Ввід заміру цукру'),
                  ),
                ],
              ),
              // Вивід - перегляд таблиць
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                Scaffold(
                                  appBar: AppBar(
                                    title: Text("Перегляд прийомів"),
                                  ),
                                )
                            )
                        );
                      },
                      child: Text('Перегляд прийомів'),
                  ),
                  SizedBox(width: 12,),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                Scaffold(
                                  appBar: AppBar(
                                    title: Text("Перегляд замірів"),
                                  ),
                                )
                            )
                        );
                      },
                      child: Text('Перегляд замірів'),
                  ),

                ],
              ),
            ],
          ),
        )
    );
  }
}