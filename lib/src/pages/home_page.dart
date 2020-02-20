import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/providers/peliculas_provider.dart';
import 'package:peliculas/src/pages/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/pages/widgets/movie_horizontal.dart';


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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swipperTarjetas(),
            _footer( context )
          ],
        ),
      )
    );
  }


 Widget _swipperTarjetas(){

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


Widget _footer(BuildContext context){
  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[     
        Container(
          padding: EdgeInsets.only(left:20.0),
          child: Text('Populares' , style: Theme.of(context).textTheme.subhead)),
        SizedBox(height: 5.0,),
        FutureBuilder(
          future: peliculasProvider.getPopulares(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // snapshot.data?.forEach((p)=> print(p.title));
            if(snapshot.hasData){
              return MovieHorizontal(peliculas: snapshot.data,);
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    ),
  );
}
}