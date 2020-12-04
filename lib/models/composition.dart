import 'package:void_minded/models/chord.dart';

class Composition {
  final String uid;
  final String compositor;
  final String name;
  final List<Chord> chords;

  Composition({this.uid, this.compositor, this.name, this.chords});
}
