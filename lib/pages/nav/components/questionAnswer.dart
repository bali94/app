import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/pages/nav/components/contact.dart';
import 'package:juba/pages/nav/components/templatePage.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';
import '../../../constants.dart';
import '../../../providers/globalProvider.dart';
import '../../../widgets/globalwidget.dart';

class QandA extends StatefulWidget {
  @override
  State<QandA> createState() => _QandAState();
}

class _QandAState extends State<QandA> {
  final qandAList = [
    ReqRes(
        response:
            'Du wirst in deinem ganzen Leben wahrscheinlich mit keinem Text so viel Geld verdienen wie mit deinem Bewerbungsschreiben.\n\n'
                'Denn dies ist dein erster Schritt zum Vorstellungsgespräch, zu deinem nächsten Job und schließlich zum Einkommen. Es lohnt sich also, etwas Mühe zu investieren. ',
        question: 'Bewerbung – So klappt´s!'),
    ReqRes(
        response:
            '1.	Zeige an ganz konkreten Beispielen, wodurch und warum DU dem Unternehmen nutzt.\n'
            '\n'
            '2.	Vermeide formale Fehler. Rechtschreib- und Grammatikfehler bedeuten meist das K.o. für deine Bewerbung.\n'
            '\n'
            '3.	Bitte bleibe DIR treu. Es wird nicht funktionieren, wenn du dir selbst und dem künftigen Arbeitgeber etwas vorspielen musst. Also fang in der Bewerbung besser gar nicht erst damit an.\n',
        question: 'Die 3 wichtigsten Tipps fürs Bewerbungsschreiben '),
    ReqRes(
        response:
            '• Ein Muster oder eine Vorlage für Bewerbungen: Vier von fünf Personalern senken den Daumen über Bewerber, die standardisierte und vorformulierte Muster oder Vorlagen verwenden.\n'
            '\n'
            '• Lügen: Behaupte nichts, was nicht stimmt – erfahrene Personalentscheider haben einen sechsten Sinn für Angaben, die übertrieben oder nicht plausibel sind.\n'
            '\n'
            '• Üble Nachrede: Auch dann, wenn du allen Grund habst, auf deine bisherigen Arbeitgeber wütend zu sein – lass dies nicht durchblicken. Bleib in der Bewerbung immer positiv.\n',
        question: 'Die 3 wichtigsten Tipps was du vermeiden sollst'),
    ReqRes(
        response:
            '90% der Personaler wollen nicht mehr als eine DIN-A4 Seite sehen. Für mehr nehmen sie sich in der Regel keine Zeit.\n\n'
                'Damit steht der Umfang auch für dein Bewerbungsschreiben fest: eine Seite.',
        question: 'Wie lang darf dein Bewerbungsschreiben sein?'),
    ReqRes(
        response:
            'Formatieren der Seitenabstände: Word > Einstellungen unter Format/Dokument.\n\n'
                ' • Seitenränder oben, unten und rechts jeweils 2 Zentimeter\n\n'
                ' • Den linken Seitenrand auf 2,5 Zentimeter\n',
        question: 'Wie sollte der Aufbau deines Anschreibens aussehen?'),
    ReqRes(
        response:
            'Standardschriften:\n'
                'Times New Roman oder Arial Courier, Georgia, Helvetica oder Lucida Sans Typewriter.\n'
                'Zu exotische oder schwer lesbare Schriftarten sind tabu.\n\n'
                'Beachte bitte auch! Alle deine Bewerbungsunterlagen, also auch der Lebenslauf, sollten in der gleichen, maximal in zwei unterschiedlichen Schriftarten gehalten sein.',
        question: 'Schriftart für dein Bewerbungsschreiben'),
    ReqRes(
        response: '• Schriftgröße 12 oder 11\n'
        '\n'
            '• einfacher Zeilenabstand\n'
            '\n'
            '• Formatierung: linksbündig\n'
            '\n'
            '• Blocksatz bitte vermeiden',
        question: 'Schriftgröße für das Anschreiben'),
    ReqRes(
        response: 'Absenderadresse\n'
            '\n'
            'Option 1: Kopfzeile\n'
            '\n'
            'Hier trägst du folgendes ein: Name, Straße und Hausnummer, Postleitzahl und Stadt, Telefonnummer, E-Mail\n'
            '\n'
            'Option 2: Anschrift oben rechts\n'
            '\n'
            'In diesem Fall werden die Elemente (Name, Straße etc.) untereinander geschrieben.\n'
            '\n'
            'Adresse des Empfängers\n'
            '\n'
            'Links oben\n'
            '\n'
            'Reihenfolge:\n'
            '\n'
            '1.	Voller Name des Unternehmens (am besten schaust du auf der Internetseite nach, wie man den Namen korrekt schreibt). Der erste Eindruck zählt!\n'
            '\n'
            '2.	Name deines Ansprechpartners, gegebenenfalls mit seinem akademischen Titel. Also beispielsweise: Frau Dr. Michaela Müller.\n'
            '\n'
            'Bei Männern schreibt man Herrn – mit n am Ende: Herrn Frank Fichte.\n'
            '\n'
            '3.	Namen des Adressaten steht seine oder ihre Funktionsbezeichnung, also zum Beispiel Human Resources Manager, Head of Human Resources o.ä.\n'
            '\n'
            '4.	Straße, Postleitzahl und die Stadt des Unternehmenssitzes',
        question: 'Wohin gehören Absender und Adresse?'),
    ReqRes(
        response: 'Versuche den Namen herauszufinden.\n'
            '\n'
            ' •	Aus der Stellenanzeige\n'
            '\n'
            ' •	Auf der Internetseite des Unternehmens\n'
            '\n'
            ' •	Karrierenetzwerken wie z.B. sind Xing oder LinkedIn.\n'
            '\n'
            'Hilft auch das nicht, bleibt immer noch das Telefonat. Ruf das Unternehmen einfach an und lass dich zur Personalabteilung durchstellen und frage an welchen\n'
            'Personaler du deine Bewerbung adressieren darfst. Achte darauf, dass du den Namen und die Funktion fehlerfrei notierst.',
        question:
            'Was tun, wenn du den Namen des Adressaten gar nicht kennen?'),
    ReqRes(
        response:
            'Rechtsbündig, das heißt, auf die rechte Seite des Dokuments.\n'
            '\n'
            'Format: Stadt und das Datum\n'
           '\n'
            'Zum Beispiel: München, 03.04.2020 oder Hamburg, 01. April 2021.',
        question: 'Wo kommt das Datum hin?'),
    ReqRes(
        response:
            'Hier wird die Bezeichnung der ausgeschriebenen Stelle sowie die Referenznummer der Stellenanzeige (falls vorhanden) genannt > Schrift „FETT“ hervorheben\n'
            '\n'
            'Beispiel: Ihre Stellenanzeige für Mechatroniker, Kennziffer XYZ/4011_13/C\n'
            '\n'
                'Verzichte auf das Wort Betreff; dies gilt inzwischen als altmodisch.',
        question: 'Die Betreff-Zeile - ein sehr wichtiges Element'),
    ReqRes(
        response: 'Sehr geehrte Frau XY oder Sehr geehrter Herr XY.\n'
           '\n'
            'Formulierungen, wie z.B. ein einfaches Hallo oder ein Guten Tag, Herr XY – sind in Bewerbungsschreiben ungeeignet. \n'
           '\n'
            'Achte darauf, dass der Name in der Adresse und der Name in der Anrede wirklich übereinstimmen.',
        question: 'Die Anrede im Bewerbungsschreiben'),
    ReqRes(
        response: 'Dieses gliederst du am besten in vier Absätze.\n'
           '\n'
            ' • Einleitung\n'
           '\n'
            ' • Hauptteil - Teil 1\n'
          '\n'
            ' • Hauptteil - Teil 2\n'
           '\n'
            ' • Schlussteil',
        question: 'Aufbau des Anschreibens: So geht’s'),
    ReqRes(
        response:
            'Es gibt viele Muster oder Vorlagen für Formulierungen, diese klingen so:\n'
           '\n'
            'Mit großem Interesse habe ich Ihre Stellenanzeige für XY gelesen…\n'
           '\n'
            'Hiermit möchte ich mich auf Ihre Stellenanzeige XY bewerben…\n'
          '\n'
            'Bei StepStone.de habe ich Ihre Stellenanzeige für XY gefunden…\n'
          '\n'
            'Falsch sind diese Varianten nicht. Aber stell dir vor, du bist Personaler und liest Tag für Tag Bewerbungsanschreiben die immer so anfangen.\n'
           '\n'
            'Wetten, dass du irgendwann keine Lust mehr hättest weiterzulesen? Wer mit dem Bewerbungsanschreiben langweilig anfängt, der lässt erwarten, dass es langweilig weitergeht. \n'
           '\n'
            'Werde möglichst schnell konkret und zeige anhand von Beispielen, was du kannst und warum du dem Unternehmen nutzen kannst.\n'
          '\n'
            'Für deinen Einstieg sollten es nicht mehr als zwei bis vier Sätze sein. Am Ende des Einstiegs muss der Leser neugierig sein darauf, mehr von dir kennenzulernen.',
        question: 'Einleitung: Der erste Satz für dein Bewerbungsschreiben'),
    ReqRes(
        response:
            'Wenn du ein cooler Typ bist, wähle einen passenden coolen Satz:\n'
           '\n'
            '„Klar bin ich ein Gamer. Aber noch mehr als Computerspiele interessiert es mich, die Rechnerleistung durch innovative Entwicklungen weiter zu steigern – genau das, was in Ihrer Stellenausschreibung XY gefordert ist.”\n'
           '\n'
            'Bist du eher der Typ fleißiges Bienchen, dann kannst du das auch erwähnen:\n'
          '\n'
           '„Ich habe mich immer schon dafür begeistert, die Dinge zu ordnen und übersichtlich zu strukturieren. Mein Herz schlägt für die Buchhaltung.”\n'
          '\n'
            'Selbstbewusst: „Für Ihre Stelle XY bin ich genau der Richtige. Denn…“ (danach muss dann die überzeugende Begründung folgen).\n'
           '\n'
            'Humorvoll: „Beim Kaffeekochen habe ich bislang immer versagt. Aber das ist es auch nicht, was Sie von einem Top-Controller erwarten.”\n'
           '\n'
            'Konkret: „In meiner vorherigen Position habe ich meinem Unternehmen ein Umsatzplus von drei Prozent gebracht. Genau das möchte ich für Ihr Unternehmen auch erreichen.”\n'
           '\n'
            'Persönlich: „Prof. Meier meinte, Ihre Stelle als XY ist genau richtig für mich. Und Prof. Meier kennt mich gut – er hat meine Master-Arbeit betreut, die ich im letzten Monat mit der Note sehr gut abschließen konnte.”\n'
          '\n'
            'Oder formuliere direkt vom Interesse des Unternehmens her: „Sie möchten eine Sales-Managerin, die Ihre Verkaufszahlen in die Höhe treibt?”',
        question: 'Beispiele für die Einleitung'),
    ReqRes(
        response:
            'Du bist noch am Anfang deiner Karriere, dann kannst du noch nicht mit Berufserfahrung und früheren Erfolgen punkten. \n'
            '\n'
                'Stelle andere Qualitäten in den Vordergrund – ob absolvierte Praktika, Aktivitäten in der Schule oder auch persönliche Eigenschaften.\n '
            '\n'
                'Entscheidend ist, dass dies immer einen Bezug zu der ausgeschriebenen Position haben muss. Zum Beispiel:\n'
            '\n'
                '„Schon als Kind war ich nicht zu bremsen, wenn es ums Kino ging. Bis heute gehört meine Leidenschaft dem Film – und darum ist Ihre Stelle als Producer bei der Videoproduktion XY wie für mich gemacht.”',
        question: 'Bewerben ohne Berufserfahrung?'),
    ReqRes(
        response:
            'Nach der Einleitung folgen die zwei Hauptabsätze des Bewerbungsschreibens.\n'
          '\n'
            'Der erste Absatz gehört der Darstellung deiner Hard Skills, also fachlich-beruflichen Kompetenzen und Erfolge.\n '
          '\n'
            'Im zweiten Teil folgen die Soft Skills wie z.B. Motivation und Leidenschaft ebenso wie Teamfähigkeit und Führungsqualitäten.\n'
          '\n'
            'Was sind deine Kompetenzen, Fähigkeiten und Fertigkeiten\n'
          '\n'
            'Was sind deine Top-Erfolge?\n'
          '\n'
            'Welche Kompetenzen bringst du dem Unternehmen?\n'
          '\n'
            'Beispiele:\n'
          '\n'
            '„Bei der Kostenkalkulation für eine Großbaustelle in Dubai hatten wir durch überraschende Entwicklungen am Finanzmarkt ein erhebliches Währungsrisiko zu bewältigen.\n '
          '\n'
            'Mit einem innerhalb von nur zwei Wochen entwickelten Kostendämpfungsprogramm konnte ich dazu beitragen, den vorgesehenen Budgetrahmen ohne Leistungseinbußen einzuhalten.“\n'
          '\n'
            '„Als Werkstudent habe ich erfolgreich die Chance nutzen können, eine Präsentation über alternative Anwendungsmöglichkeiten für eines unserer\n '
         '\n'
            'chemischen Spezialprodukte zu entwickeln und vorzustellen. Diese Präsentation hat im Endeffekt tatsächlich zur Erschließung eines neuen Marktsegments geführt.“\n'
          '\n'
            'Nenne Beispiele für deine Leistungen wie z.B.\n'
          '\n'
            ' • so und so viele neue Kunden habe ich gewonnen\n'
          '\n'
            ' • ein herausforderndes Projekt gemeistert\n'
          '\n'
            ' • eine Steigerung von Umsatz oder Gewinn um so und so viel Prozent erreicht\n'
         '\n'
            ' •	Kosten, Arbeitszeit oder Material eingespart\n'
          '\n'
            ' •	die Ausschussquote um einen konkreten Prozentsatz gesenkt\n'
          '\n'
            ' • CO2-Footprint mit konkreten Verbesserungen reduziert haben\n',
        question: 'Der Hauptteil des Bewerbungsschreibens – Teil 1'),
    ReqRes(
        response: 'Die Leitfrage: '
            'Welche deiner persönlichen Eigenschaften bedeutet für dieses Unternehmen Vorteile? Erfüllst du die Anforderungen?\n'
            '\n'
            'Lies dir die Stellenanzeige des Unternehmens noch einmal sorgfältig durch und achte darauf, welche Soft Skills besonders betont und gefordert werden.\n'
            '\n'
            'Das könnte zum Beispiel sein:\n'
           '\n'
            ' • Teamfähigkeit\n'
            '\n'
            ' •	selbstbewusstes Auftreten\n'
            '\n'
            ' •	hohe Belastbarkeit\n'
           '\n'
            ' •	Flexibilität\n'
           '\n'
            'Passen diese Anforderungen wirklich zu dir?\n'
           '\n'
            'Einige Beispiele:\n'
           '\n'
            '„Als Praktikantin in einem Optiker-Fachgeschäft haben viele Kunden gegenüber meiner Chefin meine ruhige und freundliche Art gelobt und betont,\n '
            'dass sie sich von mir besonders gerne beraten lassen.“\n'
          '\n'
            '„Als Facility-Manager einer Immobilienverwaltung musste ich auch außerhalb der Kernarbeitszeit jederzeit ansprechbar sein und auf Herausforderungen reagieren können.\n '
            'Mir haben viele Mieter ihre Dankbarkeit dafür ausgedrückt, dass ich bei Problemen auch zu ungewöhnlichen Zeiten zur Verfügung stand und dabei freundlich und hilfsbereit aufgetreten bin.“\n'
           '\n'
            '„Schon als Jugendliche habe ich meine freie Zeit mit Elektronik-Bausätzen und später mit dem Zusammensetzen von Computer-Komponenten zu eigenen PCs verbracht. '
            'Bis heute ist Elektronik ist meine Leidenschaft, wenn ich daran tüftele, vergesse ich alles andere um mich herum.“\n'
           '\n'
            '„Mich hat immer schon die Frage bewegt, wie wir eine funktionierende Wirtschaft mit einer gesunden Umwelt in Einklang bringen können. \n'
            'Klimaschutz ist in meinen Augen die zentrale Herausforderung unserer Zeit. \n'
            'Deswegen bin ich für die Tätigkeit als Nachhaltigkeitsmanagerin aus tiefster innerer Überzeugung heraus motiviert.“',
        question: 'Der Hauptteil des Bewerbungsschreibens– Teil 2'),
    ReqRes(
        response:
            'Hier kannst du noch sachliche Informationen unterzubringen, sofern dies nötig sind.\n'
           '\n'
            '•	Gehaltsvorstellung – unbedingt benennen, wenn diese auch in der Stellenausschreibung gefordert sind\n'
          '\n'
            '•	Das früheste mögliche Eintrittsdatum\n'
           '\n'
            '•	Bitte um Vertraulichkeit (Sperrvermerk):  Wenn du noch an deine alte Stelle gebunden bist und nicht möchtest, '
            'dass der aktuelle Arbeitgeber von deiner Bewerbung erfährt, dann kannst du diese Bitte einbauen.\n'
           '\n'
            '„Da ich mich derzeit noch in einem ungekündigten Anstellungsverhältnis befinde, bitte ich, meine Bewerbung vertraulich zu behandeln.“\n',
        question: 'Der Schluss deines Anschreibens'),
    ReqRes(
        response:
            'Achte darauf, nicht ein Opfer deiner eigenen Höflichkeit zu werden.\n '
           '\n'
            'Wer einen Konjunktiv benutzt, macht sich in den Augen der Personaler klein – er zeigt einen Mangel an Selbstbewusstsein. \n'
           '\n'
            'Gefragt ist stattdessen der Balanceakt, freundlich und selbstbewusst zugleich zu klingen.\n'
          '\n'
            'Einige schlechte Beispiele:\n'
           '\n'
            '„Ich würde mich freuen, bald von Ihnen zu hören.“\n'
           '\n'
            '„Es wäre schön, wenn mein Profil Ihnen zusagte und Sie mich zum Vorstellungsgespräch einladen würden.“\n'
           '\n'
            'Benutze stattdessen klare Aussagesätze, ohne dabei Druck aufzubauen. Das geht zum Beispiel so:\n'
           '\n'
            ' „Ich freue mich auf Ihre Einladung zu einem Vorstellungsgespräch.“\n'
           '\n'
            '„Ihrer Rückmeldung sehe ich gern entgegen und freue mich auf das Gespräch mit Ihnen.“\n'
          '\n'
            '„Für Ihre Rückfragen stehe ich gern zur Verfügung.“\n'
          '\n'
            '„Lernen Sie meine Motivation und mein Engagement im persönlichen Gespräch kennen.“\n'
          '\n'
            '„Gern nehme ich die Gelegenheit wahr, mich Ihnen im persönlichen Gespräch näher vorzustellen.“\n',
        question: 'Die Abschlussformel '),
    ReqRes(
        response: 'Formulierungen wie zum Beispiel:\n'
           '\n'
            ' •	„Mit freundlichen Grüßen“\n'
           '\n'
            ' •	„Mit freundlichem Gruß“\n'
            '\n'
            'Besser nicht: lässigere Varianten wie z.B.\n'
           '\n'
            ' •	„Mit bestem Gruß“\n'
           '\n'
            ' •	„Es grüßt Sie“\n'
            '\n'
            ' •	„Schöne Grüße“\n',
        question: 'Die Grußformel'),
    ReqRes(
        response: 'Musterbeispiele für Berufseinsteiger & Praktikanten\n'
           '\n'
            ' ✓  Auf neue praktische Herausforderungen und ein persönliches Kennenlernen freue ich mich.\n'
           '\n'
            ' ✓  Gerne überzeuge ich Sie auch bei einem persönlichen Gespräch von meinen theoretischem Know-how und meiner praktischen Motivation.\n'
          '\n'
            ' ✓  Ich freue mich die hohe Motivation und Ausdauer, die ich bislang bei ehrenamtlichen Tätigkeiten bewiesen habe, nun in Ihrem Team umzusetzen.\n'
           '\n'
            'Musterbeispiele : kurz & knackig\n'
          '\n'
            ' ✓  Für ein persönliches Gespräch stehe ich gerne zur Verfügung.\n'
          '\n'
            ' ✓  Auf eine positive Nachricht von Ihnen freue ich mich.\n'
           '\n'
            ' ✓  Ich freue mich auf Ihre Rückmeldung.\n'
           '\n'
            ' ✓  Für ein Gespräch komme ich gerne zu Ihnen.\n'
           '\n'
            'Musterbeispiele: zurückhaltend & höflich\n'
           '\n'
            ' ✓  Wenn Sie Interesse an meiner engagierten Mitarbeit haben, dann freue ich mich über eine Einladung zum Vorstellungsgespräch.\n'
          '\n'
            ' ✓  Für ein weiterführendes Gespräch stehe ich Ihnen jederzeit zur Verfügung!\n'
          '\n'
            ' ✓  Falls Sie noch Fragen haben, stehe ich Ihnen gerne per E-Mail, persönlich oder per Telefon-Interview zur Verfügung.\n'
          '\n'
            'Musterbeispiele: selbstbewusst & überzeugend\n'
          '\n'
            ' ✓  Gerne überzeuge ich Sie in einem persönlichen Gespräch davon, dass Sie mit mir einen ebenso engagierten wie erfahrenen Mitarbeiter gewinnen.\n'
          '\n'
            ' ✓  Wie Sie sehen, bin ich für eine Mitarbeit hochmotiviert und freue mich Ihnen dies im Vorstellungsgespräch persönlich zu beweisen.\n'
           '\n'
            ' ✓  Ihrer positiven Rückmeldung sehe ich mit großer Freude entgegen.\n'
           '\n'
            ' ✓  Ich bin überzeugt davon, Ihr Team perfekt zu ergänzen und freue mich auf ein persönliches Kennenlernen.\n'
           '\n'
            'Musterbeispiele: informativ\n'
           '\n'
            ' ✓  Für das bevorstehende Arbeitsverhältnis stehe ich Ihnen ab dem XX.XX.XXXX zur Verfügung, für ein Interview gerne ab sofort.\n'
           '\n'
            ' ✓  Da ich mich aus ungekündigter Stelle bewerbe, freue ich mich über ein persönliches Gespräch und einen möglichen Eintritt unter Berücksichtigung meiner zweimonatigen Kündigungsfrist.\n',
        question: 'Musterbeispiele Schlusssatz – für jeden Typ'),
    ReqRes(
        response:
            'Bitte eine oder besser zwei andere Personen, dein Anschreiben sorgfältig durchzulesen. Achte vor allem auf Folgendes:\n'
           '\n'
            ' •	Stimmen alle Namen im Bewerbungsschreiben und sind sie auch richtig geschrieben?\n'
           '\n'
            ' •	Sind alle Formulierungen in deiner Bewerbung verständlich und klar?\n'
           '\n'
            ' •	Ist das Schriftbild des Anschreibens insgesamt übersichtlich und ansprechend?\n'
            '\n'
                ' •	Gibt es Zweifel bei der Rechtschreibung oder Grammatik? (Tipp: Der Duden hilft weiter)\n'
           '\n'
                ' •	Ist irgendwo eine Formulierung zu umgangssprachlich?\n'
           '\n'
            ' •	Ist eine Formulierung zu steif (Beamtendeutsch)?\n'
           '\n'
            ' •	Steht das Wort dass mit ss, wo es hingehört, und mit einem s, wo das Wort als Relativpronomen dient?\n'
           '\n'
            ' •	Sie und Ihr in der Anrede immer groß geschrieben?\n'
           '\n'
            ' •	Stehen die Kommata da, wo sie stehen sollten – und nicht etwa da, wo keine sein sollten?\n'
           '\n'
            ' •	Im Bewerbungsanschreiben niemals man schreiben, sondern immer die Person konkret benennen, also ich oder wir.\n'
          '\n'
           ' • Auf Passiv im Bewerbungsanschreiben verzichten (Nicht: „Die Aufgabe wurde erledigt.” Sondern: „Ich habe die Aufgabe erledigt.”)\n'
          '\n'
            ' • Lange, verschachtelte Sätze in der gesamten Bewerbung vermeiden. Besser zwei oder drei Sätze daraus machen.\n'
          '\n'
            ' • Möglichst Verben statt Substantive verwenden: Nicht: „Die Durchführung der Aufgabe wurde mir zugewiesen.”\n '
           '\n'
                'Sondern: „Mein Chef hat mich damit betraut, diese Aufgabe durchzuführen.”)\n',
        question: 'Der Fehlerteufel liegt im Detail'),
    ReqRes(
        response:
            'Der Lebenslauf ist für die Mehrheit der Personaler das Herzstück einer Bewerbung.\n'
          '\n'
            'Wie viel Zeit nehmen sich Personaler für die Begutachtung eines Lebenslaufs?\n'
            '\n'
                'Weniger als eine Minute!\n'
          '\n'
            'Wichtigkeit der einzelnen Bestandteile der Bewerbung:\n'
           '\n'
            ' • Lebenslauf – 68%\n'
          '\n'
            ' • Motivationsschreiben – 22%\n'
          '\n'
            ' • Arbeitszeugnisse – 10%\n',
        question: 'So lesen Personaler deine Bewerbung'),
    ReqRes(
        response:
            'Solltest du kein passendes Bewerbungsfoto haben, dann verzichte lieber ganz darauf.\n '
                '\n'
                'Ein unpassendes Foto – wie zum Beispiel aus dem Urlaub – hinterlässt einen schlechteren Eindruck als gar keins.\n ',
        question: 'Lieber kein Foto als ein schlechtes'),
    ReqRes(
        response:
            'Der Lebenslauf ist das wichtigste Dokument deiner Bewerbung.\n'
                '\n'
            'Das schauen sich Personaler als erstes an, noch vor dem Anschreiben – und fällen ihre erste Entscheidung.\n '
                '\n'
                'Denn um eine Vorauswahl zu treffen und offensichtlich ungeeignete Kandidaten auszusieben, reicht vielen Personalmanagern die Vorlage des Lebenslaufs bereits aus \n',
        question: 'Lebenslauf: Entscheidung auf den ersten Blick'),
    ReqRes(
        response:
            'Ein Lebenslauf muss deinen Ausbildungsweg und deine beruflichen Stationen grundsätzlich lückenlos und vollständig darstellen.\n '
                '\n'
            'Vollständig bezieht sich auf den zeitlichen Ablauf: Es sollten keine längeren Phasen ohne Angaben bleiben.\n '
                '\n'
                'Das bedeutet nicht, dass du deine Grundschulzeugnisse und Schülerpraktika aufführen solltest. \n'
                '\n'
            'In den Lebenslauf gehören:\n'
                '\n'
                ' •	Letzter Schulabschluss\n'
                '\n'
            ' •	Alle weiteren Bildungsabschlüsse\n'
                '\n'
            ' •	Berufsausbildungen\n'
                '\n'
            ' •	Praktika\n'
                '\n'
            ' •	Zusatzqualifikationen\n'
                '\n'
            ' •	Berufliche Stationen\n'
                '\n'
            ' •	Phasen der Arbeitslosigkeit\n'
                '\n'
            ' •	Elternzeit oder ähnliches\n',
        question:
            'Der Anspruch an deinen Lebenslauf: vollständig und lückenlos'),
  ];

  var _filteredQuestions = <ReqRes>[];

  final _searchController = TextEditingController();

  void searchQuestions() {
    final query = _searchController.text;

    if (query.isNotEmpty) {
      _filteredQuestions = qandAList.where((ReqRes ReqRes) {
        return ReqRes.question.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredQuestions = qandAList;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filteredQuestions = qandAList;
    _searchController.addListener(searchQuestions);
  }

  @override
  Widget build(BuildContext context) {
    var globalProvider = context.watch<GlobalProvider>();
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration:
          BoxDecoration(gradient: GlobalWidgets().gradient(globalProvider)),
      child: Column(children: [
        GlobalWidgets().logoAndBAckButton(context, globalProvider,
            withFilterButton: true, width: width),
        Expanded(
            child: Container(
          width: MainHelper().responsiveWidth(width),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GlobalWidgets().text('Fragen und Antworten',
                      fontWeight: FontWeight.w900,
                      fontSize: kBigSize,
                      textColor:
                          globalProvider.getTheme().colorScheme.secondary),
                ),
              ),
              CupertinoSearchTextField(
                borderRadius: BorderRadius.circular(30),
                style: GlobalWidgets().style(fontSize: kMediumSize),
                onChanged: (value) {},
                onSubmitted: (value) {},
                controller: _searchController,
                itemSize: 30,
                itemColor: CupertinoColors.darkBackgroundGray.withAlpha(100),
                prefixInsets: EdgeInsets.only(left: 20),
                suffixInsets: EdgeInsets.only(right: 20),
                autocorrect: true,
                backgroundColor: Colors.white.withAlpha(200),
              ),
              SizedBox(
                height: 25,
              ),
              ListView.builder(
                  padding: EdgeInsets.only(top: 8),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: _filteredQuestions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final questions = _filteredQuestions[index];
                    return Card(
                      elevation: 8,
                      color: globalProvider.getTheme().colorScheme.secondary,
                      child: ExpansionTile(
                        collapsedIconColor:
                            globalProvider.getTheme().colorScheme.primary,
                        iconColor:
                            globalProvider.getTheme().colorScheme.primary,
                        initiallyExpanded: index == 0 ? true : false,
                        title: GlobalWidgets().text(questions.question,
                            textColor:
                                globalProvider.getTheme().colorScheme.primary,
                            fontSize: kMediumSize),
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Icon(
                            Icons.question_answer,
                            color:
                                globalProvider.getTheme().colorScheme.primary,
                          ),
                        ),
                        children: [
                          ListTile(
                              title: GlobalWidgets().text(questions.response,
                                  fontSize: kMediumSize,
                                  textColor: globalProvider
                                      .getTheme()
                                      .colorScheme
                                      .primary)),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ))
      ]),
    );
  }
}

class ReqRes {
  final String response;
  final String question;

  // final String Titel;

  ReqRes({
    required this.response,
    required this.question,
    /*this.Titel*/
  });
}
