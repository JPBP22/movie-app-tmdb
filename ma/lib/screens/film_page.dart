import 'package:flutter/material.dart';

class FilmPage extends StatefulWidget {
  final int filmId;
  final String mediaType;

  FilmPage({Key? key, required this.filmId, required this.mediaType}) : super(key: key);

  @override
  _FilmPageState createState() => _FilmPageState();
}

class _FilmPageState extends State<FilmPage> {
 

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Film Details'),
      ),
      body: Center(
        child: Text('Details for film ID: ${widget.filmId}, Type: ${widget.mediaType}'),
      ),
    );
  }

}
