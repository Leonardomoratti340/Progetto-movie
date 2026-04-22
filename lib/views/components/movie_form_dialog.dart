import 'package:flutter/material.dart';
import 'package:progetto_movie/models/movie.dart';
import 'package:progetto_movie/viewmodels/movie_view_model.dart';
import 'package:provider/provider.dart';

class MovieFromDialog extends StatefulWidget {
  final Movie? movie;
  const MovieFromDialog({super.key, this.movie});

  @override
  State<MovieFromDialog> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MovieFromDialog> {
  
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _durationController;
  late TextEditingController _plotController;
  late TextEditingController _yearController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.movie?.title ?? '');
    _plotController = TextEditingController(text: widget.movie?.plot ?? '');
    _durationController = TextEditingController(text: widget.movie?.duration.toString());
    _yearController = TextEditingController(text: widget.movie?.year.toString() ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _durationController.dispose();
    _plotController.dispose();
    _yearController.dispose();
    super.dispose();
}

  void _submitForm() {
  if (_formKey.currentState!.validate()) {
    final newMovie = Movie(
      title: _titleController.text,
      duration: int.parse(_durationController.text),
      plot: _plotController.text,
      year: int.parse(_yearController.text),
    );

    final vm = context.read<MovieViewModel>();
    if (widget.movie == null) {
      vm.addMovie(newMovie);
    } else {
      vm.updateMovie(newMovie);
    }
    Navigator.of(context).pop();
  }
}

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}