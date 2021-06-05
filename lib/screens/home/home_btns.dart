import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:flutter_diabetics/screens/home/add_food_record.dart';
import 'package:flutter_diabetics/screens/home/add_glucose_record.dart';
import 'package:flutter_diabetics/screens/home/settings_form.dart';
import 'package:flutter_diabetics/services/auth.dart';
import 'package:flutter_diabetics/services/database.dart';
import 'package:provider/provider.dart';

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
          title: Text('Diabetics App', style: TextStyle(fontSize: 16),),
          backgroundColor: Colors.blue[400],
          brightness: Brightness.dark,
          elevation: 0,
          actions: [
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person, color: Colors.white,),
              label: Text('Log Out', style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
            FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings, color: Colors.white),
                label: Text('Settings', style: TextStyle(color: Colors.white, fontSize: 13),)
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              /* Заповнення форм */
              // Ввід прийому їжі
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                Scaffold(
                                  appBar: AppBar(
                                    title: Text("Ввід прийому їжі"),
                                    brightness: Brightness.dark,
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
                  ),
                ]
              ),
              // Ввід заміру цукру
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                Scaffold(
                                    resizeToAvoidBottomInset: false,
                                    appBar: AppBar(
                                      title: Text("Ввід заміру цукру"),
                                      brightness: Brightness.dark,
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
                  ),
              ]
              ),

              Divider(),

              /* Перегляд таблиць */
              // Перегляд прийомів їжі
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  Scaffold(
                                    appBar: AppBar(
                                      title: Text("Перегляд прийомів їжі"),
                                      brightness: Brightness.dark,
                                    ),
                                  )
                              )
                          );
                        },
                        child: Text("Перегляд прийомів їжі"),
                    ),
                  ),
                ],
              ),
              // Перегляд замірів цукру крові
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                Scaffold(
                                  appBar: AppBar(
                                    title: Text("Перегляд замірів цукру крові"),
                                    brightness: Brightness.dark,
                                  ),
                                )
                            )
                        );
                      },
                      child: Text("Перегляд замірів цукру крові"),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}