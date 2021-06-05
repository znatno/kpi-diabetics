class FoodIntake {

  final String name;        // назва їжі
  final String units;       // грами, мл тощо
  final double amount;      // к-сть грам/мл
  final double carbs;       // к-сть вуглеводів на 100 од.
  final double intakeCarbs; // amount * carbs

  FoodIntake({ this.name, this.units, this.amount,
                this.carbs, this.intakeCarbs });

}

class FoodRecord {

  final String id;
  final DateTime timestamp;         // дата і час створення запису
  final String type;                // сніданок, обід, вечеря тощо
  final List<dynamic> foodList;  // список спожитих продуктів
  final double totalCarbs;          // сума усіх totalCarbs зі списку
  final double recommendedDose;     // рекомендована додатком доза

  FoodRecord({ this.id, this.timestamp, this.type, this.foodList,
                this.totalCarbs, this.recommendedDose });

  Map<String, dynamic> toMap() {
    return {
      "timestamp": timestamp,
      "type": type,
      // "foodList": foodList,
      "totalCarbs": totalCarbs,
      "recommendedDose": recommendedDose,
    };
  }

}