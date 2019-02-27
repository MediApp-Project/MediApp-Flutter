class MedData {
  String _name;
  String _link;
  String _addr;
  String _phone;
  int _pincode;
  String _map;
  String _services;
  String _consultants;
  String _website;
  String _img;
  // String _defaultImage="http://res.cloudinary.com/bhavartha/image/upload/v1547402517/jffozj1fjob9ovx8iqiv.jpg";

  MedData(this._name, this._link, this._addr, this._phone, this._pincode, this._map, this._services, this._consultants,this._website,this._img);

  List<List<String>> get consultants{
    List<List<String>> _temp=[];
    _consultants.split('%%').forEach((c){
     try{
      _temp.add(c.split('#'));}
    catch(e){_temp.add(['na']);}  
      });
    return _temp;
  }
  
  String get name => _name;
  String get link => _link;
  String get addr => _addr;
  String get phone => _phone;
  int get pincode => _pincode;
  String get map => _map;
  String get img => _img;
  String get website => _website;
  String get strservices => _services;
  List<String> get services => _services.split('%%');  
}
  

