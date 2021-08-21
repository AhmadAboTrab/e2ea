
import '../../../../Controller/Api/Search/SearchWithAbstractMedicen/AbstrachSearch.dart';
import '../../../../models/Product.dart';

class ScientificMedicienSearchApi extends AbstractSearch {

  @override
  Future<List<Product>> getUserSugesstions(String query) async  {
    List<Product> products;
    //Here get all products from database
    products = await AbstractSearch().getUserSugesstions(query);
    return products.where((element) {
      final nameLower = [];
      for (int i = 0; i < element.composition.length; i++) {
        nameLower.add(element.composition[i].toLowerCase());
        nameLower[i].substring(nameLower[i].length - 3, nameLower[i].length);
      }

      final queryLower = query.toLowerCase();
      bool ifIt = false;

      for (int i = 0; i < nameLower.length; i++) {
        if (nameLower[i].contains(queryLower)) {
          ifIt = true;
          break;
        }
      }
      return ifIt;
    }).toList();
  }
}
