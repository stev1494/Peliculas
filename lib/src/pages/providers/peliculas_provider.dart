import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/pages/models/pelicula_model.dart';

class PeliculasProvider{
  
  String _apikey = '6c5093ee3cb6aa10dbdfa22e7d6fb405';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;


  void disposeStreams(){
    _popularesStreamController?.close();
  }


  Future<List<Pelicula>> _procesarRespuesta (Uri url) async {

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    // print(decodedData['results']);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);
    //print(peliculas.items[0].title);
    return peliculas.items;

  }


  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language': _language
    });

    return await _procesarRespuesta(url);
  }


  Future<List<Pelicula>> getPopulares() async {

    if(_cargando) return [];
    _cargando =true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language': _language,
      'page':_popularesPage.toString()
    });

    final resp = await  _procesarRespuesta(url);

    _populares.addAll(resp);

     popularesSink(_populares);
    
    _cargando =false;

     return resp;


  }
}