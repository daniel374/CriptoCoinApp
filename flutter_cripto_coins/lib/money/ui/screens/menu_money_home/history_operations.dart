import 'package:flutter/material.dart';
import 'package:flutter_cripto_coins/widgets/gradient_back.dart';

class OperationItem {
  final String name;
  final double valor;

  OperationItem(this.name, this.valor);
}
//Definimos los valores de la lista
final List<OperationItem> _operationList = <OperationItem>[
  OperationItem("Equilibrar:", 0),
  OperationItem("Beneficio:", 0),
  OperationItem("Depósito:", 0),
  OperationItem("Retirada de dinero", 0),
];

class HistoryOperations extends StatefulWidget {


  @override
  State createState() {
    return _HistoryOperations();
  }
}

class _HistoryOperations extends State<HistoryOperations> {


  @override
  Widget build(BuildContext context) {
    return historyOperations();
  }

  Widget historyOperations(){
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
      ),
      body: Stack(
        children: [
          GradientBack(height: null,),
          DataTable(
          columns: <DataColumn>[
            DataColumn(
                label: Text('Operación',
                  style: TextStyle(
                      fontSize: 17.0,
                      fontFamily: "Lato",
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
                tooltip:"Operación"
            ),
            DataColumn(
              label: const Text('valor',
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: "Lato",
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              tooltip: 'valor',
              numeric: true,
            ),
          ],
          rows: _operationList.map<DataRow>((OperationItem operationItem) {
            return DataRow(
                key: Key(operationItem.name),
                //onSelectChanged: (bool selected) {},
                cells: <DataCell>[
                  DataCell(
                    Text(operationItem.name,
                      style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Lato",
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  DataCell(
                    Text('${operationItem.valor}',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: "Lato",
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                  )
                ]
            );
          }).toList(),
        ),
      ],
      ),
    );


  }
}



