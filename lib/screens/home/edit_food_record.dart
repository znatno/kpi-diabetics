import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/food_record.dart';
import 'package:flutter_diabetics/screens/home/show_recommend.dart';
import 'package:flutter_diabetics/services/database.dart';
import 'package:flutter_diabetics/shared/constants.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class EditFoodRecordForm extends StatefulWidget {

  final FoodRecord record;
  EditFoodRecordForm({ this.record });

  @override
  _EditFoodRecordFormState createState() => _EditFoodRecordFormState();
}

class _EditFoodRecordFormState extends State<EditFoodRecordForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> _recordType = ["Сніданок", "Обід", "Вечеря", "Перед сном", "Інше"];
  final List<String> _intakeUnits = ["г", "мл", "Інше"];

  String    _units;
  String    _type;
  String    _name;
  double    _amount;
  double    _carbs;

  List<dynamic> _foodList;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    final String _id = widget.record.id;
    final DateTime _timestamp = widget.record.timestamp;

    // String    _type = _recordType.first;
    // String    _type = widget.record.type;
    // String    _name = widget.record.foodList[0];
    // _units ??= widget.record.foodList[1].replaceAll(' ', '');
    // double    _amount = num.parse(widget.record.foodList[2]);
    // double    _carbs = num.parse(widget.record.foodList[3]);
    //
    // List<dynamic> _foodList = widget.record.foodList;


    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Введіть нові значення запису',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: -0.5
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: textInputDecoration.copyWith(labelText: "Прийом їжі"),
              // value: _type,
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
              initialValue: _name,
              decoration: textInputDecoration.copyWith(labelText: "Назва харчів"),
              validator: (val) => val.isEmpty ? 'Будь ласка, введіть назву' : null,
              onChanged: (val) => setState(() => _name = val),
            ),
            SizedBox(height: 20),
            // units
            DropdownButtonFormField(
              decoration: textInputDecoration.copyWith(labelText: "Одиниці"),
              // value: _units,
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
              decoration: textInputDecoration.copyWith(labelText: "Кількість (${(_units != null)?_units:"г"})"),
              validator: (val) => val.isEmpty || num.tryParse(val) < 0 ? 'Будь ласка, введіть кількість (${(_units != null)?_units:"г"})' : null,
              onChanged: (val) => setState(() => _amount = num.tryParse(val).toDouble() ?? 0.0),
            ),
            SizedBox(height: 20),
            // carbs per 100 units
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: textInputDecoration.copyWith(labelText: "Кількість вуглеводів на 100 одиниць (${(_units != null)?_units:"г"})"),
              validator: (val) => val.isEmpty || num.tryParse(val) < 0 ? 'Будь ласка, введіть кількість вуглеводів на 100 одиниць ($_units)' : null,
              onChanged: (val) => setState(() => _carbs = num.tryParse(val).toDouble() ?? 0.0),
            ),
            SizedBox(height: 10),
            Divider(),
            // SUBMIT
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {

                      _foodList = [_name, _units, _amount, _carbs];

                      FoodRecord _record = FoodRecord(
                        id: _id,
                        timestamp: _timestamp,
                        type: _type,
                        foodList: _foodList,
                        totalCarbs: _carbs * _amount / 100,
                      );

                      print("BEFORE!!");
                      print(widget.record.id);
                      print(widget.record.type);
                      print(widget.record.foodList);
                      print(widget.record.totalCarbs);
                      print(widget.record.recommendedDose);

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowRecommend(record: _record)),);
                    }
                  },
                  child: Text(
                      'Зберегти',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                ),
                SizedBox(width: 12,),
                RaisedButton(
                  onPressed: () async {
                    await DatabaseService(uid: user.uid).delFoodRecord(_id);
                    Navigator.pop(context);
                  },
                  color: Colors.redAccent,
                  child: Text(
                      'Видалити',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

