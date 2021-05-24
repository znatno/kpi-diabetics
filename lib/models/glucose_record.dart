class GlucoseRecord {

  final DateTime dateTime;  // дата і час створення запису
  final String recordType;  // сніданок, обід, вечеря тощо
  final String units;       // ммоль/л чи інші
  final String amount;      // кількість одиниць
  final bool normality;     // замір знаходиться в межах допустимого
  final String recommend;   // запис рекомендації додатку

  GlucoseRecord({ this.dateTime, this.recordType, this.units, this.amount,
                  this.normality, this.recommend });

}