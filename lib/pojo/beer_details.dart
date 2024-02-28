/// id : 1
/// name : "Buzz"
/// tagline : "A Real Bitter Experience."
/// first_brewed : "09/2007"
/// description : "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only once."
/// image_url : "https://images.punkapi.com/v2/keg.png"
/// abv : 4.5
/// ibu : 60
/// target_fg : 1010
/// target_og : 1044
/// ebc : 20
/// srm : 10
/// ph : 4.4
/// attenuation_level : 75
/// volume : {"value":20,"unit":"litres"}
/// boil_volume : {"value":25,"unit":"litres"}
/// method : {"mash_temp":[{"temp":{"value":64,"unit":"celsius"},"duration":75}],"fermentation":{"temp":{"value":19,"unit":"celsius"}},"twist":null}
/// ingredients : {"malt":[{"name":"Maris Otter Extra Pale","amount":{"value":3.3,"unit":"kilograms"}},{"name":"Caramalt","amount":{"value":0.2,"unit":"kilograms"}},{"name":"Munich","amount":{"value":0.4,"unit":"kilograms"}}],"hops":[{"name":"Fuggles","amount":{"value":25,"unit":"grams"},"add":"start","attribute":"bitter"},{"name":"First Gold","amount":{"value":25,"unit":"grams"},"add":"start","attribute":"bitter"},{"name":"Fuggles","amount":{"value":37.5,"unit":"grams"},"add":"middle","attribute":"flavour"},{"name":"First Gold","amount":{"value":37.5,"unit":"grams"},"add":"middle","attribute":"flavour"},{"name":"Cascade","amount":{"value":37.5,"unit":"grams"},"add":"end","attribute":"flavour"}],"yeast":"Wyeast 1056 - American Ale™"}
/// food_pairing : ["Spicy chicken tikka masala","Grilled chicken quesadilla","Caramel toffee cake"]
/// brewers_tips : "The earthy and floral aromas from the hops can be overpowering. Drop a little Cascade in at the end of the boil to lift the profile with a bit of citrus."
/// contributed_by : "Sam Mason <samjbmason>"

class BeerDetails {
  BeerDetails({
      num? id, 
      String? name, 
      String? tagline, 
      String? firstBrewed, 
      String? description, 
      String? imageUrl, 
      num? abv, 
      num? ibu, 
      num? targetFg, 
      num? targetOg, 
      num? ebc, 
      num? srm, 
      num? ph, 
      num? attenuationLevel, 
      Volume? volume, 
      BoilVolume? boilVolume, 
      Method? method, 
      Ingredients? ingredients, 
      List<String>? foodPairing, 
      String? brewersTips, 
      String? contributedBy,}){
    _id = id;
    _name = name;
    _tagline = tagline;
    _firstBrewed = firstBrewed;
    _description = description;
    _imageUrl = imageUrl;
    _abv = abv;
    _ibu = ibu;
    _targetFg = targetFg;
    _targetOg = targetOg;
    _ebc = ebc;
    _srm = srm;
    _ph = ph;
    _attenuationLevel = attenuationLevel;
    _volume = volume;
    _boilVolume = boilVolume;
    _method = method;
    _ingredients = ingredients;
    _foodPairing = foodPairing;
    _brewersTips = brewersTips;
    _contributedBy = contributedBy;
}

  BeerDetails.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _tagline = json['tagline'];
    _firstBrewed = json['first_brewed'];
    _description = json['description'];
    _imageUrl = json['image_url'];
    _abv = json['abv'];
    _ibu = json['ibu'];
    _targetFg = json['target_fg'];
    _targetOg = json['target_og'];
    _ebc = json['ebc'];
    _srm = json['srm'];
    _ph = json['ph'];
    _attenuationLevel = json['attenuation_level'];
    _volume = json['volume'] != null ? Volume.fromJson(json['volume']) : null;
    _boilVolume = json['boil_volume'] != null ? BoilVolume.fromJson(json['boil_volume']) : null;
    _method = json['method'] != null ? Method.fromJson(json['method']) : null;
    _ingredients = json['ingredients'] != null ? Ingredients.fromJson(json['ingredients']) : null;
    _foodPairing = json['food_pairing'] != null ? json['food_pairing'].cast<String>() : [];
    _brewersTips = json['brewers_tips'];
    _contributedBy = json['contributed_by'];
  }
  num? _id;
  String? _name;
  String? _tagline;
  String? _firstBrewed;
  String? _description;
  String? _imageUrl;
  num? _abv;
  num? _ibu;
  num? _targetFg;
  num? _targetOg;
  num? _ebc;
  num? _srm;
  num? _ph;
  num? _attenuationLevel;
  Volume? _volume;
  BoilVolume? _boilVolume;
  Method? _method;
  Ingredients? _ingredients;
  List<String>? _foodPairing;
  String? _brewersTips;
  String? _contributedBy;
BeerDetails copyWith({  num? id,
  String? name,
  String? tagline,
  String? firstBrewed,
  String? description,
  String? imageUrl,
  num? abv,
  num? ibu,
  num? targetFg,
  num? targetOg,
  num? ebc,
  num? srm,
  num? ph,
  num? attenuationLevel,
  Volume? volume,
  BoilVolume? boilVolume,
  Method? method,
  Ingredients? ingredients,
  List<String>? foodPairing,
  String? brewersTips,
  String? contributedBy,
}) => BeerDetails(  id: id ?? _id,
  name: name ?? _name,
  tagline: tagline ?? _tagline,
  firstBrewed: firstBrewed ?? _firstBrewed,
  description: description ?? _description,
  imageUrl: imageUrl ?? _imageUrl,
  abv: abv ?? _abv,
  ibu: ibu ?? _ibu,
  targetFg: targetFg ?? _targetFg,
  targetOg: targetOg ?? _targetOg,
  ebc: ebc ?? _ebc,
  srm: srm ?? _srm,
  ph: ph ?? _ph,
  attenuationLevel: attenuationLevel ?? _attenuationLevel,
  volume: volume ?? _volume,
  boilVolume: boilVolume ?? _boilVolume,
  method: method ?? _method,
  ingredients: ingredients ?? _ingredients,
  foodPairing: foodPairing ?? _foodPairing,
  brewersTips: brewersTips ?? _brewersTips,
  contributedBy: contributedBy ?? _contributedBy,
);
  num? get id => _id;
  String? get name => _name;
  String? get tagline => _tagline;
  String? get firstBrewed => _firstBrewed;
  String? get description => _description;
  String? get imageUrl => _imageUrl;
  num? get abv => _abv;
  num? get ibu => _ibu;
  num? get targetFg => _targetFg;
  num? get targetOg => _targetOg;
  num? get ebc => _ebc;
  num? get srm => _srm;
  num? get ph => _ph;
  num? get attenuationLevel => _attenuationLevel;
  Volume? get volume => _volume;
  BoilVolume? get boilVolume => _boilVolume;
  Method? get method => _method;
  Ingredients? get ingredients => _ingredients;
  List<String>? get foodPairing => _foodPairing;
  String? get brewersTips => _brewersTips;
  String? get contributedBy => _contributedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['tagline'] = _tagline;
    map['first_brewed'] = _firstBrewed;
    map['description'] = _description;
    map['image_url'] = _imageUrl;
    map['abv'] = _abv;
    map['ibu'] = _ibu;
    map['target_fg'] = _targetFg;
    map['target_og'] = _targetOg;
    map['ebc'] = _ebc;
    map['srm'] = _srm;
    map['ph'] = _ph;
    map['attenuation_level'] = _attenuationLevel;
    if (_volume != null) {
      map['volume'] = _volume?.toJson();
    }
    if (_boilVolume != null) {
      map['boil_volume'] = _boilVolume?.toJson();
    }
    if (_method != null) {
      map['method'] = _method?.toJson();
    }
    if (_ingredients != null) {
      map['ingredients'] = _ingredients?.toJson();
    }
    map['food_pairing'] = _foodPairing;
    map['brewers_tips'] = _brewersTips;
    map['contributed_by'] = _contributedBy;
    return map;
  }

}

/// malt : [{"name":"Maris Otter Extra Pale","amount":{"value":3.3,"unit":"kilograms"}},{"name":"Caramalt","amount":{"value":0.2,"unit":"kilograms"}},{"name":"Munich","amount":{"value":0.4,"unit":"kilograms"}}]
/// hops : [{"name":"Fuggles","amount":{"value":25,"unit":"grams"},"add":"start","attribute":"bitter"},{"name":"First Gold","amount":{"value":25,"unit":"grams"},"add":"start","attribute":"bitter"},{"name":"Fuggles","amount":{"value":37.5,"unit":"grams"},"add":"middle","attribute":"flavour"},{"name":"First Gold","amount":{"value":37.5,"unit":"grams"},"add":"middle","attribute":"flavour"},{"name":"Cascade","amount":{"value":37.5,"unit":"grams"},"add":"end","attribute":"flavour"}]
/// yeast : "Wyeast 1056 - American Ale™"

class Ingredients {
  Ingredients({
      List<Malt>? malt, 
      List<Hops>? hops, 
      String? yeast,}){
    _malt = malt;
    _hops = hops;
    _yeast = yeast;
}

  Ingredients.fromJson(dynamic json) {
    if (json['malt'] != null) {
      _malt = [];
      json['malt'].forEach((v) {
        _malt?.add(Malt.fromJson(v));
      });
    }
    if (json['hops'] != null) {
      _hops = [];
      json['hops'].forEach((v) {
        _hops?.add(Hops.fromJson(v));
      });
    }
    _yeast = json['yeast'];
  }
  List<Malt>? _malt;
  List<Hops>? _hops;
  String? _yeast;
Ingredients copyWith({  List<Malt>? malt,
  List<Hops>? hops,
  String? yeast,
}) => Ingredients(  malt: malt ?? _malt,
  hops: hops ?? _hops,
  yeast: yeast ?? _yeast,
);
  List<Malt>? get malt => _malt;
  List<Hops>? get hops => _hops;
  String? get yeast => _yeast;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_malt != null) {
      map['malt'] = _malt?.map((v) => v.toJson()).toList();
    }
    if (_hops != null) {
      map['hops'] = _hops?.map((v) => v.toJson()).toList();
    }
    map['yeast'] = _yeast;
    return map;
  }

}

/// name : "Fuggles"
/// amount : {"value":25,"unit":"grams"}
/// add : "start"
/// attribute : "bitter"

class Hops {
  Hops({
      String? name, 
      Amount? amount, 
      String? add, 
      String? attribute,}){
    _name = name;
    _amount = amount;
    _add = add;
    _attribute = attribute;
}

  Hops.fromJson(dynamic json) {
    _name = json['name'];
    _amount = json['amount'] != null ? Amount.fromJson(json['amount']) : null;
    _add = json['add'];
    _attribute = json['attribute'];
  }
  String? _name;
  Amount? _amount;
  String? _add;
  String? _attribute;
Hops copyWith({  String? name,
  Amount? amount,
  String? add,
  String? attribute,
}) => Hops(  name: name ?? _name,
  amount: amount ?? _amount,
  add: add ?? _add,
  attribute: attribute ?? _attribute,
);
  String? get name => _name;
  Amount? get amount => _amount;
  String? get add => _add;
  String? get attribute => _attribute;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    if (_amount != null) {
      map['amount'] = _amount?.toJson();
    }
    map['add'] = _add;
    map['attribute'] = _attribute;
    return map;
  }

}

/// value : 25
/// unit : "grams"

class Amount {
  Amount({
      num? value, 
      String? unit,}){
    _value = value;
    _unit = unit;
}

  Amount.fromJson(dynamic json) {
    _value = json['value'];
    _unit = json['unit'];
  }
  num? _value;
  String? _unit;
Amount copyWith({  num? value,
  String? unit,
}) => Amount(  value: value ?? _value,
  unit: unit ?? _unit,
);
  num? get value => _value;
  String? get unit => _unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['unit'] = _unit;
    return map;
  }

}

/// name : "Maris Otter Extra Pale"
/// amount : {"value":3.3,"unit":"kilograms"}

class Malt {
  Malt({
      String? name, 
      Amount? amount,}){
    _name = name;
    _amount = amount;
}

  Malt.fromJson(dynamic json) {
    _name = json['name'];
    _amount = json['amount'] != null ? Amount.fromJson(json['amount']) : null;
  }
  String? _name;
  Amount? _amount;
Malt copyWith({  String? name,
  Amount? amount,
}) => Malt(  name: name ?? _name,
  amount: amount ?? _amount,
);
  String? get name => _name;
  Amount? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    if (_amount != null) {
      map['amount'] = _amount?.toJson();
    }
    return map;
  }

}

/// mash_temp : [{"temp":{"value":64,"unit":"celsius"},"duration":75}]
/// fermentation : {"temp":{"value":19,"unit":"celsius"}}
/// twist : null

class Method {
  Method({
      List<MashTemp>? mashTemp, 
      Fermentation? fermentation, 
      dynamic twist,}){
    _mashTemp = mashTemp;
    _fermentation = fermentation;
    _twist = twist;
}

  Method.fromJson(dynamic json) {
    if (json['mash_temp'] != null) {
      _mashTemp = [];
      json['mash_temp'].forEach((v) {
        _mashTemp?.add(MashTemp.fromJson(v));
      });
    }
    _fermentation = json['fermentation'] != null ? Fermentation.fromJson(json['fermentation']) : null;
    _twist = json['twist'];
  }
  List<MashTemp>? _mashTemp;
  Fermentation? _fermentation;
  dynamic _twist;
Method copyWith({  List<MashTemp>? mashTemp,
  Fermentation? fermentation,
  dynamic twist,
}) => Method(  mashTemp: mashTemp ?? _mashTemp,
  fermentation: fermentation ?? _fermentation,
  twist: twist ?? _twist,
);
  List<MashTemp>? get mashTemp => _mashTemp;
  Fermentation? get fermentation => _fermentation;
  dynamic get twist => _twist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_mashTemp != null) {
      map['mash_temp'] = _mashTemp?.map((v) => v.toJson()).toList();
    }
    if (_fermentation != null) {
      map['fermentation'] = _fermentation?.toJson();
    }
    map['twist'] = _twist;
    return map;
  }

}

/// temp : {"value":19,"unit":"celsius"}

class Fermentation {
  Fermentation({
      Temp? temp,}){
    _temp = temp;
}

  Fermentation.fromJson(dynamic json) {
    _temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
  }
  Temp? _temp;
Fermentation copyWith({  Temp? temp,
}) => Fermentation(  temp: temp ?? _temp,
);
  Temp? get temp => _temp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_temp != null) {
      map['temp'] = _temp?.toJson();
    }
    return map;
  }

}

/// value : 19
/// unit : "celsius"

class Temp {
  Temp({
      num? value, 
      String? unit,}){
    _value = value;
    _unit = unit;
}

  Temp.fromJson(dynamic json) {
    _value = json['value'];
    _unit = json['unit'];
  }
  num? _value;
  String? _unit;
Temp copyWith({  num? value,
  String? unit,
}) => Temp(  value: value ?? _value,
  unit: unit ?? _unit,
);
  num? get value => _value;
  String? get unit => _unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['unit'] = _unit;
    return map;
  }

}

/// temp : {"value":64,"unit":"celsius"}
/// duration : 75

class MashTemp {
  MashTemp({
      Temp? temp, 
      num? duration,}){
    _temp = temp;
    _duration = duration;
}

  MashTemp.fromJson(dynamic json) {
    _temp = json['temp'] != null ? Temp.fromJson(json['temp']) : null;
    _duration = json['duration'];
  }
  Temp? _temp;
  num? _duration;
MashTemp copyWith({  Temp? temp,
  num? duration,
}) => MashTemp(  temp: temp ?? _temp,
  duration: duration ?? _duration,
);
  Temp? get temp => _temp;
  num? get duration => _duration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_temp != null) {
      map['temp'] = _temp?.toJson();
    }
    map['duration'] = _duration;
    return map;
  }

}

/// value : 25
/// unit : "litres"

class BoilVolume {
  BoilVolume({
      num? value, 
      String? unit,}){
    _value = value;
    _unit = unit;
}

  BoilVolume.fromJson(dynamic json) {
    _value = json['value'];
    _unit = json['unit'];
  }
  num? _value;
  String? _unit;
BoilVolume copyWith({  num? value,
  String? unit,
}) => BoilVolume(  value: value ?? _value,
  unit: unit ?? _unit,
);
  num? get value => _value;
  String? get unit => _unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['unit'] = _unit;
    return map;
  }

}

/// value : 20
/// unit : "litres"

class Volume {
  Volume({
      num? value, 
      String? unit,}){
    _value = value;
    _unit = unit;
}

  Volume.fromJson(dynamic json) {
    _value = json['value'];
    _unit = json['unit'];
  }
  num? _value;
  String? _unit;
Volume copyWith({  num? value,
  String? unit,
}) => Volume(  value: value ?? _value,
  unit: unit ?? _unit,
);
  num? get value => _value;
  String? get unit => _unit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['unit'] = _unit;
    return map;
  }

}