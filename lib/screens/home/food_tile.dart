import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/food_record.dart';
import 'package:intl/intl.dart';

class FoodTile extends StatelessWidget {

  final FoodRecord record;
  FoodTile({ this.record });

  @override
  Widget build(BuildContext context) {

    //print(record.foodList);
    String _product = record.foodList[0];
    String _units = record.foodList[1];
    String _amount = record.foodList[2];
    String _carbs = record.foodList[3].replaceAll(' ', '');
    String _totalCarbs = record.totalCarbs.toString();

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          contentPadding: EdgeInsets.all(12),
          title: Text(
              DateFormat('dd/MM/yyyy, kk:mm').format(record.timestamp)
                  + ' (' + record.type + ')'
          ),
          subtitle: Text(
              _product + ' — ' + _amount + _units + '\n' +
              _totalCarbs + ' вуглеводів (' + _carbs + ' у 100' + _units + ')'
          ),
        ),
      ),
    );
  }
}

