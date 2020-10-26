import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:persian_fonts/persian_fonts.dart';
import 'package:testapp/Components/Touchable.dart';
import 'package:testapp/Components/Typo.dart';

import 'dart:ui';



class FormaField{
  String name;
  int type;
  String label;
  List selectiveData;
  Function onSelect;
  String value;

  FormaField({this.name,this.type,this.label,this.selectiveData,this.onSelect,this.value});
}



class DataField{
  int fieldId;
  String fieldTitle;
  int fieldType;
  var fieldConfig;


  DataField({this.fieldId,this.fieldTitle,this.fieldType,this.fieldConfig});
}




class localState {
  int counter = 0;


  localState(
      {this.counter = 0,
      });

  localState set(
      {int counter = 0,
      }) {

    return localState(
      counter: counter ?? this.counter,

    );
  }
}

class Increment{
  final int counter;

  Increment({this.counter});
}

reducer(state, action) {
  if (action is Increment) {
    return localState(
        counter: state.counter + action.counter);
  }

  return state;
}


class Forma extends HookWidget {

  // final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  List fields;
  GlobalKey<FormBuilderState> keya;
  String formTitle;
  var onSubmit;

  Forma({this.fields,this.keya,this.formTitle,this.onSubmit});



  @override
  Widget build(BuildContext context) {

    final store = useReducer(reducer, initialState: localState());



    final Size size = MediaQuery.of(context).size;
    // useEffect(() {
    //
    //   fields.forEach((element) {
    //
    //   });
    //
    //   return () => {};
    // }, [fields]);




    return Container(


        child: SingleChildScrollView(
          scrollDirection:Axis.vertical,
          child:   Container(
            height: size.height-60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Typo(text:formTitle,bold: true,),
                FormBuilder(
                  key: keya,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: fields.map((f){


                      switch (f['fieldType']){



                        case 1:


                          return  Container(
                            margin: EdgeInsets.only(top:10),
                            child: Material(
                              elevation:6,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white70,
                              child: Container(

                                width: 350,
                                child: Padding(
                                  padding: const EdgeInsets.only(right:15,left:15),
                                  child: FormBuilderTextField(
                                    style: TextStyle(
                                        fontSize: 18,
                                        height: 1,
                                        color: Colors.black
                                    ),
                                    validators: [
                                      // FormBuilderValidators.maxLength(11,errorText:'شماره تلفن اشتباه است'),
                                      // FormBuilderValidators.minLength(11,errorText:'شماره تلفن اشتباه است'),
                                    ],
                                    decoration: InputDecoration(
                                        labelText: f['fieldTitle'] ?? 'عنوان',
                                        border:InputBorder.none,
                                        // hintText: f['fieldConfig']['hint'] ?? 'فیلد'
                                    ),
                                    onChanged:(val){

                                      keya.currentState.setAttributeValue(f['fieldId'].toString(), val);
                                    },
                                    attribute: 'username',
                                  ),
                                ),
                              ),
                            ),
                          );

                        case 2:
                          return  Container(
                            margin: EdgeInsets.only(top:10),
                            child: Material(
                              elevation:6,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white70,
                              child: Container(
                                width: 350,
                                child: Padding(
                                  padding: const EdgeInsets.only(right:15,left:15),
                                  child: FormBuilderDropdown(
                                    style: TextStyle(
                                        fontSize: 20,
                                        height: 1,
                                        color: Colors.black,

                                        fontFamily: PersianFonts.Vazir.fontFamily

                                    ),
                                    attribute: "gender",
                                    decoration: InputDecoration(labelText: f['fieldTitle'], border:InputBorder.none,),
                                    // initialValue: 'Male',
                                    hint: Typo(text:f['fieldConfig']['hint'] ?? 'انتخاب کنید'),
                                    validators: [FormBuilderValidators.required()],
                                    items:f['fieldConfig']['items']
                                        .map<DropdownMenuItem>((item) =>
                                        DropdownMenuItem(
                                            onTap:(){
                                              keya.currentState.setAttributeValue(f['fieldId'].toString(), item['title']);
                                              // f.onSelect(gender);
                                            } ,
                                            value: item['title'],
                                            child:Typo(text:item['title'])
                                        )
                                    ).toList(),
                                  ),

                                ),
                              ),
                            ),
                          );

                        case 3:
                          return  Container(
                            margin: EdgeInsets.only(top:10),
                            child: Material(
                              elevation:6,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Colors.white70,
                              child: Container(
                                  width: 350,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right:15,left:15),
                                    child: FormBuilderRadioGroup(
                                      orientation: GroupedRadioOrientation.wrap,
                                      decoration:
                                      InputDecoration(labelText: 'My chosen language'),
                                      attribute: 'best_language',
                                      onChanged: (val){
                                        keya.currentState.setAttributeValue(f['fieldId'].toString(),val);
                                      },
                                      validators: [FormBuilderValidators.required()],
                                      options: f['fieldConfig']['items']
                                          .map<FormBuilderFieldOption>((item) => FormBuilderFieldOption(
                                        value: item['title'],
                                        child: Text(item['title']),
                                      ))
                                          .toList(growable: false),
                                    ),
                                  )

                              ),
                            ),
                          );



                      }}).toList(),

                  ),
                ),
                Container(

                  margin: EdgeInsets.only(top:15),
                  child: Touchable(
                    caption:'ثبت',
                    onPress:(){
                      var form=keya.currentState.value;

                      if (keya.currentState.validate()) {


                        onSubmit(keya.currentState.value);

                      }
                    },
                  ),
                )
              ],
            ),
          ),

        ));


  }
}