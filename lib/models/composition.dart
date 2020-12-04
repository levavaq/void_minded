import 'package:void_minded/models/chord.dart';

class Composition {
  final String uid;
  final String compositor;
  final String name;
  final String creationDate;
  final String lastModified;
  final List<Chord> chords;

  Composition({this.uid, this.compositor, this.name, this.creationDate, this.lastModified, this.chords});
}
