import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gopaaudit/database/database_table.dart';
import 'package:gopaaudit/helpers/utilities.dart';
import 'package:gopaaudit/widgets/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'checklistView.dart';
import 'newhome.dart';

class GOPACheckList extends StatefulWidget {
  // final String conductedBy;
  // final String stationName;
  // final String groundHandler;
  // final String dtofAudit;
  //const GOPACheckList({Key? key, required this.conductedBy, required this.stationName, required this.groundHandler, required this.dtofAudit}) : super(key: key);
  const GOPACheckList({Key? key}) : super(key: key);
  @override
  State<GOPACheckList> createState() => _GOPACheckListState();
}

class _GOPACheckListState extends State<GOPACheckList> {
  DatabaseHelper db = DatabaseHelper();
  List checkListObj = [];
  int sno = 0;

  var conductedBy;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      setDraftObj();
    });
    print(Utilities.draftList.length);
  }
  setDraftObj()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    var empNumber = pref.getString('employeeCode');
    Utilities.draftList.clear();
    var draftObjdb = await db.getGOPADraftAudits(empNumber);
    setState(() {
      Utilities.draftList = draftObjdb;
    });


    // for (int i = 0; i < draftObjdb.length; i++) {
    //   var draftList = {};
    //   draftList['stationName'] = draftObjdb[i]['stationAirport'];
    //   draftList['auditID'] = draftObjdb[i]['auditID'];
    //   draftList['gghName'] = draftObjdb[i]['groundHandler'];
    //   draftList['auditDate'] = draftObjdb[i]['auditDate'];
    //   draftList['auditDoneby'] = draftObjdb[i]['conductAudi'];
    //   draftList['airlineIDs'] = draftObjdb[i]['airlineIds'];
    //   draftList['statusid'] = draftObjdb[i]['Statusid'];
    //   if (draftObjdb[i]['Statusid'] == "1") {
    //     draftList['statusName'] = "Draft";
    //   }
    //   draftList['auditNumber'] = draftObjdb[i]['auditNumber'];
    //   setState(() {
    //     Utilities.draftList.add(draftList);
    //   });
    // }

    print('9999999999999999999999999999999999999');
    print(Utilities.draftList);
    print('99999999999999999999999999999999999999');

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Draft Audits"),
        centerTitle: true,
        backgroundColor: Color(0xFFf5003a),
      ),
      backgroundColor: Color(0xFFe7e7e7),
      body: Container(
        child: Utilities.draftList.isEmpty?Center(
          child: Text('No Data',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
        ):ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: Utilities.draftList.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                    children: [
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(15),
                          1: FlexColumnWidth(10)
                        },
                        children: [
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "AuditId",
                                      style: TextStyle(color: Colors.white, fontSize: textSize),
                                    ))),
                            TableCell(
                                child:Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(Utilities.draftList[index]
                                    ['auditID'],style: TextStyle(color: Colors.white, fontSize: textSize)))),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text("Station Name",
                                        style: TextStyle(color: Colors.white, fontSize: textSize)))),
                            TableCell(
                                child:Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(Utilities.draftList[index]
                                    ['stationName'],style: TextStyle(color: Colors.white, fontSize: textSize)))),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text("GroundHandler Name",
                                        style: TextStyle(color: Colors.white, fontSize: textSize)))),
                            TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(Utilities.draftList[index]
                                    ['gghName'],style: TextStyle(color: Colors.white, fontSize: textSize)))),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "Name of person conducting audit ",
                                        style: TextStyle(color: Colors.white, fontSize: textSize)))),
                            TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(Utilities.draftList[index]
                                    ['auditID'],style: TextStyle(color: Colors.white, fontSize: textSize)))),
                          ]),
                          TableRow(children: [
                            TableCell(
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),

                                    child: Text("Status ",
                                        style: TextStyle(color: Colors.white, fontSize: textSize)))),
                            TableCell(
                                child:Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(Utilities.draftList[index]
                                    ['statusName'],style: TextStyle(color: Colors.white, fontSize: textSize)))),
                          ]),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(8),
                              primary: red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () async {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>GopaAuditHomePage(type:"draft", groundHandler: Utilities.draftList[index]['groundHandler'].toString(), conductedBy: Utilities.draftList[index]['conductAudit'].toString(), auditDate: Utilities.draftList[index]['auditDate'].toString(), stationName: Utilities.draftList[index]['stationAirport'].toString(), auditId: Utilities.draftList[index]['auditID'].toString(),airlineId:Utilities.draftList[index]['airlineIDs']) ));

                            }, child: Text("Edit",style: TextStyle(
                            color: whiteColor, fontSize: textSize),)

                        ),
                      )
                    ]
                ),

              );
            }),
      ),

      /*child: DataTable(
              headingRowColor:
                  MaterialStateColor.resolveWith((states) => Colors.black45),

              columns: [
                DataColumn(label: Text("S.no")),
                DataColumn(label: Text("Audit Id")),
                DataColumn(label: Text("Date of conducting audit"),

              ),DataColumn(label: Text("Station Name")),
              DataColumn(label: Text("GroundHandler Name")),
                DataColumn(label: Text("Name of person conducting audit")),
                DataColumn(label: Text("Status"))
              ],

              rows: Utilities.draftList
                  .map((item) =>
                  DataRow(cells: [
                    DataCell(Visibility(child: SizedBox(child: Text((++sno).toString()),))),
                DataCell(Visibility(child: Container(child: GestureDetector(
                  onTap: () async {
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    var  auditID= item['auditID'].toString();
                    // ApiService.get("GetGOPADataBasedonAuditID?AuditID=$auditID",pref.getString('token')).then((success){
                    //
                    // });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>GopaAuditHomePage(type:"draft", groundHandler: item['groundHandler'].toString(), conductedBy: item['conductAudit'].toString(), auditDate: item['auditDate'].toString(), stationName: item['stationAirport'].toString(), auditId: item['auditID'].toString(),) ));
                  },
                  child: Text(item['auditID'].toString()),)))),
                        DataCell(Visibility(
                            child: SizedBox(
                                child:
                                    Text(item['auditDate'].toString())))),
                        DataCell(
                            Visibility(child: SizedBox(child: Text(item['stationName'].toString())))),
                DataCell(Visibility(child: SizedBox(child: Text(item['gghName'].toString()),))),
                DataCell(Visibility(child: SizedBox(child: Text(item['auditDate'].toString()),))),
                DataCell(Visibility(child: SizedBox(child: Text(item['statusName'].toString()),)))
                      ])
              )
                  .toList()),*/
    );
  }
}
