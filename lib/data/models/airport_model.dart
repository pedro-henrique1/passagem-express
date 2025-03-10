class Airport {
  final String iata;
  final String name;
  final String country;
  final String countryCode;
  final String region;
  final String regionCode;
  final String continent;
  final String location;
  final String? subLocation;
  final String? timeZone;
  final List<String> airports;

  Airport({
    required this.iata,
    required this.name,
    required this.country,
    required this.countryCode,
    required this.region,
    required this.regionCode,
    required this.continent,
    required this.location,
    this.subLocation,
    this.timeZone,
    required this.airports,
  });

  factory Airport.fromJson(Map<String, dynamic> json) {
    return Airport(
      iata: json['Iata'] ?? '',
      name: json['Nome'] ?? '',
      country: json['Pais'] ?? '',
      countryCode: json['PaisCodigo'] ?? '',
      region: json['Regiao'] ?? '',
      regionCode: json['RegiaoCodigo'] ?? '',
      continent: json['Continente'] ?? '',
      location: json['Local'] ?? '',
      subLocation: json['SubLocal'],
      timeZone: json['FusoHorario'],
      airports:
          json['Aeroportos'] != null
              ? List<String>.from(json['Aeroportos'])
              : [],
    );
  }
}
