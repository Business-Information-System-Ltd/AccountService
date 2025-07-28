import 'dart:io';
import 'dart:convert';
import 'package:accountservice/views/apiservices.dart';
import 'package:accountservice/views/data.dart';
import 'package:accountservice/views/table.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class AccountFormScreen extends StatefulWidget {
  @override
  _AccountFormScreenState createState() => _AccountFormScreenState();
}

class _AccountFormScreenState extends State<AccountFormScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0;
  final _accountCodeController = TextEditingController();
  final _accountNameShortController = TextEditingController();
  final _accountNameController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  List<String> _selectedCurrencies = [];

  String? _selectedAccountType;
  String? _selectedCurrency;

  bool isOffBalanceSheetChecked = false;
  bool isBankAccountChecked = false;
  bool isAccountStatusChecked = false;
  bool isMultiCurrencyChecked = false;

  bool isOffBalanceSheetEnabled = false;
  bool isBankAccountEnabled = false;
  //bool isMultiCurrencyEnabled = false;
  final List<String> accountTypes = [
    'Asset',
    'Liability',
    'Equity',
    'Revenue',
    'Expense',
  ];

  final List<String> currencies = ['USD', 'MMK', 'SGD', 'THB'];

  @override
  void initState() {
    super.initState();
  }

  void _onAccountTypeChanged(String? value) {
    setState(() {
      _selectedAccountType = value;

      isOffBalanceSheetEnabled = value == 'Asset' || value == 'Liability';
      isBankAccountEnabled = value == 'Asset';

      if (!isOffBalanceSheetEnabled) isOffBalanceSheetChecked = false;
      if (!isBankAccountEnabled) isBankAccountChecked = false;
      
      // if (value != 'Asset') _selectedCurrency = null;
    });
  }

  @override
  void dispose() {
    _accountCodeController.dispose();
    _accountNameShortController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  Widget buildSlantedTab(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = label == "Account" ? 0 : 1;
        });
      },
      child: ClipPath(
        clipper: TrapezoidClipper(),
        child: Container(
          color: isSelected ? Colors.blue[300] : Colors.blue[100],
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 210, 225, 240),
      body: Center(
        child: Form(
          key: _formkey,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 1.2,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 130, 175, 190),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    buildSlantedTab("Account", _selectedTabIndex == 0),
                    SizedBox(width: 4),
                    buildSlantedTab("Dimensions", _selectedTabIndex == 1),
                  ],
                ),
                //SizedBox(height: 5,),
                Container(height: 1, color: Colors.black),
                SizedBox(height: 10),
                Expanded(
                  child: _selectedTabIndex == 0
                      ? _buildAccountTab()
                      : MyDimensionState(),
                      // : Center(
                      //     child: Text("Account Dimensions (Not implemented)"),
                      //   ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTextField("Account_Code", _accountCodeController),
              ),
              SizedBox(width: 50),
              Expanded(
                child: _buildTextField(
                  "Account_Name_Short",
                  _accountNameShortController,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildTextField("Account_Name", _accountNameController),
          SizedBox(height: 12),
          Container(
            color: Color.fromARGB(255, 130, 204, 238),
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.2,
            // margin: EdgeInsets.all(4),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Account_Type: "),
                      SizedBox(width: 8),
                      DropdownButton<String>(
                        value: _selectedAccountType,
                        hint: const Text("Select Type"),
                        items: accountTypes
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                            
                        onChanged: _onAccountTypeChanged,
                      ),
                      SizedBox(width: 206),
                      Checkbox(
                        value: isOffBalanceSheetChecked,
                        onChanged: isOffBalanceSheetEnabled
                            ? (val) => setState(
                                () => isOffBalanceSheetChecked = val ?? false,
                              )
                            : null,
                      ),
                      Text("Off_BalanceSheet"),
                    ],
                  ),
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Checkbox(
                      value: isMultiCurrencyChecked,
                      onChanged:
                           (val) {
                              setState(() {
                                isMultiCurrencyChecked = val ?? false;
                                if (!isMultiCurrencyChecked) {
                                  _selectedCurrencies.clear();
                                  _selectedCurrency = null;
                                }
                              });
                            }
                    
                    ),
                    
                    // SizedBox(width: 10,),
                    
                    Text("Multi_currency : "),
                    SizedBox(width: 5),
                    SizedBox(
                      width:183,
                     // height:60,
                    
                   child:  isMultiCurrencyChecked
                    ? MultiSelectDialogField<String>(
                      items: currencies
                          .map((cur) => MultiSelectItem(cur, cur))
                          .toList(),
                      title: const Text("Currencies"),
                      dialogWidth: 100,
                      dialogHeight: 180,
                      chipDisplay: MultiSelectChipDisplay.none(),
                      buttonText: Text(
                        _selectedCurrencies.isEmpty
                            ? "MMK"
                            : _selectedCurrencies.join(', '),
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      searchable: true,
                      listType: MultiSelectListType.LIST,
                      initialValue: _selectedCurrencies,
                      buttonIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      onConfirm: (values) {
                        setState(() {
                          _selectedCurrencies = values;
                        });
                      },
                    )
                    : DropdownButtonFormField<String>(
                      value: _selectedCurrency,
                     
                      hint: const Text("Select Currency"),
                      items: currencies
                      .map((cur) => DropdownMenuItem(
                        value: cur,
                        child: Text(cur),
                        )).toList(),
                        onChanged: (val){
                          setState(() {
                            _selectedCurrency = val;
                          });
                        },
                    ),
                    ),
                    // Spacer(),
                    SizedBox(width: 96),
                    Checkbox(
                      value: isBankAccountChecked,
                      onChanged: isBankAccountEnabled
                          ? (val) => setState(
                              () => isBankAccountChecked = val ?? false,
                            )
                          : null,
                    ),
                    Text("Bank_Account"),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Checkbox(
                  value: isAccountStatusChecked,
                  onChanged: (val) =>
                      setState(() => isAccountStatusChecked = val ?? false),
                ),
                Text("Account_Status"),
              ],
            ),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 130, 204, 238),
                ),
                onPressed: (){ Navigator.pop(context);
              setState(() {
                _selectedTabIndex = 0;
              });
              },
                child: const Text("Cancel"),
              ),
              SizedBox(width: 70,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 130, 204, 238),
                ),
                onPressed: _submit,
              child: const Text("Submit"),
               
                
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
           validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label is required';
          }
          return null;
        },
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 225, 233, 236),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

 void _submit() async {
  if (_formkey.currentState!.validate()) {
    final account = Account(
       companyId: 1,
       currencyId: 1, 
      accountCode: _accountCodeController.text.trim(),
      accountNameShort: _accountNameShortController.text.trim(),
      accountName: _accountNameController.text.trim(),
      accountType: _selectedAccountType ?? '',
      offBalancesheet: isOffBalanceSheetChecked,
      bankAccount: isBankAccountChecked,
      multipleCurrency: isMultiCurrencyChecked,
      currencyCode: isMultiCurrencyChecked
          ? _selectedCurrencies.join(',')
          : (_selectedCurrency ?? ''),
      accountStatus: isAccountStatusChecked, 
     
       createdBy:1,
        createdDate: '',
         createdTime: '',
    );

    try {
      final api = ApiService();
      final createdAccount = await api.createAccount(account);

      setState(() {
        _selectedTabIndex =1 ;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text( "Account created successfully!"
              ),
        ),
      );

      _clearForm();
    } catch (e) {
      print("Submit error: $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Error"),
          content: Text("Failed to submit account. ${e.toString()}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        ),
      );
    }
  }
}

void _clearForm() {
  _accountCodeController.clear();
  _accountNameShortController.clear();
  _accountNameController.clear();
  _selectedAccountType = null;
  _selectedCurrency = null;
  _selectedCurrencies.clear();
  isOffBalanceSheetChecked = false;
  isBankAccountChecked = false;
  isAccountStatusChecked = false;
  isMultiCurrencyChecked = false;

  setState(() {});
}
  
}

class TrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(20, 0); // start a bit in from top left
    path.lineTo(size.width - 20, 0); // top right
    path.lineTo(size.width, size.height); // slant to bottom right
    path.lineTo(0, size.height); // bottom left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Widget buildSlantedTab(String label, bool isSelected) {
  return ClipPath(
    clipper: TrapezoidClipper(),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: isSelected ? Colors.blue[200] : Colors.blue[100],
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.grey[800],
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
