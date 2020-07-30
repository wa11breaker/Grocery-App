import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<User> users;

  bool sort;

  @override
  void initState() {
    sort = false;
    users = User.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Card(child: buildDataTable()),
    );
  }

  DataTable buildDataTable() {
    return DataTable(
      showCheckboxColumn: false,
      columns: [
        DataColumn(
          label: Text("Order ID"),
          numeric: false,
        ),
        DataColumn(
          label: Text("Customer Phone"),
          numeric: false,
          // tooltip: "This is Last Name",
        ),
        DataColumn(
          label: Text("Customer Address"),
          numeric: false,
        ),
        DataColumn(
          label: Text("Delivery Time Slot"),
          numeric: false,
        ),
        DataColumn(
          label: Text("Assigned To"),
          numeric: false,
        ),
        DataColumn(
          label: Text("Bag ID"),
          numeric: false,
        ),
        DataColumn(
          label: Text("Delivery Status"),
          numeric: false,
        )
      ],
      rows: users
          .map(
            (user) => DataRow(
              // selected: selectedUsers.contains(user),
              onSelectChanged: (b) {},
              cells: [
                DataCell(
                  Text(user.orderID),
                  onTap: () {
                    print('Selected ${user.orderID}');
                  },
                ),
                DataCell(
                  Text(user.customerPhone),
                ),
                DataCell(
                  Text(user.customerAddress),
                ),
                DataCell(
                  Text(user.deliveryTime),
                ),
                DataCell(
                  Text(user.assignedTo),
                ),
                DataCell(
                  Text(user.bagID),
                ),
                DataCell(
                  Text(user.deliveryStatus),
                )
              ],
            ),
          )
          .toList(),
    );
  }
}

class User {
  String orderID;
  String customerPhone;
  String customerAddress;
  String deliveryTime;
  String assignedTo;
  String bagID;
  String deliveryStatus;
  User(
      {this.orderID,
      this.customerPhone,
      this.customerAddress,
      this.deliveryTime,
      this.assignedTo,
      this.bagID,
      this.deliveryStatus});

  static List<User> getUsers() {
    return <User>[
      User(
          orderID: '0001',
          customerPhone: '7356220556',
          customerAddress: 'Sreehari Decent Jn po Kollam',
          deliveryTime: '10:30 - 12:30',
          assignedTo: 'foo',
          bagID: '345',
          deliveryStatus: 'Delivered'),
      User(
          orderID: 'sdasdf',
          customerPhone: '7356220556',
          customerAddress: 'Sreehari Decent Jn po Kollam',
          deliveryTime: '10:30-12:30',
          assignedTo: 'foo',
          bagID: '345',
          deliveryStatus: 'Delivered'),
      User(
          orderID: 'sdasdf',
          customerPhone: '7356220556',
          customerAddress: 'Sreehari Decent Jn po Kollam',
          deliveryTime: '10:30 - 12:30',
          assignedTo: 'foo',
          bagID: '345',
          deliveryStatus: 'Delivered'),
      User(
          orderID: 'sdasdf',
          customerPhone: '7356220556',
          customerAddress: 'Sreehari Decent Jn po Kollam',
          deliveryTime: '10:30-12:30',
          assignedTo: 'foo',
          bagID: '345',
          deliveryStatus: 'Delivered'),
      User(
          orderID: 'sdasdf',
          customerPhone: '7356220556',
          customerAddress: 'Sreehari Decent Jn po Kollam',
          deliveryTime: '10:30-12:30',
          assignedTo: 'foo',
          bagID: '345',
          deliveryStatus: 'Delivered'),
      User(
          orderID: 'sdasdf',
          customerPhone: '7356220556',
          customerAddress: 'Sreehari Decent Jn po Kollam',
          deliveryTime: '10:30-12:30',
          assignedTo: 'foo',
          bagID: '345',
          deliveryStatus: 'Delivered'),
      User(
          orderID: 'sdasdf',
          customerPhone: '7356220556',
          customerAddress: 'Sreehari Decent Jn po Kollam',
          deliveryTime: '10:30-12:30',
          assignedTo: 'foo',
          bagID: '345',
          deliveryStatus: 'Delivered')
    ];
  }
}
