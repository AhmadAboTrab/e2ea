import '../../../../Controller/Api/Search/SearchWithAbstractMedicen/AbstrachSearch.dart';
import '../../../../models/Product.dart';

class TradeMedicienSearchApi extends AbstractSearch {
  @override
  Future<List<Product>> getUserSugesstions(String query) async {
    List<Product> products;
    //Here get all products from database
    products = await AbstractSearch().getUserSugesstions(query);
    return products.where((employee) {
      final nameLower = employee.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }
}
