class AppUser {

  final String uid;

  AppUser ({ this.uid });

}

class UserData {

  final String uid;
  final String name;
  final bool   startShown;
  final String defaultGlucoseUnit;
  final String defaultMealUnit;
  final String glucoseCoefficient;

  UserData({ this.uid, this.name, this.startShown, this.defaultGlucoseUnit,
              this.defaultMealUnit, this.glucoseCoefficient });

}