
import 'package:flutter/material.dart';

import 'materia.dart';

class CellW extends StatelessWidget {
  const CellW(this.sigla, this.aula, {super.key});
  final String sigla;
  final String aula;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      margin: const EdgeInsets.all(2),
      child: Row(children: [
        Text(
          "$sigla${sigla.length == 2 ? "  " : sigla.length == 3 ? " " : ""}",
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          aula,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ]),
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
