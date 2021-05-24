class GlucoseRecord {

  final String id;
  final DateTime timestamp;  // дата і час створення запису
  final String type;  // сніданок, обід, вечеря тощо
  final String units;       // ммоль/л чи інші
  final double amount;      // кількість одиниць
  final bool normality;     // замір знаходиться в межах допустимого
  final String recommend;   // запис рекомендації додатку

  GlucoseRecord({ this.id, this.timestamp, this.type, this.units,
                  this.amount, this.normality, this.recommend });

  Map<String, dynamic> toMap() {
    return {
      "timestamp": timestamp,
      "type": type,
      "units": units,
      "amount": amount,
      "normality": normality,
      "recommend": recommend,
    };
  }

}