


import 'package:testapp/Redux/FieldState/FieldsActions.dart';
import 'package:testapp/Redux/Redux.dart';




DataState DataReducer(DataState state,action) {

  if (action is SetData) {
    return action.data;
  }

  if( action is AddData){

    var newData=state;
    newData.entries.add(action.entry);
    return newData;
  }

  return state;
}