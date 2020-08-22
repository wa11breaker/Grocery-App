import 'package:admin/models/deliveryboy_model.dart';
import 'package:admin/provider/delivery_boy.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Delivered extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('orders')
            .where('orderStatus', isEqualTo: 'ORDER-DELIVERED')
            .limit(25)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data == null || snapshot.data.documents.length == 0) {
              return Center(child: Text('No Records'));
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
          DataColumn(
            label: Text("D-Boy"),
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
                  DataCell(
                    Text(
                      Provider.of<DeliveryBoyProvider>(context, listen: false)
                          .deliveryBoy
                          .firstWhere(
                            (element) => element.id == e['dbID'],
                            orElse: () => DeliveryBoyModle(name: ''),
                          )
                          .name,
                    ),
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Order Detailes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 8,
              ),
              ...data['orderItems']
                  .map(
                    (e) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(e['image']),
                      ),
                      title: Text(
                        e['title'],
                      ),
                      subtitle: Row(
                        children: [
                          Text('Price ₹${e['price']}'),
                          SizedBox(
                            width: 16,
                          ),
                          Text('Quandity ${e['quandity']}'),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              SizedBox(
                height: 16,
              ),
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
              )
            ],
          ),
        );
      },
    );
  }
}
