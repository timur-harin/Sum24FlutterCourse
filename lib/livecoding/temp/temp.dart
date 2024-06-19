import 'package:http/http.dart' as http;

void main() {
  getJson();
}

void getJson() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');

  final response = await http.get(url);
  
  if (response.statusCode == 200) {
    print(response.body);
    }
  else {
    print("troubles");
  }
}