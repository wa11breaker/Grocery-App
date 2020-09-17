import 'package:flutter/material.dart';
import 'package:grocery/models/account_details.dart';
import 'package:grocery/providers/user_data.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';

class AddressBlock extends StatelessWidget {
  final Address address;
  final bool deleteOption;

  const AddressBlock({Key key, this.address, this.deleteOption = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.grey[50],
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    address.name,
                    style: TextStyle(
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        address.type == 'AddressType.home'
                            ? 'Home'
                            : address.type == 'AddressType.work'
                                ? 'Work'
                                : 'Other',
                      ),
                    ),
                  ),
                  Spacer(),
                  if (deleteOption)
                    IconButton(
                      tooltip: 'Delete',
                      icon: Icon(
                        LineAwesomeIcons.remove,
                        size: 18,
                      ),
                      onPressed: () =>
                          Provider.of<UserData>(context, listen: false)
                              .deleteAddress(address: address),
                    )
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                address.wholeAddress(),
                style: TextStyle(
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                address.phoneNumber,
                style: TextStyle(height: 1.4, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
