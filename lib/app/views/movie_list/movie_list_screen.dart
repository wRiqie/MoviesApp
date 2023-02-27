import 'package:flutter/material.dart';
import 'package:movies_app/app/core/utils/helpers.dart';
import 'package:movies_app/app/global/no_content.dart';
import 'package:movies_app/app/views/home/states/movies_state.dart';
import 'package:movies_app/app/views/home/stores/movie_store.dart';
import 'package:provider/provider.dart';

class MovieListScreen<T extends MovieStore> extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState<T>();
}

class _MovieListScreenState<T extends MovieStore>
    extends State<MovieListScreen> {
  int _page = 1;

  @override
  void initState() {
    context.read<T>().fetchAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<T>();
    final state = store.value;

    Widget? child;

    if (state is LoadingMoviesState) {
      child = const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is SuccessMoviesState) {
      child = GridView.builder(
        itemCount: state.movies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 30
        ),
        itemBuilder: (context, index) => Image.network(
          Helpers.getImageUrl(state.movies[index].imgPath),
        ),
      );
    }
    if (state is ErrorMoviesState) {
      child = NoContent(
        title: 'There is no movie yet!',
        label: 'Try reloading by pressing the button below',
        onTap: () => store.fetchAll(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(T.toString()),
      ),
      body: child,
    );
  }
}
