import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Movie> movies;

  MovieHorizontal({ @required this.movies });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.2,
      // Widget de lista scrolleable por páginas
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3 // Número de items por página
        ),
        children: _cards(context)
      ),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return movies.map((movie) {

      movie.uniqueId = "${ movie.id  }-poster";

      // Listener para cuando se haga click en una card
      return GestureDetector (
          child: Container(
            margin: EdgeInsets.only(right: 15.0),
            child: Column(
              children: <Widget>[
                Hero( // Para hacer una transición entre la imagen del homepage y la de la vista detalle
                  tag: movie.uniqueId, // Mismo tag que el de la imagen de la vista detalle
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage(
                      image: NetworkImage(movie.getPosterImg()),
                      placeholder: AssetImage("assets/no-image.jpg"),
                      fit: BoxFit.cover,
                      height: 100.0,
                    )
                  ),
                ),
                SizedBox(height: 3),
                Text(movie.title, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption)
              ],
            ),
          ),
          onTap: () {
            // Navegar a la vista detalle pasándole la movie
            Navigator.pushNamed(context, "detail", arguments: movie);
          },
      );
    }).toList();
  }

}
