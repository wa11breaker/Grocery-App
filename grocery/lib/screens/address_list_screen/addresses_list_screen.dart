import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:grocery/screens/add_new_address/address_screen.dart';
import 'package:grocery/utilities/color.dart';
import 'package:grocery/widgets/address_block.dart';
import 'package:provider/provider.dart';

class AddressesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'My Addresses',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<UserData>(
            builder: (context, value, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressScreen(),
                    ),
                  ),
                  child: Card(
                    child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 18, 40, 18),
                        child: Text(
                          '+ Add a new address',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 0, 8),
                  child: Text(
                    '${value.accountDetailes.addresses.length} saved address',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                for (var i in value.accountDetailes.addresses) ...[
                  AddressBlock(
                    address: i,
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
