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
                'Update your settings',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              // name input
              TextFormField(
                initialValue: userData.name,
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                onChanged: (val) => setState(() => _currentName = val),
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    await DatabaseService(uid: user.uid).updateUserData(
                        _currentName ?? userData.name
                        // _currentSugars ?? userData.sugars,
                        // _currentStrength ?? userData.strength
                    );
                    Navigator.pop(context);
                  }
                },
                color: colorMainAccent,
                child: Text(
                    'Update',
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

