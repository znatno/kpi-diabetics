import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/food_record.dart';
import 'package:flutter_diabetics/models/glucose_record.dart';
import 'package:flutter_diabetics/services/database.dart';
import 'package:flutter_diabetics/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_diabetics/models/brew.dart';
import 'package:flutter_diabetics/screens/home/brew_tile.dart';

class ShowRecommend extends StatelessWidget {

  final FoodRecord record;
  ShowRecommend({ this.record });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Diabetics App'),
        backgroundColor: Colors.blue[400],
        elevation: 0,
        ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Вам рекомендовано:"),
            Text(record.recommendedDose.toString()),
            RaisedButton(
              onPressed: () async {

                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              color: colorMainAccent,
              child: Text(
                  'Продовжити',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

}