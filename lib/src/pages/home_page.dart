import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Movies in cinemas"),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      // Para no colocar nada en el notch
      //body: SafeArea(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _cardSwiper(),
              _footer(context)
          ],
        ),
      ),
    );
  }

  // Widget swiper de cards
  Widget _cardSwiper() {
    // Widget para recibir datos de forma asíncrona
    return FutureBuilder(
      future: moviesProvider.getNowPlaying(), // Llamada a datos
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) { // Snapshot contiene los datos recibidos
        if (snapshot.hasData) {
          return CardSwiper(
              movies: snapshot.data
          );
        } else {
          return Container(
              child: Center(
                  child: CircularProgressIndicator()
              )
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("Populares", style: Theme.of(context).textTheme.subtitle1),
          ),
          SizedBox( height: 5.0 ),
          FutureBuilder(
            future: moviesProvider.getPopular(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(movies: snapshot.data);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
          )
        ],
      ),
    );
  }

}
