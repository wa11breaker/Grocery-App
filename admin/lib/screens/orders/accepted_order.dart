import 'package:admin/models/deliveryboy_model.dart';
import 'package:admin/provider/delivery_boy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Accepted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('orders')
            .where('orderStatus', isEqualTo: 'ORDER-ACCEPTED')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null || snapshot.data.documents.length == 0) {
              return Center(child: Text('No New Accepted Orders'));
            } else {
              return buildDataTable(snapshot.data.documents, context);
            }
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildDataTable(List<DocumentSnapshot> data, context) {
    return SingleChildScrollView(
      child: DataTable(
        showCheckboxColumn: false,
        columns: [
          DataColumn(
            label: Text("Order ID"),
            numeric: false,
          ),
          DataColumn(
            label: Text("Payment"),
            numeric: false,
          ),
          DataColumn(
            label: Text("Customer Phone"),
            numeric: false,
            // tooltip: "This is Last Name",
          ),
          DataColumn(
            label: Text("Customer Name"),
            numeric: false,
          ),
          DataColumn(
            label: Text("Customer Address"),
            numeric: false,
          ),
          DataColumn(
            label: Text("Time Slot"),
            numeric: false,
          ),
        ],
        rows: data
            .map(
              (e) => DataRow(
                // selected: selecteddatas.contains(data),
                onSelectChanged: (b) => _showMyDialog(context, e),
                cells: [
                  DataCell(
                    Text(e['orderId']),
                  ),
                  DataCell(
                    e['cod'] ? Text('COD') : Text('ONLINE'),
                  ),
                  DataCell(
                    Text(e['phone']),
                  ),
                  DataCell(
                    Text(e['name']),
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 130),
                      child: Text(e['orderAddress']),
                    ),
                  ),
                  DataCell(
                    Text(e['deliveryTime']),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context, data) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            content: AssignOrderDilogeBox(
          data: data,
        ));
      },
    );
  }
}

class AssignOrderDilogeBox extends StatefulWidget {
  final DocumentSnapshot data;

  const AssignOrderDilogeBox({Key key, this.data}) : super(key: key);
  @override
  _AssignOrderDilogeBoxState createState() => _AssignOrderDilogeBoxState();
}

class _AssignOrderDilogeBoxState extends State<AssignOrderDilogeBox> {
  DeliveryBoyModle boyModle = DeliveryBoyModle();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Order Detailes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text('Assign order to'),
            SizedBox(width: 16),
            Consumer<DeliveryBoyProvider>(
              builder: (context, value, _) => DropdownButton<String>(
                // value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  // boyModle = value.deliveryBoy
                  //     .firstWhere((element) => element.id == newValue);
                },
                value: boyModle.name == null ? null : boyModle.name,
                hint: Text('Select form dropdown'),
                items: value.deliveryBoy.map<DropdownMenuItem<String>>(
                  (DeliveryBoyModle dBoy) {
                    return DropdownMenuItem<String>(
                      value: dBoy.name,
                      child: Text(dBoy.name),
                      onTap: () {
                        setState(() {
                          boyModle = dBoy;
                        });
                      },
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlatButton(
              onPressed: () async {
                await Firestore.instance
                    .collection('orders')
                    .document(widget.data.documentID)
                    .updateData({
                  'orderStatus': 'ORDER-ASSIGNED',
                  'dbID': boyModle.id,
                }).then(
                  (value) => Navigator.of(context).pop(),
                );
              },
              child: Text(
                'Assign Orders',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            /*FlatButton(
                    onPressed: () async {
                      await Firestore.instance
                          .collection('orders')
                          .document(data.documentID)
                          .updateData({'orderStatus': 'ORDER-REJECTED'}).then(
                        (value) => Navigator.of(context).pop(),
                      );
                    },
                    child: Text(
                      'Reject Orders',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ), */
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
