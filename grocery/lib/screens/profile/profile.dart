import 'package:flutter/material.dart';
import 'package:grocery/providers/login_provider.dart';
import 'package:grocery/providers/user_info.dart';
import 'package:grocery/screens/address/address_scree.dart';
import 'package:grocery/utilities/color.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserData>(context, listen: false).getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserData>(
      builder: (context, value, _) => Scaffold(
        appBar: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          title: Text(
            'My Account',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleTile(icon: Icons.person, title: 'Info'),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name : Akshay Asok',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Phone : 73562205556',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                titleTile(icon: Icons.house, title: 'Address'),
                addressBock(
                  name: 'Name',
                  phone: '7394885003',
                  address: 'SreeeHari Decent jn po Kollam',
                ),
                addressBock(
                  name: 'Name',
                  phone: '7394885003',
                  address: 'SreeeHari Decent jn po Kollam',
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 2,
                    color: primaryColor,
                    child: FlatButton(
                      child: Text(
                        '+ Add a new address',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddressScreen(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListTile titleTile({IconData icon, String title}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Icon(
        icon,
        color: primaryColor,
      ),
    );
  }

  SizedBox addressBock({String name, address, phone}) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        color: Colors.grey[50],
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                height: 1.4,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              address,
              style: TextStyle(height: 1.4),
            ),
            Text(
              phone,
              style: TextStyle(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
