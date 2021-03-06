import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/app_user.dart';
import 'package:flutter_diabetics/models/glucose_record.dart';
import 'package:flutter_diabetics/services/database.dart';
import 'package:provider/provider.dart';
import 'glucose_list.dart';

class ShowGlucoseRecords extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<AppUser>(context);

    return StreamProvider<List<GlucoseRecord>>.value(
      value: DatabaseService(uid: user.uid).glucoseRecords,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Заміри цукру крові'),
          brightness: Brightness.dark,
          elevation: 0,
        ),
        body: Container(
            child: GlucoseList()
        ),
      ),
    );
  }
}
