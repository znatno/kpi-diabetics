import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/glucose_record.dart';
import 'package:flutter_diabetics/services/database.dart';
import 'package:flutter_diabetics/shared/constants.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:flutter_diabetics/shared/loading.dart';
import 'package:provider/provider.dart';

class AddGlucoseRecordForm extends StatefulWidget {
  @override
  _AddGlucoseRecordFormState createState() => _AddGlucoseRecordFormState();
}

class _AddGlucoseRecordFormState extends State<AddGlucoseRecordForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> _recordType = ["Cніданок", "Обід", "Вечеря", "Перед сном", "Інше"];
  final List<String> _recordUnits = ["ммоль/л", "мг/дл"];

  String    _type = "Сніданок";        // сніданок, обід, вечеря тощо
  String    _units = "ммоль/л";       // ммоль/л чи інші
  String    _amount;      // кількість одиниць
  bool      _normality;   // замір знаходиться в межах допустимого
  String    _recommend;

  GlucoseRecord testRecord;


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
            validator: (val) => val.isEmpty ? 'Будь ласка, введіть кількість одиниць глюкометра' : null,
            onChanged: (val) => setState(() => _amount = val),
          ),
          SizedBox(height: 20),
          // SUBMIT
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {

                GlucoseRecord _record = new GlucoseRecord(
                  timestamp: DateTime.now(),
                  type: _type, units: _units,
                  amount: num.tryParse(_amount).toDouble(),
                  normality: true, // TODO: check for normality
                  recommend: "Рекомендації не дано", // TODO: place here a suggested dose
                );

                await DatabaseService(uid: user.uid).updateGlucoseRecord(_record);
                Navigator.pop(context);
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

