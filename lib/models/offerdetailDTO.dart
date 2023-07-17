import 'package:flutter/cupertino.dart';

class OfferDetailDto {
  String? aktuelleVeroeffentlichungsdatum;
  List<String>? alternativBerufe;
  String? angebotsart;
  String? arbeitgeber;
  String? branchengruppe;
  String? branche;
  String? arbeitgeberHashId;
  List<Arbeitsorte>? arbeitsorte;
  String? befristung;
  bool? uebernahme;
  String? betriebsgroesse;
  String? eintrittsdatum;
  String? ersteVeroeffentlichungsdatum;
  String? allianzpartner;
  String? allianzpartnerUrl;
  String? titel;
  String? hashId;
  String? beruf;
  String? modifikationsTimestamp;
  String? stellenbeschreibung;
  String? refnr;
  bool? fuerFluechtlingeGeeignet;
  bool? nurFuerSchwerbehinderte;
  int? anzahlOffeneStellen;
  ArbeitgeberAdresse? arbeitgeberAdresse;
  Mobilitaet? mobilitaet;
  Fuehrungskompetenzen? fuehrungskompetenzen;
  String? arbeitgeberdarstellungUrl;
  String? hauptDkz;
  List<String>? alternativDkzs;
  bool? istBetreut;
  bool? istGoogleJobsRelevant;
  bool? anzeigeAnonym;
  List<String>? arbeitszeitmodelle;
  bool? _isFavorite = false;

  bool get isFavorite => _isFavorite!;

  set isFavorite(bool value) {
    _isFavorite = value;
  }
  OfferDetailDto(
      {this.aktuelleVeroeffentlichungsdatum,
        this.alternativBerufe,
        this.angebotsart,
        this.arbeitgeber,
        this.branchengruppe,
        this.branche,
        this.arbeitgeberHashId,
        this.arbeitsorte,
        this.befristung,
        this.uebernahme,
        this.betriebsgroesse,
        this.eintrittsdatum,
        this.ersteVeroeffentlichungsdatum,
        this.allianzpartner,
        this.allianzpartnerUrl,
        this.titel,
        this.hashId,
        this.beruf,
        this.modifikationsTimestamp,
        this.stellenbeschreibung,
        this.refnr,
        this.fuerFluechtlingeGeeignet,
        this.nurFuerSchwerbehinderte,
        this.anzahlOffeneStellen,
        this.arbeitgeberAdresse,
        this.mobilitaet,
        this.fuehrungskompetenzen,
        this.arbeitgeberdarstellungUrl,
        this.hauptDkz,
        this.alternativDkzs,
        this.istBetreut,
        this.istGoogleJobsRelevant,
        this.anzeigeAnonym});

  OfferDetailDto.fromJson(Map<String, dynamic> json) {
    aktuelleVeroeffentlichungsdatum = json['aktuelleVeroeffentlichungsdatum'];
    angebotsart = json['angebotsart'];
    arbeitgeber = json['arbeitgeber'];
    branchengruppe = json['branchengruppe'];
    branche = json['branche'];
    arbeitgeberHashId = json['arbeitgeberHashId'];
    if (json['arbeitsorte'] != null) {
      arbeitsorte = <Arbeitsorte>[];
      json['arbeitsorte'].forEach((v) {
        arbeitsorte!.add(new Arbeitsorte.fromJson(v));
      });
    }
    befristung = json['befristung'];
    uebernahme = json['uebernahme'];
    betriebsgroesse = json['betriebsgroesse'];
    eintrittsdatum = json['eintrittsdatum'];
    ersteVeroeffentlichungsdatum = json['ersteVeroeffentlichungsdatum'];
    allianzpartner = json['allianzpartner'];
    allianzpartnerUrl = json['allianzpartnerUrl'];
    titel = json['titel']?? '';
    hashId = json['hashId'];
    beruf = json['beruf']?? '';
    modifikationsTimestamp = json['modifikationsTimestamp'];
    stellenbeschreibung = json['stellenbeschreibung'];
    refnr = json['refnr'];
    fuerFluechtlingeGeeignet = json['fuerFluechtlingeGeeignet'];
    nurFuerSchwerbehinderte = json['nurFuerSchwerbehinderte'];
    anzahlOffeneStellen = json['anzahlOffeneStellen'];
    arbeitgeberAdresse = json['arbeitgeberAdresse'] != null
        ? new ArbeitgeberAdresse.fromJson(json['arbeitgeberAdresse'])
        : null;
    fuehrungskompetenzen = json['fuehrungskompetenzen'] != null
        ? new Fuehrungskompetenzen.fromJson(json['fuehrungskompetenzen'])
        : null;
    arbeitgeberdarstellungUrl = json['arbeitgeberdarstellungUrl'];
    hauptDkz = json['hauptDkz'];
    istBetreut = json['istBetreut'];
    istGoogleJobsRelevant = json['istGoogleJobsRelevant'];
    anzeigeAnonym = json['anzeigeAnonym'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aktuelleVeroeffentlichungsdatum'] =
        this.aktuelleVeroeffentlichungsdatum;
    data['alternativBerufe'] = this.alternativBerufe;
    data['angebotsart'] = this.angebotsart;
    data['arbeitgeber'] = this.arbeitgeber;
    data['branchengruppe'] = this.branchengruppe;
    data['branche'] = this.branche;
    data['arbeitgeberHashId'] = this.arbeitgeberHashId;
    if (this.arbeitsorte != null) {
      data['arbeitsorte'] = this.arbeitsorte!.map((v) => v.toJson()).toList();
    }
    data['befristung'] = this.befristung;
    data['uebernahme'] = this.uebernahme;
    data['betriebsgroesse'] = this.betriebsgroesse;
    data['eintrittsdatum'] = this.eintrittsdatum;
    data['ersteVeroeffentlichungsdatum'] = this.ersteVeroeffentlichungsdatum;
    data['allianzpartner'] = this.allianzpartner;
    data['allianzpartnerUrl'] = this.allianzpartnerUrl;
    data['titel'] = this.titel;
    data['hashId'] = this.hashId;
    data['beruf'] = this.beruf;
    data['modifikationsTimestamp'] = this.modifikationsTimestamp;
    data['stellenbeschreibung'] = this.stellenbeschreibung;
    data['refnr'] = this.refnr;
    data['fuerFluechtlingeGeeignet'] = this.fuerFluechtlingeGeeignet;
    data['nurFuerSchwerbehinderte'] = this.nurFuerSchwerbehinderte;
    data['anzahlOffeneStellen'] = this.anzahlOffeneStellen;
    if (this.arbeitgeberAdresse != null) {
      data['arbeitgeberAdresse'] = this.arbeitgeberAdresse!.toJson();
    }
    if (this.mobilitaet != null) {
      data['mobilitaet'] = this.mobilitaet!.toJson();
    }
    if (this.fuehrungskompetenzen != null) {
      data['fuehrungskompetenzen'] = this.fuehrungskompetenzen!.toJson();
    }
    data['arbeitgeberdarstellungUrl'] = this.arbeitgeberdarstellungUrl;
    data['hauptDkz'] = this.hauptDkz;
    data['alternativDkzs'] = this.alternativDkzs;
    data['istBetreut'] = this.istBetreut;
    data['istGoogleJobsRelevant'] = this.istGoogleJobsRelevant;
    data['anzeigeAnonym'] = this.anzeigeAnonym;
    data['arbeitszeitmodelle'] = arbeitszeitmodelle;

    return data;
  }
}

class Arbeitsorte {
  String? land;
  String? region;
  String? ort;
  Koordinaten? koordinaten;
  String? plz;
  String? strasse;

  Arbeitsorte({this.land, this.region, this.ort, this.koordinaten, this.plz});

  Arbeitsorte.fromJson(Map<String, dynamic> json) {
    land = json['land'];
    region = json['region'];
    ort = json['ort'];
    koordinaten = json['koordinaten'] != null
        ? new Koordinaten.fromJson(json['koordinaten'])
        : null;
    plz = json['plz'];
    strasse = json['strasse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['land'] = this.land;
    data['region'] = this.region;
    data['ort'] = this.ort;
    if (this.koordinaten != null) {
      data['koordinaten'] = this.koordinaten!.toJson();
    }
    data['plz'] = this.plz;
    data['strasse'] = this.strasse;
    return data;
  }

  bool containsNull() => [plz, ort, strasse, koordinaten?.lat, koordinaten?.lon].contains(null);

  String? fullAddressToString() =>
      containsNull()
          ? null
          : '$strasse, $plz $ort';
}

class Koordinaten {
  double? lat;
  double? lon;

  Koordinaten({this.lat, this.lon});

  Koordinaten.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class ArbeitgeberAdresse {
  String? land;
  String? region;
  String? plz;
  String? ort;
  String? strasse;

  ArbeitgeberAdresse(
      {this.land, this.region, this.plz, this.ort, this.strasse});

  ArbeitgeberAdresse.fromJson(Map<String, dynamic> json) {
    land = json['land'];
    region = json['region'];
    plz = json['plz'];
    ort = json['ort'];
    strasse = json['strasse'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['land'] = this.land;
    data['region'] = this.region;
    data['plz'] = this.plz;
    data['ort'] = this.ort;
    data['strasse'] = this.strasse;
    return data;
  }
}

class Mobilitaet {
  bool? fahrzeugErforderlich;

  Mobilitaet({this.fahrzeugErforderlich});

  Mobilitaet.fromJson(Map<String, dynamic> json) {
    fahrzeugErforderlich = json['fahrzeugErforderlich'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fahrzeugErforderlich'] = this.fahrzeugErforderlich;
    return data;
  }
}

class Fuehrungskompetenzen {
  bool? hatVollmacht;
  bool? hatBudgetverantwortung;

  Fuehrungskompetenzen({this.hatVollmacht, this.hatBudgetverantwortung});

  Fuehrungskompetenzen.fromJson(Map<String, dynamic> json) {
    hatVollmacht = json['hatVollmacht'];
    hatBudgetverantwortung = json['hatBudgetverantwortung'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hatVollmacht'] = this.hatVollmacht;
    data['hatBudgetverantwortung'] = this.hatBudgetverantwortung;
    return data;
  }
}

