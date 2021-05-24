class FoodIntake {

  final String name;
  final String units;       // грами, мл тощо
  final double amount;      // к-сть грам/мл
  final double carbs;       // к-сть вуглеводів на 100 од.
  final double intakeCarbs; // amount * carbs

  FoodIntake({ this.name, this.units, this.amount,
                this.carbs, this.intakeCarbs });

}

class FoodRecord {

  final DateTime dateTime;          // дата і час створення запису
  final String mealType;            // сніданок, обід, вечеря тощо
  final List<FoodIntake> foodList;  // список спожитих продуктів
  final double totalCarbs;          // сума усіх totalCarbs зі списку
  final double recommendedDose;     // рекомендована додатком доза

  FoodRecord({ this.dateTime, this.mealType, this.foodList,
                this.totalCarbs, this.recommendedDose });

}