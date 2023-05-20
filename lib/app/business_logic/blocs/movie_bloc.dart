import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/app/business_logic/blocs/movie_event.dart';
import 'package:movies_app/app/business_logic/blocs/movie_state.dart';
import 'package:movies_app/app/data/repositories/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _movieRepository;

  MovieBloc(this._movieRepository) : super(MovieState()) {
    on<MovieGetNowPlayingEvent>(_mapGetNowPlayingEventToState);
    on<MovieGetPopularEvent>(_mapGetPopularEventToState);
    on<MovieGetTopRatedEvent>(_mapGetTopRatedEventToState);
    on<MovieGetTrendingEvent>(_mapGetTrendingEventToState);
    on<MovieGetUpcomingEvent>(_mapGetUpcomingEventToState);
  }

  void _mapGetNowPlayingEventToState(
      MovieGetNowPlayingEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(status: MovieStatus.loading));
    final response = await _movieRepository.getNowPlaying();
    if (response.isSuccess) {
      emit(state.copyWith(
        status: MovieStatus.success,
        nowPlayingMovies: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: MovieStatus.error,
        error: response.error,
      ));
    }
  }

  void _mapGetPopularEventToState(
      MovieGetPopularEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(status: MovieStatus.loading));
    final response = await _movieRepository.getPopular();
    if (response.isSuccess) {
      emit(state.copyWith(
        status: MovieStatus.success,
        popularMovies: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: MovieStatus.error,
        error: response.error,
      ));
    }
  }

  void _mapGetTopRatedEventToState(
      MovieGetTopRatedEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(status: MovieStatus.loading));
    final response = await _movieRepository.getTopRated();
    if (response.isSuccess) {
      emit(state.copyWith(
        status: MovieStatus.success,
        topRatedMovies: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: MovieStatus.error,
        error: response.error,
      ));
    }
  }

  void _mapGetTrendingEventToState(
      MovieGetTrendingEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(status: MovieStatus.loading));
    final response = await _movieRepository.getTrendingWeek();
    if (response.isSuccess) {
      emit(state.copyWith(
        status: MovieStatus.success,
        trendingMovies: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: MovieStatus.error,
        error: response.error,
      ));
    }
  }

  void _mapGetUpcomingEventToState(
      MovieGetUpcomingEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(status: MovieStatus.loading));
    final response = await _movieRepository.getUpcoming();
    if (response.isSuccess) {
      emit(state.copyWith(
        status: MovieStatus.success,
        upcomingMovies: response.data,
      ));
    } else {
      emit(state.copyWith(
        status: MovieStatus.error,
        error: response.error,
      ));
    }
  }
}
