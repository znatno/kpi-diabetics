import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_diabetics/models/glucose_record.dart';
import 'package:flutter_diabetics/screens/home/glucose_tile.dart';

class GlucoseList extends StatefulWidget {
  @override
  _GlucoseListState createState() => _GlucoseListState();
}

class _GlucoseListState extends State<GlucoseList> {
  @override
  Widget build(BuildContext context) {

    final records = Provider.of<List<GlucoseRecord>>(context) ?? [];

    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        return GlucoseTile(record: records[index],);
      },
    );
  }
}