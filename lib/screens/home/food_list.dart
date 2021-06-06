import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_diabetics/models/food_record.dart';
import 'package:flutter_diabetics/screens/home/food_tile.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {

    final records = Provider.of<List<FoodRecord>>(context) ?? [];

    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        return FoodTile(record: records[index],);
      },
    );
  }
}