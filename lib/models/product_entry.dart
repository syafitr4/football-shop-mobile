import 'dart:convert';

List<productEntry> productEntryFromJson(String str) => List<productEntry>.from(json.decode(str).map((x) => productEntry.fromJson(x)));

String productEntryToJson(List<productEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class productEntry {
    String model;
    String pk;
    Fields fields;

    productEntry({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory productEntry.fromJson(Map<String, dynamic> json) => productEntry(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int? user;
    String category;
    String name;
    int price;
    String description;
    String thumbnail;
    bool isFeatured;

    Fields({
        required this.user,
        required this.category,
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail,
        required this.isFeatured,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        category: json["category"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        isFeatured: json["is_featured"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "category": category,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "is_featured": isFeatured,
    };
}
