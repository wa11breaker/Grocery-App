import 'package:admin/services/send_message.dart';
import 'package:admin/utilities/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NewOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('orders')
              .where('orderStatus', isEqualTo: 'ORDER-PLACES')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data == null ||
                  snapshot.data.documents.length == 0) {
                return Center(child: Text('No New Orders'));
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
            // return buildDataTable();
          },
        ),
      ),
      floatingActionButton: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  spreadRadius: 5,
                  blurRadius: 10,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Add Orders',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
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
              (data) => DataRow(
                // selected: selecteddatas.contains(data),
                onSelectChanged: (b) {
                  _showMyDialog(context, data);
                },
                cells: [
                  DataCell(
                    Text(data['orderId']),
                  ),
                  DataCell(
                    data['cod'] ? Text('COD') : Text('ONLINE'),
                  ),
                  DataCell(
                    Text(data['phone']),
                  ),
                  DataCell(
                    Text(
                      data['name'],
                    ),
                  ),
                  DataCell(
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 130),
                      child: Text(
                        data['orderAddress'],
                      ),
                    ),
                  ),
                  DataCell(
                    Text(data['deliveryTime']),
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
              SingleChildScrollView(
                child: Column(
                  children: [
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
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatButton(
                    onPressed: () async {
                      await Firestore.instance
                          .collection('orders')
                          .document(data.documentID)
                          .updateData({'orderStatus': 'ORDER-ACCEPTED'}).then(
                              (value) {
                        sendSMS(
                          status: 'approved',
                          name: data['name'],
                          phone: data['phone'].toString().substring(2),
                          orderID: data['orderId'],
                        );
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(
                      'Accept Orders',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await Firestore.instance
                          .collection('orders')
                          .document(data.documentID)
                          .updateData({'orderStatus': 'ORDER-REJECTED'}).then(
                              (value) {
                        sendSMS(
                          status: 'approved',
                          name: data['name'],
                          phone: data['phone'].toString().substring(2),
                          orderID: data['orderId'],
                        );
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(
                      'Reject Orders',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
