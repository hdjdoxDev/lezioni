
import 'appuntamentolezioni.dart';

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
