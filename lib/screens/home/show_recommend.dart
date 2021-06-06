import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:flutter_diabetics/models/food_record.dart';
import 'package:flutter_diabetics/services/database.dart';
import 'package:flutter_diabetics/shared/constants.dart';
import 'package:flutter_diabetics/shared/loading.dart';
import 'package:provider/provider.dart';

class ShowRecommend extends StatefulWidget {
  final FoodRecord record;
  ShowRecommend({ this.record });

  @override
  _ShowRecommendState createState() => _ShowRecommendState();
}
class _ShowRecommendState extends State<ShowRecommend> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);
    double _recommendedDose;
    double _glucoseCoefficient;

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {

          UserData userData = snapshot.data;

          // обчислення рекомендованої дози
          _glucoseCoefficient = num.tryParse(userData.glucoseCoefficient)?.toDouble() ?? 1.0;
          _recommendedDose = double.parse(
              (widget.record.totalCarbs / (12 * _glucoseCoefficient)).toStringAsFixed(2)
          );

          print("recommended $_recommendedDose");
          return Scaffold(
            appBar: AppBar(
              title: Text('Рекомендація'),
              backgroundColor: Colors.blue[400],
              brightness: Brightness.dark,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 28,),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Text(
                    "Вам рекомендовано: ввести $_recommendedDose одиниці Новорапід Флекспен",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, height: 1.25),
                  ),
                  SizedBox(height: 32,),
                  ElevatedButton(
                    onPressed: () async {

                      FoodRecord _record = FoodRecord(
                        timestamp: widget.record.timestamp,
                        type: widget.record.type,
                        foodList: widget.record.foodList,
                        totalCarbs: widget.record.totalCarbs,
                        recommendedDose: _recommendedDose,
                      );

                      // збереження в БД
                      await DatabaseService(uid: user.uid).updateFoodRecord(_record);

                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    style: ElevatedButton.styleFrom(primary: colorMainAccent,),
                    child: Text(
                        'Зберегти та Продовжити',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Loading();
        }
      }
    );
  }

}