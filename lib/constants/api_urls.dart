class ApiUrls{
  static const String BASE_URL = 'https://api.noteapp.com';

  static const String TODO_CREATE_API = '$BASE_URL/todos/create';
  static const String TODOS_API = '$BASE_URL/todos';
  static String TODO_API(id){ return "${BASE_URL}/api/todos/$id";}
}