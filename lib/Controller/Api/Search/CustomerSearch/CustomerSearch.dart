import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../models/Custormer.dart';

import '../SearchApi.dart';

class CustomerSearch extends SearchApi {
  @override
  Future<List<Object>> getUserSugesstions(String query) async {
    final List<Customer> result = [];

    return await FirebaseFirestore.instance.collection('Customer').get()
        // ignore: missing_return
        .then((value) async {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          Customer customer = new Customer();
          customer.id = doc.data()['id'];
          customer.name = doc.data()['name'];
          customer.notes = doc.data()['notes'];

          result.add(customer);
        });
        //return result.toList();
        return result;
      }
    });
  }
}
