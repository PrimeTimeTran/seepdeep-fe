import 'package:app/models/user.dart';

class Company {
  String? name;
  String? industry;
  String? founded;
  int? teamSize;
  String? location;
  String? urlAvatar;
  List<User>? founders;
  List<String>? industries;
  List<String>? technologies;

  Company({
    this.name,
    this.industry,
    this.founded,
    this.teamSize,
    this.location,
    this.urlAvatar,
    this.founders,
    this.industries,
    this.technologies,
  });

  Company.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        industry = json['industry'],
        founded = json['founded'],
        teamSize = json['teamSize'],
        location = json['location'],
        urlAvatar = json['urlAvatar'],
        founders = (json['founders'] as List<dynamic>?)
            ?.map((founderJson) => User.fromJson(founderJson))
            .toList(),
        industries = (json['industries'] as List<dynamic>?)?.cast<String>(),
        technologies = (json['technologies'] as List<dynamic>?)?.cast<String>();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'industry': industry,
      'founded': founded,
      'teamSize': teamSize,
      'location': location,
      'urlAvatar': urlAvatar,
      'founders': founders?.map((founder) => founder.toJson()).toList(),
      'industries': industries,
      'technologies': technologies,
    };
  }
}

class Job {
  String? title;
  String? caption;
  String? location;
  bool? isRemote;
  Company? company;
  String? type; // Full or part time
  String? description;
  String? experience;
  String? project; // What we're up to. Whats awesome about this position?
  List<String>?
      technologies; // What do we use everyday? Is it different from what we do
  String? requirements;
  String? whoAreYou;
  String? salary;
  String? equity;
  String? benefits;

  Job({
    this.title,
    this.caption,
    this.location,
    this.isRemote,
    this.company,
    this.type,
    this.description,
    this.experience,
    this.project,
    this.technologies,
    this.requirements,
    this.whoAreYou,
    this.salary,
    this.equity,
    this.benefits,
  });

  Job.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        caption = json['caption'],
        location = json['location'],
        isRemote = json['isRemote'],
        company =
            json['company'] != null ? Company.fromJson(json['company']) : null,
        type = json['type'],
        description = json['description'],
        experience = json['experience'],
        project = json['project'],
        technologies = (json['technologies'] as List<dynamic>?)?.cast<String>(),
        requirements = json['requirements'],
        whoAreYou = json['whoAreYou'],
        salary = json['salary'],
        equity = json['equity'],
        benefits = json['benefits'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'caption': caption,
      'location': location,
      'isRemote': isRemote,
      'company': company?.toJson(),
      'type': type,
      'description': description,
      'experience': experience,
      'project': project,
      'technologies': technologies,
      'requirements': requirements,
      'whoAreYou': whoAreYou,
      'salary': salary,
      'equity': equity,
      'benefits': benefits,
    };
  }
}
