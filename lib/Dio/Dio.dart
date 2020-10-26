import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
  baseUrl: "http://10.0.2.2:8000/",
  connectTimeout: 5000,
  receiveTimeout: 3000,
);


Dio Dia = new Dio(options);