import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  // Al llamarlo requiere una lista
  CardSwiper({ @required this.movies });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
        padding: EdgeInsets.only(top: 15.0),
        // Widget swiper de cards
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context, int index){

          movies[index].uniqueId = "${ movies[index].id  }-card";

            return Hero( // Para hacer una transición entre la imagen del homepage y la de la vista detalle
                tag: movies[index].uniqueId, // Mismo tag que el de la imagen de la vista detalle
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: GestureDetector( // Listener para cuando se haga click en una card
                    child: FadeInImage(
                      image: NetworkImage(movies[index].getPosterImg()),
                      placeholder: AssetImage("assets/no-image.jpg"),
                      fit: BoxFit.cover
                    ),
                    onTap: () {
                      // Navegar a la vista detalle pasándole la movie
                      Navigator.pushNamed(context, "detail", arguments: movies[index]);
                    },
                  )
                )
            );
          },
          itemCount: movies.length,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
        )
    );
  }
}
