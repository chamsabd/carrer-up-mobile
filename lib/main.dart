import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import './Formation.dart';

//import 'package:flutter_project_test/otherDetails.dart';
import 'package:http/http.dart' as http;

import 'getSessions.dart';

//import 'CustomDialog.dart';
//listes formations
List<Formation> _formations = [];

void main() {
  runApp(const SessionsMain());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int p = 0;

//   ///final String url = 'http://192.168.1.19:8085/FORMATION-SERVER/formations';
//   final String url = 'http://192.168.1.7:8085/FORMATION-SERVER/formations';

//   bool loading = true;
//   late Future<List<Formation>> futurePersons;
//   @override
//   void initState() {
//     super.initState();
//     futurePersons = fetchFormations();
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   Future<List<Formation>> fetchFormations() async {
//     var response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       log(jsonDecode(response.body)["content"].toString());
//       debugPrint(jsonDecode(response.body)["content"].toString());

//       final parsed = json.decode(response.body)["content"] as List;
//       _formations =
//           parsed.map<Formation>((json) => Formation.fromJson(json)).toList();

//       log(_formations.toString());
//       p++;
//       log(p.toString());
//       return _formations;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   /// Set default number of rows to be displayed per page
//   var _rowsPerPage = 3;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SafeArea(
//         child: PaginatedDataTable(
//           rowsPerPage: _rowsPerPage,
//           source: RowSource(),
//           onPageChanged: (int? n) {
//             /// value of n is the number of rows displayed so far
//             setState(() {
//               if (n != null) {
//                 debugPrint(
//                     'onRowsPerPageChanged $_rowsPerPage ${RowSource()._rowCount - n}');

//                 /// Update rowsPerPage if the remaining count is less than the default rowsPerPage
//                 if (RowSource()._rowCount - n < _rowsPerPage)
//                   _rowsPerPage = RowSource()._rowCount - n;

//                 /// else, restore default rowsPerPage value
//                 else
//                   _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
//               } else
//                 _rowsPerPage = 0;
//             });
//           },
//           columns: [
//             DataColumn(
//               label: Text('ID'),
//               numeric: true,
//               /* onSort: ((columnIndex, ascending) {
//                _sort<num>((formation) => formation.id, columnIndex, asc, _src, _provider);
//             })
//             */
//             ),
//             DataColumn(label: Text('nomFormation')),
//             DataColumn(label: Text('date_Debut')),
//             DataColumn(label: Text('Date-fin')),
//             //  DataColumn(label: Text('Details')),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           selectedItemColor: Colors.blue[700],
//           selectedFontSize: 13,
//           unselectedFontSize: 13,
//           iconSize: 30,
//           items: [
//             BottomNavigationBarItem(
//               label: "Formations",
//               icon: Icon(Icons.home),
//             ),
//             BottomNavigationBarItem(
//               label: "Comptes",
//               icon: Icon(Icons.account_circle_outlined),
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//           elevation: 5),
//     );
//   }

//   int _selectedIndex = 0;
// }
// // void _onItemTapped(int index) {
// //     setState(() {

// //     });
// //   }
// class RowSource extends DataTableSource {
//   //List<Formation> _formations = fetchFormations();
//   //bool loading = true;
//   final _rowCount = 26;

//   BuildContext get context => context;

//   @override
//   DataRow? getRow(int index) {
//     Formation todo = _formations[index];
//     log(todo.toString());
//     log(_formations.length.toString());
//     //_formations = fetchFormations();
//     if (index < _rowCount) {
//       return DataRow.byIndex(index: index, cells: <DataCell>[
//         DataCell(Text("${_formations[index].id}")),
//         DataCell(Text("${_formations[index].nom!}")),
//         DataCell(Text("${_formations[index].dateDebut}")),
//         DataCell(Text("${_formations[index].dateFin}")),
//         /*DataCell(IconButton(
//             hoverColor: Colors.transparent,
//             splashColor: Colors.transparent,
//             icon: const Icon(Icons.details),
//             onPressed: () {
//               //log(index.toString());
//             }))
//             */
//       ]);
//     } else {
//       return null;
//     }
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => _formations.length;

//   @override
//   int get selectedRowCount => 0;

// /*   void sort<T>(Comparable<T> Function(Formation f), getField, bool ascending) {
//     _formations.sort((a, b) {
//       final aValue = getField(a);
//       final bValue = getField(b);
//       return ascending
//           ? Comparable.compare(aValue, bValue)
//           : Comparable.compare(bValue, aValue);
//     });
//     notifyListeners();
//   } */
// }
