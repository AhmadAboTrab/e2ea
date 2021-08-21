import '../../../../Controller/Api/Search/CustomerSearch/CustomerSearch.dart';
import '../../../../models/Custormer.dart';

class CustomerSearchByName extends CustomerSearch {
  @override
  Future<List<Customer>> getUserSugesstions(String query) async {
    List<Customer> customer = await CustomerSearch().getUserSugesstions(query);
    return customer.where((customer) {
      final nameLower = customer.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }
}
