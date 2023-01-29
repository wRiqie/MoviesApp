import 'package:flutter/material.dart';
import 'package:movies_app/app/views/home/stores/movie_store.dart';
import 'package:provider/provider.dart';

class MovieListScreen<T extends MovieStore> extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState<T>();
}

class _MovieListScreenState<T extends MovieStore> extends State<MovieListScreen> {
  @override
  void initState() {
    context.read<T>().fetchAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(T.toString()),
      ),
      // body: GridView,
    );
  }
}