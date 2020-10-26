import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:hive/hive.dart';
import 'package:load/load.dart';

import 'package:testapp/Components/Forma.dart';
import 'package:testapp/Components/Loada.dart';
import 'package:testapp/Components/Typo.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:testapp/Redux/FieldState/FieldsActions.dart';
import 'dart:convert';
import 'package:testapp/main.dart';
import 'package:testapp/Hive/Hive.dart';

import 'package:testapp/Dio/Dio.dart';
import 'package:testapp/Redux/Redux.dart';

final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

class AddRecord extends HookWidget {
  List<DataField> fields = [];

  @override
  Widget build(BuildContext context) {
    final fields = useState([]);
    final Size size = MediaQuery.of(context).size;



    final request=()async{
      try{
        // showCustomLoadingWidget(
        //     Loada()
        // );
        EasyLoading.show(status: 'loading...');
        var data=await Dia.get('formData');

        final parsed = json.decode(data.toString());
        fields.value=parsed['data'];

      }catch(e){
        Navigator.of(context).pop();
      }
      // hideLoadingDialog();
      EasyLoading.dismiss();
    };



    useEffect((){

      request();


    },[]);




    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Typo(
                color: Colors.white,
                text: 'Add New Record',
                bold: true,
                size: 20,
              ),
            ),
            body: Container(
                height: size.height,
                child: StoreConnector(
                  converter: (store) {
                    return (e) => store.dispatch(AddData(entry:e ));
                  },
                  builder: (ctx,clb){
                    return  Forma(
                        fields: fields.value,
                        keya: _fbKey,
                        formTitle: 'لطفا اطلاعات مورد نظر را وارد کنید',
                        onSubmit: (values)async {

                          // showCustomLoadingWidget(
                          //     Loada()
                          // );
                          EasyLoading.show(status: 'loading...');

                          var box =  Hive.box<HiveEntry>('records');
                          //
                          // Map <String,dynamic> g=values;
                          List<HiveRecord> records=[];
                          List<Record> normalRecords=[];
                          Entry entry;


                          values.forEach((i,j){

                            records.add(HiveRecord(field:i,value:j));
                            normalRecords.add(Record(fieldId:int.parse(i),value:j));

                          });

                          // box.put(DateTime.now().toString(),entry);

                          //
                          entry = Entry(records: normalRecords);
                          HiveEntry hiveEntry=HiveEntry(name:DateTime.now().toString(),entry: records);
                          //
                          box.add(hiveEntry);
                          // hiveEntry.save();
                          // box.close();

                          clb(entry);

                          EasyLoading.dismiss();
                          // hideLoadingDialog();
                          Navigator.of(context).pop();
                          // var entry=Entry()
                          //

                        });
                  },

                ))));
  }
}
