import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/pages/models/pelicula_model.dart';

class PeliculasProvider{
  
  String _apikey = '6c5093ee3cb6aa10dbdfa22e7d6fb405';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';


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
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language': _language
    });

    return await  _procesarRespuesta(url);
  }
}