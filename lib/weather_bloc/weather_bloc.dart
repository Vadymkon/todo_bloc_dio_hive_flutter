import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

// const String apiKey = '6af01d2e02f8aec27efe622ee7490d26';
// const String apiKey = '2062320e9b7c46c3581ff7e2cf5f1072';
const String apiKey = 'dcccfefbd932d021573b9a94645ac4f5';
// String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=Kyiv&APPID=$apiKey';
String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherState()) {
    on<WeatherGetInfoEvent>(_getWeatherInfo);

    add(WeatherGetInfoEvent('Kyiv'));
  }

  final _httpClient = Dio();
  /*
  * Why Dio?
  * Comparing with standard http - it has bigger functional.
  * It easy to add interceptors, cache responses,
  * send FormData, cancel requests, set timeouts, etc...
  * Comparing with analogs: it has a big community with great documentation.
  * */

   _getWeatherInfo(WeatherGetInfoEvent event, Emitter<WeatherState> emit) async {
     final res = await _httpClient.get(apiUrl, queryParameters:
     {
     // example: ?q=Kyiv&APPID=$apiKey
       'q':event.queryCity,
       'APPID':apiKey,
     });
     // print(res.data['weather']);
     emit(WeatherState(data: res.data));
     // print(state.data['weather']);
   }
}
