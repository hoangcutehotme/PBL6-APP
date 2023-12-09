import 'dart:convert';

List<StatisticModel> statisticModelFromJson(String str) => List<StatisticModel>.from(json.decode(str).map((x) => StatisticModel.fromJson(x)));

String statisticModelToJson(List<StatisticModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatisticModel {
    DateTime? date;
    int? revenue;
    int? count;

    StatisticModel({
        this.date,
        this.revenue,
        this.count,
    });

    factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
        date: DateTime.parse(json["date"]),
        revenue: json["revenue"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "date": "${date?.year.toString().padLeft(4, '0')}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}",
        "revenue": revenue,
        "count": count,
    };
}
