class MatchModel {
  int? teamA, teamB, id;
  String? date, teamAName, teamBName;
  MatchModel({
    required this.date,
    required this.teamA,
    required this.teamB,
    required this.teamAName,
    required this.teamBName,
    required this.id,
  });

  MatchModel.fromMap(Map map) {
    teamA = map['teamA'];
    teamB = map['teamB'];
    teamBName = map['teamBName'];
    teamAName = map['teamAName'];
    date = map['date'];
    id = map['id'];
  }

  Map<String, dynamic> toMap() => {
        'teamA': teamA,
        'teamB': teamB,
        'teamAName': teamAName,
        'teamBName': teamBName,
        'date': date,
        'id': id,
      };
}
