class CompanyDTO {
  Angebotskontakt? angebotskontakt;
  String? agBewerbungUrl;
  String? jbEncryptedId;
  List<String>? bewerbungsarten;
  String? geforderteAnlagen;

  CompanyDTO(
      {this.angebotskontakt,
        this.agBewerbungUrl,
        this.jbEncryptedId,
        this.bewerbungsarten,
        this.geforderteAnlagen});

  CompanyDTO.fromJson(Map<String, dynamic> json) {
    angebotskontakt = json['angebotskontakt'] != null
        ? new Angebotskontakt.fromJson(json['angebotskontakt'])
        : null;
    agBewerbungUrl = json['agBewerbungUrl'];
    jbEncryptedId = json['jbEncryptedId'];
    bewerbungsarten = json['bewerbungsarten'].cast<String>();
    geforderteAnlagen = json['geforderteAnlagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.angebotskontakt != null) {
      data['angebotskontakt'] = this.angebotskontakt!.toJson();
    }
    data['agBewerbungUrl'] = this.agBewerbungUrl;
    data['jbEncryptedId'] = this.jbEncryptedId;
    data['bewerbungsarten'] = this.bewerbungsarten;
    data['geforderteAnlagen'] = this.geforderteAnlagen;
    return data;
  }
}

class Angebotskontakt {
  String? anrede;
  String? nachname;
  String? vorname;
  String? strasse;
  String? ort;
  String? plz;
  String? region;
  String? land;
  String? email;
  String? firma;
  Festnetznummer? festnetznummer;

  Angebotskontakt(
      {this.anrede,
        this.nachname,
        this.vorname,
        this.strasse,
        this.ort,
        this.plz,
        this.region,
        this.land,
        this.email,
        this.firma,
        this.festnetznummer});

  Angebotskontakt.fromJson(Map<String, dynamic> json) {
    anrede = json['anrede'];
    nachname = json['nachname'];
    vorname = json['vorname'];
    strasse = json['strasse'];
    ort = json['ort'];
    plz = json['plz'];
    region = json['region'];
    land = json['land'];
    email = json['email'];
    firma = json['firma'];
    festnetznummer = json['festnetznummer'] != null
        ? new Festnetznummer.fromJson(json['festnetznummer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anrede'] = this.anrede;
    data['nachname'] = this.nachname;
    data['vorname'] = this.vorname;
    data['strasse'] = this.strasse;
    data['ort'] = this.ort;
    data['plz'] = this.plz;
    data['region'] = this.region;
    data['land'] = this.land;
    data['email'] = this.email;
    data['firma'] = this.firma;
    if (this.festnetznummer != null) {
      data['festnetznummer'] = this.festnetznummer!.toJson();
    }
    return data;
  }
}

class Festnetznummer {
  String? laendervorwahl;
  String? vorwahl;
  String? rufnummer;

  Festnetznummer({this.laendervorwahl, this.vorwahl, this.rufnummer});

  Festnetznummer.fromJson(Map<String, dynamic> json) {
    laendervorwahl = json['laendervorwahl'];
    vorwahl = json['vorwahl'];
    rufnummer = json['rufnummer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['laendervorwahl'] = this.laendervorwahl;
    data['vorwahl'] = this.vorwahl;
    data['rufnummer'] = this.rufnummer;
    return data;
  }
}

