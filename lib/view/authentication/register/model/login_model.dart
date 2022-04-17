class LoginModel {
  final String name;
  final String surname;
  final String age;
  final String universityName;
  final String department;
  final String universityDepartment;
  final String departurePlace;
  final String destination;
  final String departureTime;
  final String estimatedTravelTime;
  final String estimatedFee;

  LoginModel(
      this.name,
      this.surname,
      this.age,
      this.universityName,
      this.department,
      this.universityDepartment,
      this.departurePlace,
      this.destination,
      this.departureTime,
      this.estimatedTravelTime,
      this.estimatedFee);

  static List<LoginModel> get mockUsers {
    return [
      LoginModel(
          "lebron",
          "james",
          "20",
          "koç üniversitesi",
          "hukuk",
          "lebron@ku.edu.tr",
          "koç üniversitesi batı kampüsü",
          "zincirlikuyu metrobüs",
          "19.00",
          "28",
          "26"),
      LoginModel(
          "kevin",
          "durant",
          "19",
          "boğaziçi üniversitesi",
          "endüstri mühendisliği",
          "kevin@boun.edu.tr",
          "boğaziçi üniversitesi kuzey kampüsü",
          "beşiktaş vapur iskelesi",
          "18.00",
          "26",
          "10"),
      LoginModel(
          "micheal",
          "hordan",
          "23",
          "sabancı üniversitesi",
          "ekonomi",
          "micheal@sabanciuni..edu.tr",
          "sabancı üniversitesi tuzla",
          "kadıköy vapur iskelesi",
          "20.30",
          "45",
          "55"),
      LoginModel(
          "stephen",
          "curry",
          "20",
          "yeditepe üniversitesi",
          "diş hekimliği",
          "stephen@yeditepe.edu.tr",
          "yeditepe üniversitesi kayışdağı",
          "altunizade metrobüs",
          "21.00",
          "19",
          "22"),
      LoginModel(
          "kyrie",
          "irving",
          "19",
          "özyeğin üniversitesi",
          "psikoloji",
          "kyrie@ozyegin.edu.tr",
          "özyeğin üniversitesi nişantepe",
          "ülker sports arena",
          "18.30",
          "29",
          "37"),
    ];
  }
}
