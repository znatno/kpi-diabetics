import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/food_record.dart';
import 'package:flutter_diabetics/screens/home/edit_food_record.dart';
import 'package:intl/intl.dart';

class FoodTile extends StatelessWidget {

  final FoodRecord record;
  FoodTile({ this.record });

  @override
  Widget build(BuildContext context) {

    String _name = record.foodList[0];
    String _units = record.foodList[1];
    String _amount = record.foodList[2];
    String _carbs = record.foodList[3].replaceAll(' ', '');
    String _totalCarbs = record.totalCarbs.toString();
    String _recommended = record.recommendedDose.toString();

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          contentPadding: EdgeInsets.all(12),
          title: Row(
            children: [
              Text(
                DateFormat('dd/MM/yyyy, kk:mm').format(record.timestamp)
                    + ' (' + record.type + ')',
                style: TextStyle(height: 1.25),
              ),
            ],
          ),
          subtitle: Text(
            _name + ' — ' + _amount + _units + '\n' +
                _totalCarbs + ' вуглеводів (' + _carbs + ' у 100' + _units + ')\n' +
                'Рекомендовано: ' + _recommended + ' од. Новорапід Флекспен',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        title: Text('Редагувати запис', style: TextStyle(fontSize: 16),),
                        backgroundColor: Colors.blue[400],
                        brightness: Brightness.dark,
                        elevation: 0,
                      ),
                      body: Container(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                        child: Column(
                            children: [
                              EditFoodRecordForm(record: record),
                            ]
                        ),
                      ),
                    ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

