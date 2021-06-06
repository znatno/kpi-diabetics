import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:flutter_diabetics/models/food_record.dart';
import 'package:flutter_diabetics/services/database.dart';
import 'package:provider/provider.dart';
import 'food_list.dart';

class ShowFoodRecords extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    return StreamProvider<List<FoodRecord>>.value(
      value: DatabaseService(uid: user.uid).foodRecords,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Список спожитої їжі'),
          brightness: Brightness.dark,
          elevation: 0,
        ),
        body: Container(
            child: FoodList()
        ),
      ),
    );
  }
}
