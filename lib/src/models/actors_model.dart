class Cast {
  List<Actor> items = new List();
  Cast();
  // Recorrer el json y crear instancias Movie con cada item recibido
  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    } else {
      jsonList.forEach((item) {
        final actor = new Actor.fromJsonMap(item);
        items.add(actor);
      });
    }
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  // Mapear el Actor json a nuestra clase Actor
  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getImg() {
    if ( profilePath == null ) {
      return 'http://forum.spaceengine.org/styles/se/theme/images/no_avatar.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }

}