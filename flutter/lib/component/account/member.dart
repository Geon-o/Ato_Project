class Member {
  String memberValue;
  String accountEmail;
  String accountNickname;

  Member(this.memberValue, this.accountEmail, this.accountNickname);

  Member.fromJson(Map<String, dynamic> json)
      : memberValue = json['memberValue'],
        accountEmail = json['accountEmail'],
        accountNickname = json['accountNickname'];

  Map<String, dynamic> toJson() => {
    'memberValue': memberValue,
    'accountEmail': accountEmail,
    'accountNickname': accountNickname
  };
}