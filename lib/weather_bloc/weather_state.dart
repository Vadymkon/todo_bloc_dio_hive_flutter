part of 'weather_bloc.dart';

@immutable
class WeatherState {
  final Map data;

  const WeatherState({this.data = const {}});
}