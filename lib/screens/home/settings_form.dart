import 'package:flutter/material.dart';
import 'package:flutter_diabetics/services/database.dart';
import 'package:flutter_diabetics/shared/constants.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:flutter_diabetics/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentGlucoseCoefficient;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          UserData userData = snapshot.data;

          return Form(
              key: _formKey,
              child: Column(
                children: [
                Text(
                'Ваші налаштування',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              // name input
              TextFormField(
                initialValue: userData.name,
                decoration: textInputDecoration.copyWith(labelText: "Ім'я"),
                validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),
              SizedBox(height: 20),
              // coefficient
              TextFormField(
                initialValue: userData.glucoseCoefficient,
                decoration: textInputDecoration.copyWith(labelText: "Коефіцієнт"),
                validator: (val) => val.isEmpty ? 'Please enter a coefficient' : null,
                onChanged: (val) => setState(() => _currentGlucoseCoefficient = val),
              ),
              SizedBox(height: 8),
              Text(
                "Коефіцієнт враховується при обчисленні кількості "
                "рекомендованих одиниць інсуліновмісного препарату."
                "1 од. препарату призначається на 12 г спожитих "
                "вуглеводів, якщо ви зміните коефіцієнт на 1.5, то "
                "відповідно рекомендована доза інсуліну буде у 1.5 рази більше.\n\n"
                "Будь ласка, проконсультуйтеся з вашим лікарем.",
                style: TextStyle(fontSize: 10, color: Colors.black45),
              ),
              SizedBox(height: 16),
              RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await DatabaseService(uid: user.uid).updateUserData(
                        _currentName ?? userData.name,
                        double.parse(_currentGlucoseCoefficient) ?? "1.0",
                    );
                    Navigator.pop(context);
                  }
                },
                color: colorMainAccent,
                child: Text(
                    'Зберегти',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
        } else {
          return Loading();
        }
      }
      );
  }

}

