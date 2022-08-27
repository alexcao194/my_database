import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  final String service;
  final String account;
  final String password;
  final String note;
  final String id;

  const Account({required this.password, required this.account, required this.note, required this.service, required this.id});

  static List<Account> toListAccount(List<QueryDocumentSnapshot<Map<String, dynamic>>> data) {
    List<Account> accounts = [];
    for (var element in data) {
     accounts.add(
         Account(
             password: element.get('password'),
             account: element.get('account'),
             note: element.get('note'),
             service: element.get('service'),
             id: element.id
         )
     );
    }
    return accounts;
  }

  static List<Account> toListAccountSearchByName(List<QueryDocumentSnapshot<Map<String, dynamic>>> data, String value) {
    List<Account> accounts = [];
    for (var element in data) {
      if(element.get('service').toString().toLowerCase().startsWith(value.toLowerCase())) {
        accounts.add(
            Account(
                password: element.get('password'),
                account: element.get('account'),
                note: element.get('note'),
                service: element.get('service'),
                id: element.id
            )
        );
      }
    }
    return accounts;
  }
}