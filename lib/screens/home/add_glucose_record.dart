import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/glucose_record.dart';
import 'package:flutter_diabetics/screens/home/show_recommend.dart';
import 'package:flutter_diabetics/services/database.dart';
import 'package:flutter_diabetics/shared/constants.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:provider/provider.dart';
import 'dart:core';

class AddGlucoseRecordForm extends StatefulWidget {
  @override
  _AddGlucoseRecordFormState createState() => _AddGlucoseRecordFormState();
}

class _AddGlucoseRecordFormState extends State<AddGlucoseRecordForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> _recordType = ["Cніданок", "Обід", "Вечеря", "Перед сном", "Інше"];
  final List<String> _recordUnits = ["ммоль/л", "мг/дл"];

  String    _type = "Сніданок";       // сніданок, обід, вечеря тощо
  String    _units = "ммоль/л";       // ммоль/л чи інші
  String    _amount;                  // кількість одиниць
  bool      _normality = false;       // замір знаходиться в межах допустимого
  String    _recommend = "-//-";      // рекомендація

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Введіть показник вашого глюкометра',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 20),

          // type dropdown
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
          SizedBox(height: 20),
          // units
          DropdownButtonFormField(
            decoration: textInputDecoration.copyWith(labelText: "Одиниці глюкометра"),
            value: _recordUnits.first,
            onChanged: (val) => setState(() => _units = val),
            items: _recordUnits.map((type) {
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
            decoration: textInputDecoration.copyWith(labelText: "Кількість"),
            validator: (val) => val.isEmpty || num.tryParse(val) < 0 ? 'Будь ласка, введіть кількість одиниць глюкометра' : null,
            onChanged: (val) => setState(() => _amount = val),
          ),
          SizedBox(height: 20),
          // SUBMIT
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {

                double _amountNum = num.tryParse(_amount).toDouble();

                // норма після їди до 7.8 ммоль/л
                // <3.3 = гіпоглікімія, >5.5 || >7.8 = гіперглікімія
                if ((_units == "ммоль/л" && (_amountNum >= 5.5 && _amountNum <= 7.8))
                || (_units == "мг/дл" && (_amountNum >= 99 && _amountNum <= 140.5))) {
                  _normality = true;
                }

                GlucoseRecord _record = new GlucoseRecord(
                  timestamp: DateTime.now(),
                  type: _type, units: _units,
                  amount: _amountNum,
                  normality: _normality,
                  recommend: _recommend,
                );

                await DatabaseService(uid: user.uid).updateGlucoseRecord(_record);
                Navigator.pop(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => ShowRecommend(record: _record)),);
              }
            },
            color: colorMainAccent,
            child: Text(
                'Додати замір',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

