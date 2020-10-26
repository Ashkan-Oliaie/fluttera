import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
  baseUrl: "https://fluttera.herokuapp.com/",
  connectTimeout: 5000,
  receiveTimeout: 3000,
);


Dio Dia = new Dio(options);