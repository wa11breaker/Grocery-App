import 'package:flutter/material.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:grocery/screens/address/address_scree.dart';
import 'package:grocery/utilities/color.dart';
import 'package:grocery/widgets/address_block.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
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
                          'Name : ${value.accountDetailes.name}',
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
                          'Phone : ${value.accountDetailes.phoneNumber}',
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
                for (var i in value.accountDetailes.addresses) ...[
                  AddressBlock(
                    name: i.name,
                    phone: i.phoneNumber,
                    address: i.wholeAddress(),
                    isDefault: i.isDefault,
                  )
                ],
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      '+ Add a new address',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddressScreen(),
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
}
