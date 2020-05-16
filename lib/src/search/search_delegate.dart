import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {

  String selected = "";
  final moviesProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del appBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados
    return Center(
      child: Container(
        child: Text(selected),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias del buscador
    if (query.isEmpty) {
      return Container();
    } else {
      return FutureBuilder(
        future: moviesProvider.searchMovie(query),
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            final movies = snapshot.data;
            return ListView(
              children: movies.map((movie) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(movie.getPosterImg()),
                    placeholder: AssetImage("assets/no-image.jpg"),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(movie.title),
                  subtitle: Text(movie.originalTitle),
                  onTap: () {
                    close(context, null);
                    movie.uniqueId = "";
                    Navigator.pushNamed(context, "detail", arguments: movie);
                  }
                );
                }).toList()
            );
          } else {
            return Center( child: CircularProgressIndicator() );
          }
        },
      );
    }


    //final sugList = ( query.isEmpty )
    //    ? nowMovies
    //    : movies.where(
    //        (element) => element.toLowerCase().startsWith(query.toLowerCase())
    //    ).toList();
    //return ListView.builder(
    //    itemCount: sugList.length,
    //    itemBuilder: (context, index) {
    //      return ListTile(
    //        leading: Icon(Icons.movie),
    //        title: Text(sugList[index]),
    //        onTap: () {
    //          selected = sugList[index];
    //          showResults(context);
    //        },
    //      );
    //    });
  }
  
}