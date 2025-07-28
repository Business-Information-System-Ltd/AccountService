import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:accountservice/views/apiservices.dart';
import 'package:accountservice/views/data.dart';

class MyDimensionState extends StatefulWidget {
  const MyDimensionState({super.key});

  @override
  State<MyDimensionState> createState() => _MyDimensionStateState();
}

class _MyDimensionStateState extends State<MyDimensionState> {
  late List<PlutoColumn> columns;
  List<PlutoRow> filteredRows = [];
  bool isLoading = true;
  List<Account> accounts = [];
  PlutoGridStateManager? stateManager;

  @override
  void initState() {
    super.initState();
    initColumns();
    _loadAccounts();
  }

  void initColumns() {
    columns = [
      PlutoColumn(
        title: 'Account_Id',
        field: 'account_id',
        type: PlutoColumnType.text(),
        width: 100,
        hide: true,
      ),
      PlutoColumn(
        title: 'Company',
        field: 'company_id',
        type: PlutoColumnType.text(),
        width: 100,
        hide: true,
      ),
      // PlutoColumn(
      //   title: 'Country',
      //   field: 'country_id',
      //   type: PlutoColumnType.text(),
      //   width: 100,
      //   hide: true,
      // ),
      PlutoColumn(
        title: 'Currency',
        field: 'currency_id',
        type: PlutoColumnType.text(),
        width: 100,
        hide: true,
      ),
      PlutoColumn(
        title: 'Account_Code',
        field: 'account_code',
        type: PlutoColumnType.text(),
        width: 120,
      ),
      PlutoColumn(
        title: 'Account_Name_Short',
        field: 'account_name_short',
        type: PlutoColumnType.text(),
        width: 200,
      ),
      PlutoColumn(
        title: 'Account_Name',
        field: 'account_name',
        type: PlutoColumnType.text(),
        width: 250,
      ),
      PlutoColumn(
        title: 'Account_Type',
        field: 'account_type',
        type: PlutoColumnType.text(),
        width: 150,
      ),
      PlutoColumn(
        title: 'Off_Balancesheet',
        field: 'off_balancesheet',
        type: PlutoColumnType.text(),
        width: 120,
      ),
      PlutoColumn(
        title: 'Multiple_Currency',
        field: 'multiple_currency',
        type: PlutoColumnType.text(),
        width: 150,
      ),
      PlutoColumn(
        title: 'Bank_Account',
        field: 'bank_account',
        type: PlutoColumnType.text(),
        width: 120,
      ),
      PlutoColumn(
        title: 'Account_Status',
        field: 'account_status',
        type: PlutoColumnType.text(),
        width: 150,
      ),
    ];
  }

  Future<void> _loadAccounts() async {
    try {
      final apiService = ApiService();
      accounts = await apiService.fetchAccounts();
      print("Fetched ${accounts.length} accounts");

      List<PlutoRow> newRows = accounts.map((account) {
        return PlutoRow(cells: {
          'account_id': PlutoCell(value: account.accountId?.toString() ?? ''),
          'company_id': PlutoCell(value: account.companyId?.toString() ?? ''),
         // 'country_id': PlutoCell(value: account.companyId?.toString() ?? ''),
          'currency_id': PlutoCell(value: account.currencyId?.toString() ?? ''),
          'account_code': PlutoCell(value: account.accountCode ?? ''),
          'account_name_short': PlutoCell(value: account.accountNameShort ?? ''),
          'account_name': PlutoCell(value: account.accountName ?? ''),
          'account_type': PlutoCell(value: account.accountType ?? ''),
          'off_balancesheet': PlutoCell(value: account.offBalancesheet ? 'Yes' : 'No'),
          'multiple_currency': PlutoCell(value: account.multipleCurrency ? 'Yes' : 'No'),
          'bank_account': PlutoCell(value: account.bankAccount ? 'Yes' : 'No'),
          'account_status': PlutoCell(value: account.accountStatus ? 'Yes' : 'No'),
        });
      }).toList();

      setState(() {
        filteredRows = newRows;
        isLoading = false;
      });

      print("Pluto rows loaded: ${newRows.length}");
    } catch (e) {
      print("Error loading accounts: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts Table'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: PlutoGrid(
                columns: columns,
                rows: filteredRows,
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  stateManager = event.stateManager;
                  print("Grid loaded with ${event.stateManager.rows.length} rows");
                },
                onChanged: (PlutoGridOnChangedEvent event) {
                  print('Changed: ${event.column.field} => ${event.value}');
                },
                configuration: const PlutoGridConfiguration(),
              ),
            ),
    );
  }
}
