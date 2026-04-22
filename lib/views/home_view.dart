import 'package:flutter/material.dart';
import 'package:progetto_movie/viewmodels/movie_view_model.dart';
import 'package:progetto_movie/views/components/movie_form_dialog.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        context.read<MovieViewModel>().fecthMovies();
      }
    );
    return Scaffold(
      appBar: AppBar(title: Text("Movie Collection APP"), centerTitle: true),
      body: Consumer<MovieViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.movies.isEmpty) {
            return const Center(
              child: Text(
                "Non hai inserito alcun film",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            );
          }

          return const Text("verrà sostituito dalla lista dei film");
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(context: context, 
          builder: (_) => MovieFromDialog());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}