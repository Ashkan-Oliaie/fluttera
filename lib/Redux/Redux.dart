
import 'package:redux/redux.dart';

import 'package:testapp/Redux/FieldState/FieldsReducers.dart';


List<String> recordTitle=['Jurisdictional','','Equipment Description','Equipment Type','Equipment Type','Inspection Methods'];

class Record{
  int fieldId;
  String value;

  Record({this.fieldId,this.value});

}

class Entry{
  List<Record> records;
  Entry({this.records});
}

class DataState{
  List<Entry> entries;
  DataState({this.entries});

}

class AppState {

  final DataState dataState;

  AppState({this.dataState});
}




AppState appStateReducer(AppState state, action) =>  AppState(
  dataState:DataReducer(state.dataState, action),

);



var initialState=AppState(dataState:DataState(entries: [
  Entry(records: [
    Record(fieldId: 1,value: 'value1'),
    Record(fieldId: 2,value: 'value1'),
    Record(fieldId: 3,value: 'value1'),
    Record(fieldId: 4,value: 'PV'),
    Record(fieldId: 5,value: 'Tank'),
    Record(fieldId: 6,value: 'NDE'),

  ])
]));


final reduxStore = new Store<AppState>(appStateReducer, initialState: initialState);