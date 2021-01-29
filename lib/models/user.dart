class TawthraUser {
  String _email;
  String _name;
  String _uid;

  String get email => _email;

  String get name => _name;

  String get uid => _uid;

  TawthraUser(this._email, this._name, this._uid);

  TawthraUser.map(json) {
    this._email = json["Email"];
    this._name = json["Name"];
    this._uid = json["Uid"];
  }
}
