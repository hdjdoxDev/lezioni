import 'package:flutter/material.dart';

import 'appuntamentolezioni.dart';
import 'enum/giornolezioni.dart';
import 'enum/orariolezioni.dart';
import 'materia.dart';
import 'widgets.dart';

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
        Appuntamento(Giorno.lunedi, OrarioLezioni.terzo, "M1"),
        Appuntamento(Giorno.martedi, OrarioLezioni.primo, "M1"),
        Appuntamento(Giorno.mercoledi, OrarioLezioni.terzo, "M1"),
      ],
    ),
    Materia(
      titolo: "Laboratory on ICT and startup building",
      sigla: "LISB",
      docente: "P. Ferragina",
      lezioni: [
        Appuntamento(Giorno.mercoledi, OrarioLezioni.terzo, "L1"),
        Appuntamento(Giorno.venerdi, OrarioLezioni.primo, "C1"),
      ],
    ),
    Materia(
        titolo: "Intelligent systems for pattern recognition",
        sigla: "ISPR",
        docente: "D. Bacciu",
        lezioni: [
          Appuntamento(Giorno.martedi, OrarioLezioni.secondo, "C1"),
          Appuntamento(Giorno.mercoledi, OrarioLezioni.quarto, "F"),
          Appuntamento(Giorno.giovedi, OrarioLezioni.terzo, "C"),
        ]),
    Materia(
        titolo: "Parallel and distributed systems: paradigms and models",
        sigla: "PDS",
        docente: "M. Danelutto",
        lezioni: [
          Appuntamento(Giorno.martedi, OrarioLezioni.terzo, "C1"),
          Appuntamento(Giorno.mercoledi, OrarioLezioni.secondo, "C1"),
          Appuntamento(Giorno.giovedi, OrarioLezioni.primo, "C1"),
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
        child: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(80),
                children: [
                  TableRow(
                    children: [
                      Container(
                        width: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            border: Border.all(
                                color:
                                    Theme.of(context).colorScheme.secondary)),
                        child: const Center(
                          child: Text(
                            "Ora",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      for (final giorno in Giorno.valuesFromToday)
                        Container(
                          width: 50,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                          child: Center(
                            child: Text(
                              giorno.short,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                    ],
                  ),
                  ...OrarioLezioni.values.map(
                    (orario) => TableRow(
                      children: [
                        Center(child: Text("$orario")),
                        for (final giorno in Giorno.valuesFromToday)
                          Center(
                              child: Column(
                            children: [
                              ...HomeView.materie
                                  .where(
                                    (element) => element.lezioni.any(
                                        (element) =>
                                            element.orario == orario &&
                                            element.giorno == giorno),
                                  )
                                  .map((e) => CellW(
                                      e.sigla,
                                      e.lezioni
                                          .where((element) =>
                                              (element.orario == orario) &&
                                              (element.giorno == giorno))
                                          .first
                                          .aula)),
                            ],
                          )),
                      ],
                    ),
                  ),
                ],
                border: TableBorder(
                    horizontalInside: BorderSide(color: Colors.grey[700]!)),
                //  Colors.grey[700]!
              ),
            ),
            ...[for (var mat in HomeView.materie) MateriaW(m: mat)],
          ],
        ),
      ),
    );
  }
}
