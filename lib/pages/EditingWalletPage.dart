import 'package:flutter/material.dart';
import '../Wallet.dart';

class EditingWalletPage extends StatefulWidget {
  final Wallet wallet;
  EditingWalletPage(this.wallet);
  @override
  State<StatefulWidget> createState() => EditingWalletPageState(wallet);
}

class EditingWalletPageState extends State<EditingWalletPage> {
  final Wallet wallet;

  EditingWalletPageState(this.wallet);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name;
  double amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Editing Wallet Page")),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(6.0) + EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_balance_wallet),
                        labelText: "Wallet name",
                            ),
                    initialValue: wallet.name,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Name is Required';
                      } else return null;
                    },
                    onSaved: (String value) {
                      name = value;
                    },
                  )),
              Container(
                  padding: EdgeInsets.all(6.0) + EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Wallet amount",
                        prefixIcon: Icon(Icons.keyboard)
                            ),
                    initialValue: wallet.amount.toString(),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Amount is Required';
                      } else if (double.tryParse(value) == null) {
                        return 'Amount should be number';
                      } else if (double.parse(value) < 0.0) {
                        return 'Amount should be more than 0';
                      } else return null;
                    },
                    onSaved: (String value) {
                      amount = double.parse(value);
                    },
                  )),
              Container(
                  padding: EdgeInsets.all(6.0),
                  child: Align(
                      child: ButtonTheme(
                        height: 40.0,
                        buttonColor: Colors.grey[300],
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                            child: Text(
                              'Submit',
                            ),
                            onPressed: () {
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              _formKey.currentState.save();
                              final Wallet result = Wallet(name, amount);
                              Navigator.pop(context, result);
                            },
                          )
                      )
                  )
              )
            ],
          ),
        ));
  }
}
