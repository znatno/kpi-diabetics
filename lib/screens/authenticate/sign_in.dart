import 'package:flutter/material.dart';
import 'package:flutter_diabetics/services/auth.dart';
import 'package:flutter_diabetics/shared/constants.dart';
import 'package:flutter_diabetics/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text fields state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :
    Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        brightness: Brightness.dark,
        elevation: 0,
        title: Text('Вхід'),
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person, color: Colors.white),
              label: Text('Реєстрація', style: TextStyle(color: Colors.white))
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val.isEmpty ? 'Введіть email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Пароль'),
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Пароль має бути довше 6 символів' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);

                    // W/System  (18638): Ignoring header X-Firebase-Locale because its value was null.
                    dynamic res = await _auth.signInWithEmailPassword(email, password);

                    if (res == null) {
                      setState(() {
                        error = 'Неможливо увійти. Email та пароль не збігаються.';
                        loading = false;
                      });
                    }
                  }
                },
                color: colorMainAccent,
                child: Text(
                  'Увійти',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 12,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
