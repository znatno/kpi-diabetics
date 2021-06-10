import 'package:flutter/material.dart';
import 'package:flutter_diabetics/models/glucose_record.dart';
import 'package:intl/intl.dart';
import 'edit_glucose_record.dart';

class GlucoseTile extends StatelessWidget {

  final GlucoseRecord record;
  GlucoseTile({ this.record });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(

        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(
            // record.id
              DateFormat('dd/MM/yyyy, kk:mm').format(record.timestamp)
                  + ' (' + record.type + ')'
          ),
          subtitle: Text(
              (record.normality?"У нормі":"Не в нормі") + ' — '
              + record.amount.toString() + ' ' + record.units
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
                              EditGlucoseRecordForm(
                                record: record,
                              ),
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

