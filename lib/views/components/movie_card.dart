import 'package:flutter/material.dart';
import 'package:progetto_movie/models/movie.dart';
import 'package:progetto_movie/viewmodels/movie_view_model.dart';
import 'package:progetto_movie/views/components/movie_form_dialog.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(movie.title),
        subtitle: Text(
          "Anno: ${movie.year} - Durata: ${movie.duration} \n Trama: ${movie.plot}",
        ),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(onPressed: (){
              showDialog(context: context,
               builder: (_) => MovieFromDialog(movie: movie,)
               );
            }, 
            icon: Icon(Icons.edit, color: Colors.amber,)),
            IconButton(
              onPressed: () {
                context.read<MovieViewModel>().deleteMovie(movie.id!);
              },
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
