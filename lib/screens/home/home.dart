import 'package:flutter/material.dart';
import 'package:flutter_diabetics/screens/home/add_food_record.dart';
import 'package:flutter_diabetics/screens/home/add_glucose_record.dart';
import 'package:flutter_diabetics/screens/home/settings_form.dart';
import 'package:flutter_diabetics/screens/home/show_food_records.dart';
import 'package:flutter_diabetics/screens/home/show_glucose_records.dart';
import 'package:flutter_diabetics/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: SettingsForm(),
        );
      });
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Контроль Діабету', style: TextStyle(fontSize: 16),),
          backgroundColor: Colors.blue[400],
          brightness: Brightness.dark,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(Icons.settings, color: Colors.white),
            ),
            IconButton(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.logout, color: Colors.white,),
            ),
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
                                  ShowFoodRecords(),
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
                                ShowGlucoseRecords(),
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