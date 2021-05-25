import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/food_record.dart';
import 'package:flutter_diabetics/screens/home/show_recommend.dart';
import 'package:flutter_diabetics/services/database.dart';
import 'package:flutter_diabetics/shared/constants.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class AddFoodRecordForm extends StatefulWidget {
  @override
  _AddFoodRecordFormState createState() => _AddFoodRecordFormState();
}

class _AddFoodRecordFormState extends State<AddFoodRecordForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> _recordType = ["Cніданок", "Обід", "Вечеря", "Перед сном", "Інше"];
  final List<String> _intakeUnits = ["Грами", "Мілілітри", "Інше"];

  String    _type = "Сніданок";       // сніданок, обід, вечеря тощо
  double    _totalCarbs;              // кількість одиниць
  double    _recommendedDose;         // рекомендована доза

  String    _name;        // назва їжі
  String    _units = "Грами";       // грами, мл тощо
  double    _amount;      // к-сть грам/мл
  double    _carbs;       // к-сть вуглеводів на 100 од.
  double    _intakeCarbs; // amount * carbs

  var test;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // mealType (foodRecord.type)
            DropdownButtonFormField(
              decoration: textInputDecoration.copyWith(labelText: "Прийом їжі"),
              value: _recordType.first,
              onChanged: (val) => setState(() => _type = val),
              items: _recordType.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text('$type'),
                );
              }).toList(),
            ),
            SizedBox(height: 40),
            Text(
              'Введіть що ви їли',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            // name
            TextFormField(
              decoration: textInputDecoration.copyWith(labelText: "Назва харчів"),
              validator: (val) => val.isEmpty ? 'Будь ласка, введіть назву' : null,
              onChanged: (val) => setState(() => _name = val),
            ),
            SizedBox(height: 20),
            // units
            DropdownButtonFormField(
              decoration: textInputDecoration.copyWith(labelText: "Тип одиниць"),
              value: _intakeUnits.first,
              onChanged: (val) => setState(() => _units = val),
              items: _intakeUnits.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text('$type'),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // amount
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: textInputDecoration.copyWith(labelText: "Кількість ($_units)"),
              validator: (val) => val.isEmpty || num.tryParse(val) < 0 ? 'Будь ласка, введіть кількість ($_units)' : null,
              onChanged: (val) => setState(() => _amount = num.tryParse(val)),
            ),
            SizedBox(height: 20),
            // carbs per 100 units
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: textInputDecoration.copyWith(labelText: "Кількість вуглеводів на 100 одиниць ($_units)"),
              validator: (val) => val.isEmpty || num.tryParse(val) < 0 ? 'Будь ласка, введіть кількість вуглеводів на 100 одиниць ($_units)' : null,
              onChanged: (val) => setState(() => _carbs = num.tryParse(val)),
            ),
            SizedBox(height: 10),
            // Add foodIntake
            RaisedButton(
              onPressed: () async {

                // TODO: додати функцію додавання додаткового foodIntake
              },
              color: Colors.blue[300],
              child: Text(
                  'Додати ще спожиту їжу',
                  style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),
            Divider(),
            // SUBMIT
            RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {

                  FoodRecord _record = new FoodRecord(
                    timestamp: DateTime.now(),
                    type: _type,
                    foodList: test,
                    totalCarbs: _totalCarbs,
                    recommendedDose: _recommendedDose,
                  );

                  await DatabaseService(uid: user.uid).updateFoodRecord(_record);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowRecommend(record: _record)),);
                }
              },
              color: colorMainAccent,
              child: Text(
                  'Додати прийом їжі',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

