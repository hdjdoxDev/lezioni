import 'enum/giornolezioni.dart';
import 'enum/orariolezioni.dart';

class Appuntamento {
  final Giorno giorno;
  final OrarioLezioni orario;
  final String aula;
  const Appuntamento(this.giorno, this.orario, this.aula);
}
