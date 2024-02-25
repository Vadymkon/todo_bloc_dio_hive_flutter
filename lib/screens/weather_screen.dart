import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_dio_hive_flutter/categories_list.dart';
import 'package:todo_bloc_dio_hive_flutter/notes_bloc/note_bloc.dart';
import 'package:todo_bloc_dio_hive_flutter/popup_menus/add_note.dart';
import 'package:todo_bloc_dio_hive_flutter/popup_menus/change_category_menu.dart';

import '../weather_bloc/weather_bloc.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text("Filter Screen"),

      ),
      body: WeatherWidget(City: 'Kyiv'),
    );
  }
}


//Weather Widget
class WeatherWidget extends StatelessWidget {
  final String City;

  WeatherWidget({
    Key? key, required this.City,
    //this.vars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        BlocProvider.of<WeatherBloc>(context).add(WeatherGetInfoEvent(City));
        final data = context.select((WeatherBloc wbloc) => wbloc.state.data);
        const double kelvins = -273.15;
        // if (data.isNotEmpty)
          // print(data['weather'][0]['main'].toString());
        return Column(
      children: [
        if (data.isEmpty)
        CircularProgressIndicator(),
        if (data.isNotEmpty)
        Column(
            children: [
              //name of town
              Text(data['weather'][0]['main'].toString(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 45),),
              //state of weather
              Text(data['name'].toString(), style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),),
              //icon

                if (weatherMap.keys.contains(data['weather'][0]['main']))
              Icon(weatherMap[data['weather'][0]['main']], size: 135,),
                 if (!weatherMap.keys.contains(data['weather'][0]['main']))
              const Icon(CupertinoIcons.cloud,size:135),
              //current temperature
              Text((data['main']['temp']+kelvins).round().toString()+'°', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 125),),
              //max min temperature
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    Text('max', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
                    Text((data['main']['temp_max']+kelvins).round().toString()+'°', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
                  ],),
                  //delimeter
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(width: 1, height: 25, color: Colors.black,),
                  ),
                  Column(children: [
                    const Text('min', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
                    Text(((data['main']['temp_min']+kelvins).round()).toString()+'°',
                      style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
                  ],),
                ],
              ),
              Divider(),
              //other staff (4 parameters)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //delimeter
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(width: 1, height: 25, color: Colors.black,),
                  ),
                  Column(children: [
                    Text('windspeed', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
                    Text(data['wind']['speed'].toString(), style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
                  ],),
                  //delimeter
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(width: 1, height: 25, color: Colors.black,),
                  ),
                  //delimeter
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(width: 1, height: 25, color: Colors.black,),
                  ),
                  Column(children: [
                    Text('humidity', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
                    Text((data['main']['humidity']+kelvins).round().toString(), style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),),
                  ],),
                ],
              ),
            ],
          ),
      ],
    );
  },
),
    );
  }
}
