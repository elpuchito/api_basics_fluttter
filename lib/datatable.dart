/// Flutter code sample for Table

// This sample shows a `Table` with borders, multiple types of column widths and different vertical cell alignments.

import 'package:flutter/material.dart';

var myMap = {
  "id": 1,
  'name': 'Energia SA',
  "type": "my type",
  "client_name": "John",
  "website": "john.com",
  "creation_time": "2019-03-12T22:00:00.000Z",
  "proyectos": [
    {
      "id": 1,
      'title': 'planta en chile',
      'facturacion': 12,
      'costos-operativos': 43,
      'numero-de-operarios': 343,
    },
    {
      "id": 1,
      'title': 'planta en chile',
      'facturacion': 156,
      'costos-operativos': 678,
      'numero-de-operarios': 6969,
    }
  ]
};

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children:
              // <TableRow>[
              //   TableRow(
              //     children: <Widget>[
              //       Container(
              //         height: 32,
              //         color: Colors.green,
              //       ),
              //       TableCell(
              //         verticalAlignment: TableCellVerticalAlignment.top,
              //         child: Container(
              //           height: 32,
              //           width: 32,
              //           color: Colors.red,
              //         ),
              //       ),
              //       Container(
              //         height: 64,
              //         color: Colors.blue,
              //       ),
              //     ],
              //   ),
              // ],
              (myMap['proyectos'] as List)
                  .map((item) => TableRow(children: [
                        Text(item['id'].toString()),
                        Text(item['facturacion'].toString()),
                        Text(item['costos-operativos'].toString()),
                        Text(item['numero-de-operarios'].toString()),
                        // you can have more properties of course
                      ]))
                  .toList()),
    );
  }
}
