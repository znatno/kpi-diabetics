import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/food_record.dart';
import 'package:intl/intl.dart';

class FoodTile extends StatelessWidget {

  final FoodRecord record;
  FoodTile({ this.record });

  @override
  Widget build(BuildContext context) {

    print(record.id);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(
              DateFormat('dd/MM/yyyy, kk:mm').format(record.timestamp)
                  + ' (' + record.type + ')'
          ),
          subtitle: Text(
              ''
          ),
        ),
      ),
    );
  }
}

