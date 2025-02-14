class Country {
  final Name name;
  final List<String> tld;
  final String cca2;
  final String ccn3;
  final String cca3;
  final bool independent;
  final String status;
  final bool unMember;
  final Map<String, Currency> currencies;
  final Idd idd;
  final List<String> capital;
  final List<String> altSpellings;
  final String region;
  final Map<String, String> languages;
  final Map<String, Translation> translations;
  final List<double> latlng;
  final bool landlocked;
  final double area;
  final Map<String, Demonym> demonyms;
  final String flag;
  final Maps maps;
  final int population;
  final Car car;
  final List<String> timezones;
  final List<String> continents;
  final Flags flags;
  final CoatOfArms coatOfArms;
  final String startOfWeek;
  final CapitalInfo capitalInfo;

  Country({
    required this.name,
    required this.tld,
    required this.cca2,
    required this.ccn3,
    required this.cca3,
    required this.independent,
    required this.status,
    required this.unMember,
    required this.currencies,
    required this.idd,
    required this.capital,
    required this.altSpellings,
    required this.region,
    required this.languages,
    required this.translations,
    required this.latlng,
    required this.landlocked,
    required this.area,
    required this.demonyms,
    required this.flag,
    required this.maps,
    required this.population,
    required this.car,
    required this.timezones,
    required this.continents,
    required this.flags,
    required this.coatOfArms,
    required this.startOfWeek,
    required this.capitalInfo,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: Name.fromJson(json['name']),
      tld: List<String>.from(json['tld'] ?? []),
      cca2: json['cca2'] ?? '',
      ccn3: json['ccn3'] ?? '',
      cca3: json['cca3'] ?? '',
      independent: json['independent'] ?? false,
      status: json['status'] ?? '',
      unMember: json['unMember'] ?? false,
      currencies: (json['currencies'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, Currency.fromJson(value)),
          ) ??
          {},
      idd: Idd.fromJson(json['idd'] ?? {}),
      capital: List<String>.from(json['capital'] ?? []),
      altSpellings: List<String>.from(json['altSpellings'] ?? []),
      region: json['region'] ?? '',
      languages: Map<String, String>.from(json['languages'] ?? {}),
      translations: (json['translations'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, Translation.fromJson(value)),
          ) ??
          {},
      latlng: List<double>.from(json['latlng'] ?? []),
      landlocked: json['landlocked'] ?? false,
      area: (json['area'] ?? 0).toDouble(),
      demonyms: (json['demonyms'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, Demonym.fromJson(value)),
          ) ??
          {},
      flag: json['flag'] ?? '',
      maps: Maps.fromJson(json['maps'] ?? {}),
      population: json['population'] ?? 0,
      car: Car.fromJson(json['car'] ?? {}),
      timezones: List<String>.from(json['timezones'] ?? []),
      continents: List<String>.from(json['continents'] ?? []),
      flags: Flags.fromJson(json['flags'] ?? {}),
      coatOfArms: CoatOfArms.fromJson(json['coatOfArms'] ?? {}),
      startOfWeek: json['startOfWeek'] ?? '',
      capitalInfo: CapitalInfo.fromJson(json['capitalInfo'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name.toJson(),
      'tld': tld,
      'cca2': cca2,
      'ccn3': ccn3,
      'cca3': cca3,
      'independent': independent,
      'status': status,
      'unMember': unMember,
      'currencies':
          currencies.map((key, value) => MapEntry(key, value.toJson())),
      'idd': idd.toJson(),
      'capital': capital,
      'altSpellings': altSpellings,
      'region': region,
      'languages': languages,
      'translations':
          translations.map((key, value) => MapEntry(key, value.toJson())),
      'latlng': latlng,
      'landlocked': landlocked,
      'area': area,
      'demonyms': demonyms.map((key, value) => MapEntry(key, value.toJson())),
      'flag': flag,
      'maps': maps.toJson(),
      'population': population,
      'car': car.toJson(),
      'timezones': timezones,
      'continents': continents,
      'flags': flags.toJson(),
      'coatOfArms': coatOfArms.toJson(),
      'startOfWeek': startOfWeek,
      'capitalInfo': capitalInfo.toJson(),
    };
  }
}

class Name {
  final String common;
  final String official;
  final Map<String, NativeName> nativeName;

  Name({
    required this.common,
    required this.official,
    required this.nativeName,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      common: json['common'] ?? '',
      official: json['official'] ?? '',
      nativeName: (json['nativeName'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, NativeName.fromJson(value)),
          ) ??
          {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'common': common,
      'official': official,
      'nativeName':
          nativeName.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class NativeName {
  final String official;
  final String common;

  NativeName({
    required this.official,
    required this.common,
  });

  factory NativeName.fromJson(Map<String, dynamic> json) {
    return NativeName(
      official: json['official'] ?? '',
      common: json['common'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'official': official,
      'common': common,
    };
  }
}

class Currency {
  final String name;
  final String symbol;

  Currency({
    required this.name,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'symbol': symbol,
    };
  }
}

class Idd {
  final String root;
  final List<String> suffixes;

  Idd({
    required this.root,
    required this.suffixes,
  });

  factory Idd.fromJson(Map<String, dynamic> json) {
    return Idd(
      root: json['root'] ?? '',
      suffixes: List<String>.from(json['suffixes'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'root': root,
      'suffixes': suffixes,
    };
  }
}

class Translation {
  final String official;
  final String common;

  Translation({
    required this.official,
    required this.common,
  });

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      official: json['official'] ?? '',
      common: json['common'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'official': official,
      'common': common,
    };
  }
}

class Demonym {
  final String f;
  final String m;

  Demonym({
    required this.f,
    required this.m,
  });

  factory Demonym.fromJson(Map<String, dynamic> json) {
    return Demonym(
      f: json['f'] ?? '',
      m: json['m'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'f': f,
      'm': m,
    };
  }
}

class Maps {
  final String googleMaps;
  final String openStreetMaps;

  Maps({
    required this.googleMaps,
    required this.openStreetMaps,
  });

  factory Maps.fromJson(Map<String, dynamic> json) {
    return Maps(
      googleMaps: json['googleMaps'] ?? '',
      openStreetMaps: json['openStreetMaps'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'googleMaps': googleMaps,
      'openStreetMaps': openStreetMaps,
    };
  }
}

class Car {
  final List<String> signs;
  final String side;

  Car({
    required this.signs,
    required this.side,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      signs: List<String>.from(json['signs'] ?? []),
      side: json['side'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'signs': signs,
      'side': side,
    };
  }
}

class Flags {
  final String png;
  final String svg;
  final String? alt;

  Flags({
    required this.png,
    required this.svg,
    this.alt,
  });

  factory Flags.fromJson(Map<String, dynamic> json) {
    return Flags(
      png: json['png'] ?? '',
      svg: json['svg'] ?? '',
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'png': png,
      'svg': svg,
      if (alt != null) 'alt': alt,
    };
  }
}

class CoatOfArms {
  final String? png;
  final String? svg;

  CoatOfArms({
    this.png,
    this.svg,
  });

  factory CoatOfArms.fromJson(Map<String, dynamic> json) {
    return CoatOfArms(
      png: json['png'],
      svg: json['svg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (png != null) 'png': png,
      if (svg != null) 'svg': svg,
    };
  }
}

class CapitalInfo {
  final List<double> latlng;

  CapitalInfo({
    required this.latlng,
  });

  factory CapitalInfo.fromJson(Map<String, dynamic> json) {
    return CapitalInfo(
      latlng: List<double>.from(json['latlng'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latlng': latlng,
    };
  }
}
