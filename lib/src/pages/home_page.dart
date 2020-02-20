import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/providers/peliculas_provider.dart';
import 'package:peliculas/src/pages/widgets/card_swiper_widget.dart';


class HomePage extends StatelessWidget {
  
  
  final peliculasProvider = PeliculasProvider();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pelis NOW'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body:Container(
        child: Column(
          children: <Widget>[
            _swipperTarjetas(),
          ],
        ),
      )
    );
  }


  _swipperTarjetas(){

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
         return CardSwiper(peliculas:snapshot.data );
        }else {
          return Container(
            height:400.0,
            child: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
      },
    );

    // peliculasProvider.getEnCines();
    // return CardSwiper(peliculas:[1,2,3,4]);
  }

}