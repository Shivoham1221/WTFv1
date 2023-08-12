
class UserModel {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String phone;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone
  });

  toJson(){
    return{
      "Uid":id,
      "Name":name,

      "Email":email,
      "Mobile":phone,
      "password":password
    };
  }

}