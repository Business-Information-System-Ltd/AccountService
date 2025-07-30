class Account {
  final int? accountId;
   final int companyId;
  final String accountCode;
  final String accountName;
  final String accountNameShort;
  final String accountType;
  final bool offBalancesheet;
  final bool multipleCurrency;
  final int currencyId;
  final String currencyCode;
  final bool accountStatus;
  final bool bankAccount;
  final int createdBy;
  final String createdDate;
  final String createdTime; 

  Account({
    this.accountId,
    required this.companyId,
    required this.currencyId,
    required this.accountCode,
    required this.accountName,
    required this.accountNameShort,
    required this.accountType,
    required this.offBalancesheet,
    required this.multipleCurrency,
    required this.currencyCode,
    required this.accountStatus,
    required this.bankAccount,
    required this.createdBy,
    required this.createdDate,
    required this.createdTime,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      accountId: json['account_id'],
      companyId: json['company'],
      currencyId: json['currency'],
      accountCode: json['account_code'],
      accountName: json['account_name'],
      accountNameShort: json['account_name_short'],
      accountType: json['account_type'],
      offBalancesheet: json['off_balancesheet'],
      multipleCurrency: json['multiple_currency'],
      currencyCode: json['currency_code'],
      accountStatus: json['account_status'],
      bankAccount: json['bank_account'],
      createdBy: json['created_by'],
      createdDate: json['created_date'],
      createdTime: json['created_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_id': accountId,
      'company': companyId,
      'currency': currencyId,
      'account_code': accountCode,
      'account_name': accountName,
      'account_name_short': accountNameShort,
      'account_type': accountType,
      'off_balancesheet': offBalancesheet,
      'multiple_currency': multipleCurrency,
      'currency_code': currencyCode,
      'account_status': accountStatus,
      'bank_account': bankAccount,
      'created_by': createdBy,
      'created_date': createdDate,
      'created_time': createdTime,
    };
  }
}

class Country {
  final int? countryId;
  final String countryCode;
  final String countryName;
  final String countryNameShort;

  Country({
    this.countryId,
    required this.countryCode,
    required this.countryName,
    required this.countryNameShort,
  });
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      countryId: json['country_id'],
      countryCode: json['country_code'],
      countryName: json['country_name'],
      countryNameShort: json['country_name_short'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'country_id': countryId,
      'country_code': countryCode,
      'country_name': countryName,
      'country_name_short': countryNameShort,
    };
  }
}
class Company {
  final int? companyId;
  final int? countryId;
  final String companyName;
  final String companyNameShort;

  Company({
    this.companyId,
     this.countryId,
    required this.companyName,
    required this.companyNameShort,
  });
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyId: json['company_id'],
      countryId: json['country_id'],
      companyName: json['company_name'],
      companyNameShort: json['company_name_short'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'company_id': companyId,
      'country_id': countryId,
      'company_name': companyName,
      'company_name_short': companyNameShort,
    };
  }
}
class Currency {
  final int? currencyId;
  final String currencyCode;
  final String currencyName;
  final String currencySymbol;
  final String currencyDescription;

  Currency({
    this.currencyId,
    required this.currencyCode,
    required this.currencyName,
    required this.currencySymbol,
    required this.currencyDescription
  });
  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      currencyId: json['currency_id'],
      currencyCode: json['currency_code'],
      currencyName: json['currency_name'],
      currencySymbol:json['currency_symbol'],
      currencyDescription: json['currency_description'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'currency_id': currencyId,
      'currency_code': currencyCode,
      'currency_name': currencyName,
      'currency_symbol': currencySymbol,
      'currency_description':currencyDescription,

    };
  }
  @override
@override
String toString() => currencyCode;

String get displayText => "$currencyCode - $currencyName";
 @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Currency &&
          runtimeType == other.runtimeType &&
          currencyId == other.currencyId;

  @override
  int get hashCode => currencyId.hashCode;
}

