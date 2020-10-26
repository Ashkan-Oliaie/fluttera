

import 'package:hive/hive.dart';
import 'package:testapp/Redux/Redux.dart';

part 'Hive.g.dart';

@HiveType(typeId: 0)
class HiveEntry extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  List<HiveRecord> entry;

  HiveEntry({this.name,this.entry});
}

@HiveType(typeId:1)
class HiveRecord extends HiveObject {

  @HiveField(0)
  String field;

  @HiveField(1)
  String value;

  HiveRecord({this.field,this.value});
}


