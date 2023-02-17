// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mypack/ui/shared/layout.dart';
import 'package:mypack/utils/time.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lezioni',
      theme: ThemeData(
        fontFamily: "RobotoMono",
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.yellow,
        ),
      ),
      home: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const materie = [
    Materia(
      titolo: "Human Language Technologies",
      sigla: "HLT",
      docente: "G. Attardi",
      lezioni: [
        Appuntamento(Giorno.lunedi, Orario.terzo, "M1"),
        Appuntamento(Giorno.martedi, Orario.primo, "M1"),
        Appuntamento(Giorno.mercoledi, Orario.terzo, "M1"),
      ],
    ),
    Materia(
      titolo: "Laboratory on ICT and startup building",
      sigla: "LISB",
      docente: "P. Ferragina",
      lezioni: [
        Appuntamento(Giorno.mercoledi, Orario.terzo, "L1"),
        Appuntamento(Giorno.venerdi, Orario.primo, "C1"),
      ],
    ),
    Materia(
        titolo: "Intelligent systems for pattern recognition",
        sigla: "ISPR",
        docente: "D. Bacciu",
        lezioni: [
          Appuntamento(Giorno.martedi, Orario.secondo, "C1"),
          Appuntamento(Giorno.mercoledi, Orario.quarto, "F"),
          Appuntamento(Giorno.giovedi, Orario.terzo, "C"),
        ]),
    Materia(
        titolo: "Parallel and distributed systems: paradigms and models",
        sigla: "PDS",
        docente: "M. Danelutto",
        lezioni: [
          Appuntamento(Giorno.martedi, Orario.terzo, "C1"),
          Appuntamento(Giorno.mercoledi, Orario.secondo, "C1"),
          Appuntamento(Giorno.giovedi, Orario.primo, "C1"),
        ]),
  ];
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lezioni'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Table(
              children: [
                TableRow(
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.secondary,
                      child: const Center(
                        child: Text(
                          "Giorno",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    for (final orario in Orario.values)
                      Container(
                        color: Theme.of(context).colorScheme.secondary,
                        child: Center(
                          child: Text(
                            "$orario",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                  ],
                ),
                ...Giorno.valuesFromToday.map(
                  (giorno) => TableRow(
                    children: [
                      Center(child: Text(giorno.short)),
                      for (final orario in Orario.values)
                        Center(
                          child: Text(
                            HomeView.materie
                                .where(
                                  (element) => element.lezioni.any((element) =>
                                      element.orario == orario &&
                                      element.giorno == giorno),
                                )
                                .map((e) => e.sigla)
                                .join(' and '),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
              border: TableBorder.all(color: Colors.grey[800]!),
            ),
            ...[for (var mat in HomeView.materie) MateriaW(m: mat)],
          ],
        ),
      ),
    );
  }
}

class MateriaW extends StatelessWidget {
  const MateriaW({required this.m, super.key});
  final Materia m;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${m.titolo} - ${m.sigla}"),
      subtitle: Text(m.docente),
    );
  }
}

class Materia {
  final String titolo;
  final String sigla;
  final String docente;
  final List<Appuntamento> lezioni;
  const Materia({
    required this.titolo,
    required this.sigla,
    required this.docente,
    required this.lezioni,
  });
}

class Appuntamento {
  final Giorno giorno;
  final Orario orario;
  final String aula;
  const Appuntamento(this.giorno, this.orario, this.aula);
}

enum Giorno {
  lunedi,
  martedi,
  mercoledi,
  giovedi,
  venerdi;

  @override
  String toString() {
    switch (this) {
      case lunedi:
        return 'Lunedì';
      case martedi:
        return 'Martedì';
      case mercoledi:
        return 'Mercoledì';
      case giovedi:
        return 'Giovedì';
      case venerdi:
        return 'Venerdì';
    }
  }

  String get short {
    switch (this) {
      case lunedi:
        return 'Lun';
      case martedi:
        return 'Mar';
      case mercoledi:
        return 'Mer';
      case giovedi:
        return 'Gio';
      case venerdi:
        return 'Ven';
    }
  }

  static List<Giorno> get valuesFromToday {
    var today = now.weekday;
    if (today > 5) {
      today = 0;
    }
    var vals = [
      for (var i = 0; i < values.length; i++)
        values[(i + today) % values.length]
    ];
    return vals;
  }
}

enum Orario {
  primo,
  secondo,
  terzo,
  quarto;

  @override
  String toString() {
    switch (this) {
      case primo:
        return '09 - 11';
      case secondo:
        return '11 - 13';
      case terzo:
        return '14 - 16';
      case quarto:
        return '16 - 18';
    }
  }
}
