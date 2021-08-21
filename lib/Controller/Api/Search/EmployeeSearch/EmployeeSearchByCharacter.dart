import '../../../../models/employee.dart';

import 'EmployeeSearch.dart';

class EmployeeSearchByCharacter extends EmployeeSearch {
  @override
  Future<List<Employee>> getUserSugesstions(String query) async {
    List<Employee> employee = await EmployeeSearch().getUserSugesstions(query);
    return employee.where((employee) {
      final nameLower = employee.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();
  }
}
