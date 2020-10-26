import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:load/load.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testapp/Components/FlashBar.dart';
import 'package:testapp/Components/Loada.dart';
import 'package:testapp/Components/Typo.dart';
import 'package:hive/hive.dart';
import 'package:testapp/Dio/Dio.dart';
import 'package:testapp/Redux/FieldState/FieldsActions.dart';
import 'package:testapp/Redux/Redux.dart';
import 'package:testapp/Hive/Hive.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends HookWidget {


  @override
  Widget build(BuildContext context) {

    final visible = useState(false);


    fetchFromHive()async{

      // showCustomLoadingWidget(
      //    Loada()
      // );
      EasyLoading.show(status: 'loading...');

     try{
       var box= Hive.box<HiveEntry>('records');

       var length=box.length;


       List<Entry> entries=[];


       // print(length);
       for (var i = 0; i < length; i++) {

         List<Record> records=[];
         // print(box.getAt(i).entry);
         var hiveEnt=box.getAt(i).entry;


         hiveEnt.forEach((t){
           records.add(Record(fieldId:int.parse(t.field),value:t.value ));
         });


         entries.add(Entry(records: records));

       }

       print(entries);

       DataState data=DataState(entries:entries);
       // print(data);


       reduxStore.dispatch(SetData(data:data));
     }catch(e){
      print(e);
     }
      EasyLoading.dismiss();
      // hideLoadingDialog();
    };

    convertToExcel()async{

      EasyLoading.show(status: 'loading...');

      // showCustomLoadingWidget(
      //   Loada()
      // );

     try{
       CellStyle cellStyle = CellStyle(
         bold: false,
         italic: false,
         fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
       );
       var excel = Excel.createExcel();
       var sheet = excel['mySheet'];


       var box= Hive.box<HiveEntry>('records');

       var length=box.length;


       List<Entry> entries=[];


       // print(length);
       for (var i = 0; i < length; i++) {

         List<Record> records=[];
         // print(box.getAt(i).entry);
         var hiveEnt=box.getAt(i).entry;

         List alphabet = ['A','B','C','D','E','F','G','H'];

         hiveEnt.asMap().forEach((index,record){
           var cell = sheet.cell(CellIndex.indexByString("${alphabet[index]}${i+1}"));
           cell.value = record.value;
           cell.cellStyle = cellStyle;
           // records.add(Record(fieldId:int.parse(t.field),value:t.value ));

         });


         entries.add(Entry(records: records));

       }






       Directory document=await getApplicationDocumentsDirectory();
       excel.encode().then((onValue) {
         File(join("${document.path}/excel.xlsx"))
           ..createSync(recursive: true)
           ..writeAsBytesSync(onValue);
       });

       FormData formData = new FormData.fromMap({
         "file":await MultipartFile.fromFile("${document.path}/excel.xlsx")
       });

       var res = await Dia.post('uploadExcel',data: formData);

       Flash(context,Typo(text:'Operation succeeded',color:Colors.black,size:15,bold:true), Color.fromRGBO(26, 186, 138, 1));

     }catch(e){
       Flash(context,Typo(text:'Operation failed',color:Colors.black,size:15,bold:true), Colors.redAccent);
      print(e);
     }

      // hideLoadingDialog();

      EasyLoading.dismiss();
    };

      useEffect((){
        fetchFromHive();
      },[]);


    return SafeArea(
        child: Container(
          child: Scaffold(
            appBar: AppBar(

              centerTitle: true,
                // leading: GestureDetector(
                //   onTap: convertToExcel,
                //   child: Icon(
                //     Icons.upload_file,  // add custom icons also
                //   ),
                // ),
                title:Typo(text:'Records',bold: true,size:20,color: Colors.white,)
            ),
            body: StoreConnector(
              converter: (store) {

                return store.state.dataState.entries;
              },
              builder: (ctx, entries) {

                return ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (ctx, index) {
                      // print(entries[index].records);
                      return Card(
                        elevation: 6,
                        margin: EdgeInsets.all(5),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                              children: entries[index].records.map<Widget>((r){
                                return Container(
                                  decoration: BoxDecoration(
                                    border:Border(bottom:BorderSide(
                                      width: 0.5,
                                      color:Colors.grey
                                    ))
                                  ),
                                    margin:EdgeInsets.symmetric(horizontal: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Typo(text:recordTitle[r.fieldId-1] ?? 'no name'),
                                        Typo(text:r.value)
                                      ],
                                    ));
                              }).toList()
                          ),
                        ),
                      );
                    });
              },
            ),
            floatingActionButton: SpeedDial(
              // both default to 16
              marginRight: 18,
              marginBottom: 20,
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData(size: 22.0),
              // this is ignored if animatedIcon is non null
              // child: Icon(Icons.add),
              // visible: visible.value,
              // If true user is forced to close dial manually
              // by tapping main button and overlay is not rendered.
              closeManually: false,
              curve: Curves.bounceIn,
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              onOpen: () => print('OPENING DIAL'),
              onClose: () => print('DIAL CLOSED'),
              tooltip: 'Speed Dial',
              heroTag: 'speed-dial-hero-tag',
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 8.0,
              shape: CircleBorder(),
              children: [
                SpeedDialChild(
                    child: Icon(Icons.add),
                    backgroundColor: Colors.red,
                    label: 'Add new data',
                    labelStyle: TextStyle(fontSize: 18.0),
                    onTap: () => Navigator.pushNamed(context, '/addRecord')
                ),
                SpeedDialChild(
                  child: Icon(Icons.upload_file),
                  backgroundColor: Colors.blue,
                  label: 'Upload excel file',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () => convertToExcel(),
                ),

              ],
            ),// This trailing comma ma
          ),
    ));
  }
}
