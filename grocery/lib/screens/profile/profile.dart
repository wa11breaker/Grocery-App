import 'package:flutter/material.dart';
import 'package:grocery/providers/login_provider.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:grocery/screens/address_list_screen/addresses_list_screen.dart';
import 'package:grocery/screens/profile/webViewScreen.dart';
import 'package:grocery/utilities/appStrings.dart';
import 'package:grocery/utilities/color.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
    _launchURL() async {
      const url = 'https://play.google.com/store/apps/details?id=$appBundleId';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Consumer<UserData>(
      builder: (context, value, _) => Scaffold(
        // appBar: AppBar(
        //   elevation: 3,
        //   backgroundColor: Colors.white,
        //   title: Text(
        //     'My Account',
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.accountDetailes.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      value.accountDetailes.phoneNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: Icon(
                  LineAwesomeIcons.home,
                  color: primaryColor,
                ),
                title: Text('Address'),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddressesList(),
                  ),
                ),
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: Icon(
                  LineAwesomeIcons.star_o,
                  color: primaryColor,
                ),
                title: Text('Rate This App'),
                trailing: Icon(Icons.chevron_right),
                onTap: _launchURL,
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: Icon(
                  LineAwesomeIcons.shield,
                  color: primaryColor,
                ),
                title: Text('Privacy Policy'),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewScreen(
                      tac: false,
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                leading: Icon(
                  LineAwesomeIcons.book,
                  color: primaryColor,
                ),
                title: Text('Terms And Conditions'),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewScreen(
                      tac: true,
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                onTap: () =>
                    Provider.of<LoginWithPhone>(context).signOut(context),
                leading: Icon(
                  LineAwesomeIcons.sign_out,
                  color: primaryColor,
                ),
                title: Text('Sign Out'),
                trailing: Icon(Icons.chevron_right),
              ),
              Divider(
                height: 0,
              ),

              /*     titleTile(icon: Icons.person, title: 'Info'),
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
              titleTile(icon: Icons.home, title: 'Address'),
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
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
