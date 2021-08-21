import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Controller/Api/Search/SearchApi.dart';
import '../../../../models/employee.dart';

class EmployeeSearch implements SearchApi {
  @override
  Future<List<Employee>> getUserSugesstions(String query) async {
    final List<Employee> result = [];
    return await FirebaseFirestore.instance.collection('Employee').get()
        // ignore: missing_return
        .then((value) async {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((doc) {
          Employee employee = new Employee.employee();
          employee.id = doc.data()['employee_id'];
          employee.name = doc.data()['employee_name'];
          employee.email = doc.data()['employee_email'];
          employee.phoneNumber = doc.data()['employee_phone'];
          //employee.

          print("HERe in class");
          print(employee.name);
          result.add(employee);
        });
        //return result.toList();
        return result;
      }
    });
  }
}
