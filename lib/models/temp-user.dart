class TempUser {
  final String Email;
  final String IBAN;
  final String PhoneNumber;
  final String FirstName;
  final String LastName;
  final String Address;
  final String City;
  final String PostalCode;
  final String Country;
  final String Password;
  final int AmountLimit;
  final String AppLanguage;
  final String TimeZoneId;

  TempUser(
      {required this.Email,
      required this.IBAN,
      required this.PhoneNumber,
      required this.FirstName,
      required this.LastName,
      required this.Address,
      required this.City,
      required this.PostalCode,
      required this.Country,
      required this.Password,
      required this.AmountLimit,
      required this.AppLanguage,
      required this.TimeZoneId});

  factory TempUser.fromJson(Map<String, dynamic> json) {
    return TempUser(
      Email: json['Email'],
      IBAN: json['IBAN'],
      PhoneNumber: json['PhoneNumber'],
      FirstName: json['FirstName'],
      LastName: json['LastName'],
      Address: json['Address'],
      City: json['City'],
      PostalCode: json['PostalCode'],
      Country: json['Country'],
      Password: json['Password'],
      AmountLimit: json['AmountLimit'],
      AppLanguage: json['AppLanguage'],
      TimeZoneId: json['TimeZoneId'],
    );
  }
}
