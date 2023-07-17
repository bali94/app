// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Registrieren`
  String get register {
    return Intl.message(
      'Registrieren',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `A N M E L D E N`
  String get login {
    return Intl.message(
      'A N M E L D E N',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Abmelden`
  String get logout {
    return Intl.message(
      'Abmelden',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Passwort`
  String get password {
    return Intl.message(
      'Passwort',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Empfehlungen`
  String get featured {
    return Intl.message(
      'Empfehlungen',
      name: 'featured',
      desc: '',
      args: [],
    );
  }

  /// `Startseite`
  String get home {
    return Intl.message(
      'Startseite',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Profil`
  String get profile {
    return Intl.message(
      'Profil',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Karte`
  String get map {
    return Intl.message(
      'Karte',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Entdecke deine Zukunft`
  String get yourFuture {
    return Intl.message(
      'Entdecke deine Zukunft',
      name: 'yourFuture',
      desc: '',
      args: [],
    );
  }

  /// `Einstellungen`
  String get settings {
    return Intl.message(
      'Einstellungen',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Zu Unternehmen`
  String get toCompanies {
    return Intl.message(
      'Zu Unternehmen',
      name: 'toCompanies',
      desc: '',
      args: [],
    );
  }

  /// `Bewerbung`
  String get emailApply {
    return Intl.message(
      'Bewerbung',
      name: 'emailApply',
      desc: '',
      args: [],
    );
  }

  /// `Du hast noch keine Stellen gespeichert. Schaue dich doch Mal bei deinen Empfehlungen um`
  String get noDataSaved {
    return Intl.message(
      'Du hast noch keine Stellen gespeichert. Schaue dich doch Mal bei deinen Empfehlungen um',
      name: 'noDataSaved',
      desc: '',
      args: [],
    );
  }

  /// `Dateschutzbestimmungen`
  String get dataProtection {
    return Intl.message(
      'Dateschutzbestimmungen',
      name: 'dataProtection',
      desc: '',
      args: [],
    );
  }

  /// `Bestätige bitte zunächst unsere Datenschutzbestimmungen`
  String get acceptDataProtection {
    return Intl.message(
      'Bestätige bitte zunächst unsere Datenschutzbestimmungen',
      name: 'acceptDataProtection',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Telefonnummer`
  String get number {
    return Intl.message(
      'Telefonnummer',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `Betreff`
  String get regarding {
    return Intl.message(
      'Betreff',
      name: 'regarding',
      desc: '',
      args: [],
    );
  }

  /// `Mitteilung`
  String get message {
    return Intl.message(
      'Mitteilung',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Absenden`
  String get send {
    return Intl.message(
      'Absenden',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Liste`
  String get list {
    return Intl.message(
      'Liste',
      name: 'list',
      desc: '',
      args: [],
    );
  }

  /// `Sie haben sich nicht eingeloggt`
  String get loginNotify {
    return Intl.message(
      'Sie haben sich nicht eingeloggt',
      name: 'loginNotify',
      desc: '',
      args: [],
    );
  }

  /// `Neue Stellenangebote`
  String get newJobs {
    return Intl.message(
      'Neue Stellenangebote',
      name: 'newJobs',
      desc: '',
      args: [],
    );
  }

  /// `Geben Sie bitte die Zeichen ein`
  String get captcha {
    return Intl.message(
      'Geben Sie bitte die Zeichen ein',
      name: 'captcha',
      desc: '',
      args: [],
    );
  }

  /// `Bewerben Sie sich über die Webseite`
  String get applyWebsite {
    return Intl.message(
      'Bewerben Sie sich über die Webseite',
      name: 'applyWebsite',
      desc: '',
      args: [],
    );
  }

  /// `Beruf, Stichwort, ...`
  String get job {
    return Intl.message(
      'Beruf, Stichwort, ...',
      name: 'job',
      desc: '',
      args: [],
    );
  }

  /// `keine Ergebnisse gefunden`
  String get noResults {
    return Intl.message(
      'keine Ergebnisse gefunden',
      name: 'noResults',
      desc: '',
      args: [],
    );
  }

  /// `Sortieren nach`
  String get sort {
    return Intl.message(
      'Sortieren nach',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Nach Eintrittsdatum`
  String get entryDate {
    return Intl.message(
      'Nach Eintrittsdatum',
      name: 'entryDate',
      desc: '',
      args: [],
    );
  }

  /// `Nach Betriebsgröße`
  String get companySize {
    return Intl.message(
      'Nach Betriebsgröße',
      name: 'companySize',
      desc: '',
      args: [],
    );
  }

  /// `Nach Arbeitgeber`
  String get employer {
    return Intl.message(
      'Nach Arbeitgeber',
      name: 'employer',
      desc: '',
      args: [],
    );
  }

  /// `Nach Veroeffentlichungsdatum`
  String get publication {
    return Intl.message(
      'Nach Veroeffentlichungsdatum',
      name: 'publication',
      desc: '',
      args: [],
    );
  }

  /// `Dein Standort`
  String get location {
    return Intl.message(
      'Dein Standort',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `Unternehmenskarte`
  String get companyMap {
    return Intl.message(
      'Unternehmenskarte',
      name: 'companyMap',
      desc: '',
      args: [],
    );
  }

  /// `Bitte geh raus`
  String get buttonExit {
    return Intl.message(
      'Bitte geh raus',
      name: 'buttonExit',
      desc: '',
      args: [],
    );
  }

  /// `Vorlage`
  String get template {
    return Intl.message(
      'Vorlage',
      name: 'template',
      desc: '',
      args: [],
    );
  }

  /// `Favoriten`
  String get favorite {
    return Intl.message(
      'Favoriten',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Registriere dich!`
  String get registerText {
    return Intl.message(
      'Registriere dich!',
      name: 'registerText',
      desc: '',
      args: [],
    );
  }

  /// `Bitte geben Sie eine Email ein`
  String get addEmail {
    return Intl.message(
      'Bitte geben Sie eine Email ein',
      name: 'addEmail',
      desc: '',
      args: [],
    );
  }

  /// `Bitte geben Sie ein Passwort ein`
  String get addPassword {
    return Intl.message(
      'Bitte geben Sie ein Passwort ein',
      name: 'addPassword',
      desc: '',
      args: [],
    );
  }

  /// `Bitte geben Sie einen Benutzernamen ein`
  String get addUsername {
    return Intl.message(
      'Bitte geben Sie einen Benutzernamen ein',
      name: 'addUsername',
      desc: '',
      args: [],
    );
  }

  /// `Melde dich an!`
  String get loginText {
    return Intl.message(
      'Melde dich an!',
      name: 'loginText',
      desc: '',
      args: [],
    );
  }

  /// `Kontakt`
  String get contact {
    return Intl.message(
      'Kontakt',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Leeres Feld`
  String get fieldEmpty {
    return Intl.message(
      'Leeres Feld',
      name: 'fieldEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Sprache`
  String get language {
    return Intl.message(
      'Sprache',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Datenschutz`
  String get privacy {
    return Intl.message(
      'Datenschutz',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Impressum`
  String get legalNotice {
    return Intl.message(
      'Impressum',
      name: 'legalNotice',
      desc: '',
      args: [],
    );
  }

  /// `Rechtliches`
  String get legal {
    return Intl.message(
      'Rechtliches',
      name: 'legal',
      desc: '',
      args: [],
    );
  }

  /// `Hinweis`
  String get notice {
    return Intl.message(
      'Hinweis',
      name: 'notice',
      desc: '',
      args: [],
    );
  }

  /// `Bitte bestätige zunächst deine E-Mail über den zugesendeten Bestätigungslink! Überprüfe dabei deinen Spam-Ordner`
  String get confirmation {
    return Intl.message(
      'Bitte bestätige zunächst deine E-Mail über den zugesendeten Bestätigungslink! Überprüfe dabei deinen Spam-Ordner',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Fehler`
  String get error {
    return Intl.message(
      'Fehler',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Neues Passwort anfordern`
  String get newPw {
    return Intl.message(
      'Neues Passwort anfordern',
      name: 'newPw',
      desc: '',
      args: [],
    );
  }

  /// ` Tippe einfach deine E-Mail ein und erhalte einen Link zum Zurücksetzen`
  String get requestResponse {
    return Intl.message(
      ' Tippe einfach deine E-Mail ein und erhalte einen Link zum Zurücksetzen',
      name: 'requestResponse',
      desc: '',
      args: [],
    );
  }

  /// `Email wiederholen`
  String get repeatMail {
    return Intl.message(
      'Email wiederholen',
      name: 'repeatMail',
      desc: '',
      args: [],
    );
  }

  /// `Zurücksetzen`
  String get reset {
    return Intl.message(
      'Zurücksetzen',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Bitte gib eine gültige Email an`
  String get validMail {
    return Intl.message(
      'Bitte gib eine gültige Email an',
      name: 'validMail',
      desc: '',
      args: [],
    );
  }

  /// `Emails stimmen nicht überein`
  String get matchingMails {
    return Intl.message(
      'Emails stimmen nicht überein',
      name: 'matchingMails',
      desc: '',
      args: [],
    );
  }

  /// `Email zum Zurücksetzen gesendet`
  String get sendMailCheck {
    return Intl.message(
      'Email zum Zurücksetzen gesendet',
      name: 'sendMailCheck',
      desc: '',
      args: [],
    );
  }

  /// `Email wurde nicht gefunden`
  String get emailNotFound {
    return Intl.message(
      'Email wurde nicht gefunden',
      name: 'emailNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Erfolg`
  String get success {
    return Intl.message(
      'Erfolg',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Du hast dich erfolgreich registriert. Bestätige nun in einem nächsten Schritt deine Email`
  String get successReg {
    return Intl.message(
      'Du hast dich erfolgreich registriert. Bestätige nun in einem nächsten Schritt deine Email',
      name: 'successReg',
      desc: '',
      args: [],
    );
  }

  /// `Keine Internetverbindung`
  String get noInternet {
    return Intl.message(
      'Keine Internetverbindung',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `Hier sind Vorschläge der Stellen mit Tinder Animation aufgelistet`
  String get simpleHomeText {
    return Intl.message(
      'Hier sind Vorschläge der Stellen mit Tinder Animation aufgelistet',
      name: 'simpleHomeText',
      desc: '',
      args: [],
    );
  }

  /// `Hier sind die Stellen in der Google-Karte aufgelistet`
  String get simpleMapText {
    return Intl.message(
      'Hier sind die Stellen in der Google-Karte aufgelistet',
      name: 'simpleMapText',
      desc: '',
      args: [],
    );
  }

  /// `Hier kann der Benutzer seine Daten sehen und ändern`
  String get simpleProfileText {
    return Intl.message(
      'Hier kann der Benutzer seine Daten sehen und ändern',
      name: 'simpleProfileText',
      desc: '',
      args: [],
    );
  }

  /// `Hier kann der Benutzer die Bewerbungsvorlagen herunterladen`
  String get simpleTemplateText {
    return Intl.message(
      'Hier kann der Benutzer die Bewerbungsvorlagen herunterladen',
      name: 'simpleTemplateText',
      desc: '',
      args: [],
    );
  }

  /// `Bitte überprüfe deine Eingaben`
  String get checkYourData {
    return Intl.message(
      'Bitte überprüfe deine Eingaben',
      name: 'checkYourData',
      desc: '',
      args: [],
    );
  }

  /// `Besitzen Sie bereits ein Konto?`
  String get hadAccount {
    return Intl.message(
      'Besitzen Sie bereits ein Konto?',
      name: 'hadAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sie besitzen noch kein Konto?`
  String get noAccount {
    return Intl.message(
      'Sie besitzen noch kein Konto?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Passwort vergessen?`
  String get forgotPassw {
    return Intl.message(
      'Passwort vergessen?',
      name: 'forgotPassw',
      desc: '',
      args: [],
    );
  }

  /// `wir werden Ihnen einen Link, um Ihr Passwort zurückzusetzen, an Ihre Email senden!`
  String get sendEmail {
    return Intl.message(
      'wir werden Ihnen einen Link, um Ihr Passwort zurückzusetzen, an Ihre Email senden!',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Falsches Passwort!`
  String get passwordInvalid {
    return Intl.message(
      'Falsches Passwort!',
      name: 'passwordInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Benutzer nicht gefunden`
  String get userNotfound {
    return Intl.message(
      'Benutzer nicht gefunden',
      name: 'userNotfound',
      desc: '',
      args: [],
    );
  }

  /// `Email schlecht formatiert!`
  String get emailBadlyFormated {
    return Intl.message(
      'Email schlecht formatiert!',
      name: 'emailBadlyFormated',
      desc: '',
      args: [],
    );
  }

  /// `Email bereits in Verwendung!`
  String get emailTaken {
    return Intl.message(
      'Email bereits in Verwendung!',
      name: 'emailTaken',
      desc: '',
      args: [],
    );
  }

  /// `Passwort muss mindestens 6 Zeichen haben`
  String get min6Passw {
    return Intl.message(
      'Passwort muss mindestens 6 Zeichen haben',
      name: 'min6Passw',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'de', countryCode: 'DE'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'EN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
