import 'dart:convert';
import 'package:http/http.dart' as http;
import 'data.dart';

class ApiService {
  static String baseUrl = 'http://localhost:3000/';
  final String accountEndPoint = "${baseUrl}accounts/";
  final String countryEndPoint = "${baseUrl}countries/";
  final String companyEndPoint = "${baseUrl}companies/";
  final String currencyEndPoint = "${baseUrl}currencies/";

  Future<List<Account>> fetchAccounts() async {
    final response = await http.get(Uri.parse(accountEndPoint));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => Account.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load accounts');
    }
  }

  Future<Account> createAccount(Account account) async {
    final response = await http.post(
      Uri.parse(accountEndPoint),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(account.toJson()),
    );

    if (response.statusCode == 201) {
      return Account.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create account');
    }
  }

  Future<Account> updateAccount(Account account) async {
    final response = await http.put(
      Uri.parse('$accountEndPoint${account.accountId}/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(account.toJson()),
    );

    if (response.statusCode == 200) {
      return Account.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update account');
    }
  }

  Future<void> deleteAccount(int id) async {
    final response = await http.delete(Uri.parse('$accountEndPoint$id/'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete account');
    }
  }


//Country
  
  Future<List<Country>> fetchCountry() async {
    final response = await http.get(Uri.parse(countryEndPoint));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Country.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load countries');
    }
  }
  

  Future<Country> postCountry(Country country) async {
    final response = await http.post(
      Uri.parse(countryEndPoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(country.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Country.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add country');
    }
  }

  /// Update
  Future<Country> updateCountry(Country country) async {
    final response = await http.put(
      Uri.parse('$countryEndPoint/${country.countryId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(country.toJson()),
    );
    if (response.statusCode == 200) {
      return Country.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update country');
    }
  }

  Future<void> deleteCountry(int id) async {
    final response = await http.delete(Uri.parse('$countryEndPoint/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete country');
    }
  }

//Company
  
  Future<List<Company>> fetchCompany() async {
    final response = await http.get(Uri.parse(companyEndPoint));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Company.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load company');
    }
  }
  

  Future<Company> postCompany(Company company) async {
    final response = await http.post(
      Uri.parse(companyEndPoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(company.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Company.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add company');
    }
  }

  /// Update
  Future<Company> updateCompany(Company company) async {
    final response = await http.put(
      Uri.parse('$companyEndPoint/${company.companyId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(company.toJson()),
    );
    if (response.statusCode == 200) {
      return Company.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update company');
    }
  }

  Future<void> deleteCompany(int id) async {
    final response = await http.delete(Uri.parse('$companyEndPoint/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete company');
    }
  }
  //Currency
  
  Future<List<Currency>> fetchCurrency() async {
    final response = await http.get(Uri.parse(currencyEndPoint));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Currency.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load currency');
    }
  }
  

  Future<Currency> postCurrency(Currency currency) async {
    final response = await http.post(
      Uri.parse(currencyEndPoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(currency.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Currency.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add company');
    }
  }

  /// Update
  Future<Currency> updateCurrency(Currency currency) async {
    final response = await http.put(
      Uri.parse('$currencyEndPoint/${currency.currencyId}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(currency.toJson()),
    );
    if (response.statusCode == 200) {
      return Currency.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update currency');
    }
  }

  Future<void> deleteCurrency(int id) async {
    final response = await http.delete(Uri.parse('$currencyEndPoint/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete currency');
    }
  }
}