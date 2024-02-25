part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class WeatherGetInfoEvent extends WeatherEvent {
  final String queryCity;

  WeatherGetInfoEvent(this.queryCity);
}