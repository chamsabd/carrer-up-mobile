import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_project_test/Formation.dart';

final String url = 'http://192.168.1.12:8085/FORMATION-SERVER/formations';
List<Formation> _formations = [];

bool loading = true;
late Future<List<Formation>> futurePersons;
@override
void initState() {
  //super.initState();
  futurePersons = fetchFormations();
}

Future<List<Formation>> fetchFormations() async {
  var response = await http
      .get(Uri.parse('http://192.168.1.12:8085/FORMATION-SERVER/formations'));
  if (response.statusCode == 200) {
    log(jsonDecode(response.body)["content"].toString());
    log("hjhjhjhjjjhj");
    final parsed = json.decode(response.body)["content"] as List;
    _formations =
        parsed.map<Formation>((json) => Formation.fromJson(json)).toList();

    log(_formations.toString());
    //p++;
    log(p.toString());
    return _formations;
  } else {
    throw Exception('Failed to load data');
  }
}

class tableFormation extends StatefulWidget {
   @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
  var _rowsPerPage = 3;
   Scaffold(
    PaginatedDataTable(
    rowsPerPage: _rowsPerPage,
    source: RowSource(),
    onPageChanged: (int? n) {
      /// value of n is the number of rows displayed so far
      setState(() {
        if (n != null) {
          debugPrint(
              'onRowsPerPageChanged $_rowsPerPage ${RowSource()._rowCount - n}');

          /// Update rowsPerPage if the remaining count is less than the default rowsPerPage
          if (RowSource()._rowCount - n < _rowsPerPage)
            _rowsPerPage = RowSource()._rowCount - n;

          /// else, restore default rowsPerPage value
          else
            _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
        } else
          _rowsPerPage = 0;
      });
    },
    columns: [
      DataColumn(
        label: Text('ID'),
        numeric: true,
        /* onSort: ((columnIndex, ascending) {
               _sort<num>((formation) => formation.id, columnIndex, asc, _src, _provider);
            })
            */
      ),
      DataColumn(label: Text('nomFormation')),
      DataColumn(label: Text('date_Debut')),
      DataColumn(label: Text('Date-fin')),
      //  DataColumn(label: Text('Details')),
    ],
  );

  ) 

 


 

}
class RowSource extends DataTableSource {
  //List<Formation> _formations = fetchFormations();
  //bool loading = true;
  final _rowCount = 26;

  BuildContext get context => context;

  @override
  DataRow? getRow(int index) {
    Formation todo = _formations[index];
    log(todo.toString());
    log(_formations.length.toString());
    //_formations = fetchFormations();
    if (index < _rowCount) {
      return DataRow.byIndex(index: index, cells: <DataCell>[
        DataCell(Text("${_formations[index].id}")),
        DataCell(Text("${_formations[index].nom!}")),
        DataCell(Text("${_formations[index].dateDebut}")),
        DataCell(Text("${_formations[index].dateFin}")),
        /*DataCell(IconButton(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: const Icon(Icons.details),
            onPressed: () {
              //log(index.toString());
            }))
            */
      ]);
    } else {
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _formations.length;

  @override
  int get selectedRowCount => 0;

/*   void sort<T>(Comparable<T> Function(Formation f), getField, bool ascending) {
    _formations.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  } */

}
