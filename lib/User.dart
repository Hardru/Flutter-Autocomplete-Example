class User {
  final String email;
  final String name;
  final String username;
  final String province;

  User(this.email, this.name, this.province, this.username);

  static List<User> options = <User>[
    User('bob@test.com', 'Bob', 'Barcelona', 'bob1234'),
    User('alice@test.com', 'Alice', 'Girona', 'alice7851'),
    User('david@test.com', 'David', 'Barcelona', 'david1841'),
    User('john@test.com', 'John', 'Girona', 'john1943'),
  ];
}
