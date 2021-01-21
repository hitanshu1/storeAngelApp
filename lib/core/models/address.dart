class AddressModel {
  String id;
  String state;
  String street;
  String city;
  String zipCode;
  String country;
  String apartment;
  String entrance;
  String name;
  bool isDefault;
  String floor;

  AddressModel({
    this.state,
    this.id,

    this.country,
    this.apartment,
    this.entrance,
    this.floor,
    this.name,
    this.isDefault: false,
    this.street: '',
    this.city:'',
    this.zipCode: '',
  });

  String get address =>street+', '+zipCode+' '+city;
  String get addressWithName=>name+'\n'+street+', '+zipCode+' '+city;
  String get threeLineAddress=>name+'\n'+street+', \n'+zipCode+' '+city;
}
