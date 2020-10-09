import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart';
import 'package:jasonw/models/UserTasks.dart';
import 'package:jasonw/models/comments.dart';
import 'package:jasonw/models/dailyPlans.dart';
import 'package:jasonw/models/events.dart';
import 'package:jasonw/models/inspirations.dart';
import 'package:jasonw/models/journals.dart';
import 'package:jasonw/models/likes.dart';
import 'package:jasonw/models/reflects.dart';
import 'package:jasonw/models/user.dart';
import 'package:jasonw/pages/news.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

mixin ConnectedNewsModel on Model {
  List<Reflect> _reflects = [];
  List<Comment> _comments = [];
  List<Likes> _likes = [];
  List<News> _news = [];
  String _selReflectId;
  String _selJournalId;
  String _selInspirationId;
  List<Journal> _journalAll = [];

//  int _userTaskId;
  String _userTaskId;
  List<Inspiration> _inspirations = [];
  List<Journal> _journals = [];
  List<DailyPlans> _dailyplans = [];
  List<UserTasks> _usertasks = [];
  List<Events> _events = [];
  User _authenticatedUser;
  bool _isLoading = false;

//  User _user;
  String _selectDate;
  int _selectDailyPlan;
  List<LikeObject> likeList = [];
}

mixin JournalModel on ConnectedNewsModel {
  List<Journal> get alljournals {
    return List.from(_journals);
  }

  List<Journal> get alljournalall {
    return List.from(_journalAll);
  }

  List<Journal> get displayedJournals {
//    if (_showFavorites) {
//      return _products.where((Product product) => product.isFavorite).toList();
//    }
    return List.from(_journals);
  }

  int get selectedJournalIndex {
    return _journalAll.indexWhere((Journal journal) {
      return journal.journalID == _selJournalId;
    });
  }

  String get selectedJournalId {
    return _selJournalId;
  }

  Journal get selectedJournal {
    if (selectedJournalId == null) {
      return null;
    }

    return _journalAll.firstWhere((Journal journal) {
      return journal.journalID == _selJournalId;
    });
  }

  void selectDate(String selectDate) {
    _selectDate = selectDate;
    print(_selectDate);
    notifyListeners();
  }

  Future<bool> addJournal(
      String title, String description, String issue_date) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> JournalData = {
      'title': title,
      'description': description,
      'issue_date': issue_date
    };
    print(JournalData);

    try {
      final http.Response response =
          await http.post('https://app.jasonwolverson.net/api/journals',
              headers: {
                'Content-Type': 'application/json',
                'Auth-Token': _authenticatedUser.token,
              },
              body: json.encode(JournalData));

      print(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      final Journal newJournal = Journal(
        journalID: responseData['name'],
        title: title,
        description: description,
        issue_date: issue_date,
      );
//        print(newReflect.id);
      _journals.add(newJournal);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateJournal(
      String title, String description, String issue_date) async {
    _isLoading = true;
    notifyListeners();
    print('hi');
    print('${selectedJournal.id}');
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'issue_date': issue_date
    };
    return http
        .put('https://app.jasonwolverson.net/api/jounals/${selectedJournal.id}',
            headers: {
              'Content-Type': 'application/json',
              'Auth-Token': _authenticatedUser.token,
            },
            body: json.encode(updateData))
        .then((http.Response response) {
      print('${selectedJournal.journalID}');
      _isLoading = false;
      final Journal updatedJournal = Journal(
        journalID: selectedJournal.journalID,
        title: title,
        id: selectedJournal.id,
        description: description,
//            image: image,
//            price: price,
//            userEmail: selectedProduct.userEmail,
//            userId: selectedProduct.userId
      );
//        print('https://app.jasonwolverson.net/api/reflects/${selectedReflect.id}');
      _journals[selectedJournalIndex] = updatedJournal;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> deleteJournal() {
    _isLoading = true;
    print(selectedJournal.id);
    final deletedJournalId = selectedJournal.id;
    print(deletedJournalId);
    _journalAll.removeAt(selectedJournalIndex);
    _selJournalId = null;
    notifyListeners();
    return http.delete(
      'https://app.jasonwolverson.net/api/journals/${deletedJournalId}',
      headers: {
        'Content-Type': 'application/json',
        'Auth-Token': _authenticatedUser.token,
      },
    ).then((http.Response response) {
      print(response.body);
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchJournalALL() async {
//    String message = 'Something went wrong.';
    _isLoading = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
//    print(token);

    if (token != null) {
      final String userEmail = prefs.getString('userEmail');
      final String userGender = prefs.getString('userGender');
      final int userDob = prefs.getInt('userDob');
//      final String userId = prefs.getString('id');
      _authenticatedUser = User(
          email: userEmail,
          token: token,
          gender: userGender,
          date_of_birth: userDob);
      print(userEmail);
      print(token);
      print(userGender);
      print(userDob);
    }

    return http.get(
      'https://app.jasonwolverson.net/api/journals/my_journals',
      headers: {'Auth-Token': _authenticatedUser.token},
    ).then<Null>((http.Response response) {
      print('response');
      print(response.body);

      final List<Journal> fetchJournalList = [];

      final Map<String, dynamic> journalListData = jsonDecode(response.body);

      print(journalListData);

//      if (journalListData['message']=='No journal found for this date'){
//        message = 'No journal found for this date';
//        return {message:'message'};
//      }

      if (journalListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
//      final String journTitle  = prefs.getString('journTitle');
//
//      final String journTitle;
//      _journal = Journal(title:journTitle);
//      print(journTitle);

      journalListData.forEach((String journalId, dynamic journalData) {
        final Journal journal = Journal(
          journalID: journalId,
          id: journalData['id'],
          title: journalData['title'],
          description: journalData['description'],
          issue_date: journalData['issue_date'],

//          description: newsData['description'],
        );
        print(journal.issue_date);
        fetchJournalList.add(journal);
      });
      _journalAll = fetchJournalList;
//      print('newsssssss');
//      print(_journals);
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });

//    return {message:'message'};
  }

  Future<Null> fetchJournals() async {
//    String message = 'Something went wrong.';
    _isLoading = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
//    print(token);

    if (token != null) {
      final String userEmail = prefs.getString('userEmail');
      final String userGender = prefs.getString('userGender');
      final int userDob = prefs.getInt('userDob');
//      final String userId = prefs.getString('id');
      _authenticatedUser = User(
          email: userEmail,
          token: token,
          gender: userGender,
          date_of_birth: userDob);
      print(userEmail);
      print(token);
      print(userGender);
      print(userDob);
    }

    return http.get(
      'https://app.jasonwolverson.net/api/journals/by_issue_date?issue_date=' +
          _selectDate,
      headers: {'Auth-Token': _authenticatedUser.token},
    ).then<Null>((http.Response response) {
      print('response');
      print(response.body);

      final List<Journal> fetchJournalList = [];

      final Map<String, dynamic> journalListData = jsonDecode(response.body);

      print(journalListData);

//      if (journalListData['message']=='No journal found for this date'){
//        message = 'No journal found for this date';
//        return {message:'message'};
//      }

      if (journalListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
//      final String journTitle  = prefs.getString('journTitle');
//
//      final String journTitle;
//      _journal = Journal(title:journTitle);
//      print(journTitle);

      journalListData.forEach((String journalId, dynamic journalData) {
        final Journal journal = Journal(
          journalID: journalId,
          id: journalData['id'],
          title: journalData['title'],
          description: journalData['description'],
          issue_date: journalData['issue_date'],

//          description: newsData['description'],
        );
        print(journal.issue_date);
        fetchJournalList.add(journal);
      });
      _journals = fetchJournalList;
//      print('newsssssss');
//      print(_journals);
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });

//    return {message:'message'};
  }

  void selectJournal(String journalId) {
    _selJournalId = journalId;
    notifyListeners();
  }
}

mixin DailyPlansModel on ConnectedNewsModel {
  List<DailyPlans> get alldailyPlans {
    return List.from(_dailyplans);
  }

  Future<Null> fetchDailyPlans() async {
    print('dailyplans controller');
    _isLoading = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
//    print(token);

    if (token != null) {
      final String userEmail = prefs.getString('userEmail');
      final String userGender = prefs.getString('userGender');
      final int userDob = prefs.getInt('userDob');
//      final String userId = prefs.getString('id');
      _authenticatedUser = User(
          email: userEmail,
          token: token,
          gender: userGender,
          date_of_birth: userDob);
      print(userEmail);
      print(token);
      print(userGender);
      print(userDob);
    }

    return http.get(
      'https://app.jasonwolverson.net/api/daily_plans',
      headers: {'Auth-Token': _authenticatedUser.token},
    ).then<Null>((http.Response response) {
      print('response');

      final List<DailyPlans> fetchDailyPlanList = [];

      final Map<String, dynamic> dailyplansListData = jsonDecode(response.body);
      print(dailyplansListData);

      if (dailyplansListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      dailyplansListData.forEach((String dailyPlansId, dynamic dailyPlansData) {
//        print('newsssssss');
        final DailyPlans dailyPlans = DailyPlans(
          id: dailyPlansId,
          title: dailyPlansData['title'],
          time: dailyPlansData['time'],

//          description: newsData['description'],
        );
        print(dailyPlans);
        fetchDailyPlanList.add(dailyPlans);
      });
      _dailyplans = fetchDailyPlanList;
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}

mixin UserTasksModel on ConnectedNewsModel {
  int get selectedTaskIndex {
    return _usertasks.indexWhere((UserTasks userTask) {
      return userTask.UserTaskID == _userTaskId;
//    print('hoooo');
//      print(userTask.id);
    });
  }

  String get SelectedUserTaskId {
    return _userTaskId;
  }

  UserTasks get SelectedUserTask {
    if (SelectedUserTaskId == null) {
      return null;
    }
    return _usertasks.firstWhere((UserTasks userTask) {
      return userTask.UserTaskID == _userTaskId;

//      print(userTask.id);
    });
  }

//  void selectUserTask(int TaskId){
//    _selectDailyPlan = TaskId;
//    print(_selectDailyPlan);
//    notifyListeners();
////    return;
//  }

  void selectUserTask(String TaskId) {
    _userTaskId = TaskId;
    notifyListeners();
//    return;
  }

  Future<Null> getWeeklyrogress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    return http.get(
      'https://app.jasonwolverson.net/api/reports/weekly',
      headers: {'Auth-Token': token, 'Content-Type': 'application/json'},
    ).then((http.Response reponse) {
      print("weekly progress");
      print(reponse.body);

      notifyListeners();
      return true;
    }).catchError((error) {
      print(error);
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> updateUserTasks(String status) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> updateData = {'status': status};

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    if (token != null) {
      final String userEmail = prefs.getString('userEmail');
      final String userGender = prefs.getString('userGender');
      final int userDob = prefs.getInt('userDob');
      _authenticatedUser = User(
          email: userEmail,
          token: token,
          gender: userGender,
          date_of_birth: userDob);
    }

    return http
        .put('https://app.jasonwolverson.net/api/user_tasks/+${SelectedUserTask.id}',
            headers: {
              'Auth-Token': _authenticatedUser.token,
              'Content-Type': 'application/json'
            },
            body: json.encode(updateData))
        .then((http.Response reponse) {
//      print(reponse.body);
      _isLoading = false;
      final UserTasks userTasks = UserTasks(
        status: status,
        id: SelectedUserTask.id,
        title: SelectedUserTask.title,
        UserTaskID: SelectedUserTask.UserTaskID,
      );

      _usertasks[selectedTaskIndex] = userTasks;

      notifyListeners();
      return true;
    }).catchError((error) {
      print(error);
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  List<UserTasks> get alluserTasks {
    return List.from(_usertasks);
  }

  Future<Null> fetchUserTasks() async {
    _isLoading = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
//    print(token);

    if (token != null) {
      final String userEmail = prefs.getString('userEmail');
      final String userGender = prefs.getString('userGender');
      final int userDob = prefs.getInt('userDob');
//      final String userId = prefs.getString('id');
      _authenticatedUser = User(
          email: userEmail,
          token: token,
          gender: userGender,
          date_of_birth: userDob);
//      print(userEmail);
//      print(token);
//      print(userGender);
//      print(userDob);

    }

    return http.get(
      'https://app.jasonwolverson.net/api/user_tasks',
      headers: {'Auth-Token': _authenticatedUser.token},
    ).then<Null>((http.Response response) {
      print(response.body);

      final List<UserTasks> fetchUserTaskList = [];

      final Map<String, dynamic> userTasksListData = jsonDecode(response.body);

      if (userTasksListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      userTasksListData.forEach((String userTasksId, dynamic userTasksData) {
//        print('newsssssss');
        final UserTasks userTasks = UserTasks(
            UserTaskID: userTasksId,
            title: userTasksData['title'],
            time: userTasksData['time'],
            status: userTasksData['status'],
            id: userTasksData['id']);
        print(userTasks.status);
        fetchUserTaskList.add(userTasks);
      });
      _usertasks = fetchUserTaskList;
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

//  void selectTask(String TaskId){
//    _userTaskId = TaskId;
//    notifyListeners();
//  }
}

mixin CommentModel on ConnectedNewsModel {}

mixin InspirationModel on ConnectedNewsModel {
  List<Comment> get allComments {
    return List.from(_comments);
  }

  List<Inspiration> get allInspiratios {
    return List.from(_inspirations);
  }

  List<LikeObject> get allLikeObjects {
    return List.from(likeList);
  }

  int get selectedInspirationsIndex {
    return _inspirations.indexWhere((Inspiration inspiration) {
      return inspiration.inspirationID == _selInspirationId;
    });
  }

  String get selectedInspirationsId {
    return _selInspirationId;
  }

  Inspiration get selectedInspirations {
    if (selectedInspirationsId == null) {
      return null;
    }

    return _inspirations.firstWhere((Inspiration inspiration) {
      return inspiration.inspirationID == _selInspirationId;
    });
  }

  Future<Null> fetchInspirations() async {
    _isLoading = true;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    if (token != null) {
      final String userEmail = prefs.getString('userEmail');
      final String userGender = prefs.getString('userGender');
      final int userDob = prefs.getInt('userDob');
//      final String userId = prefs.getString('id');
      _authenticatedUser = User(
          email: userEmail,
          token: token,
          gender: userGender,
          date_of_birth: userDob);
      print(userEmail);
      print(token);
    }

    return http.get(
      'https://app.jasonwolverson.net/api/inspirations',
      headers: {'Auth-Token': _authenticatedUser.token},
    ).then<Null>((http.Response response) {
//        print(response.body);
      print(";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;");
      final List<Inspiration> fetchInspirations = [];
      print(response);
      final Map<String, dynamic> inspirationsListData =
          jsonDecode(response.body);
      print(inspirationsListData);

      if (inspirationsListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      inspirationsListData
          .forEach((String inspirationId, dynamic inspirationData) {
        final Inspiration inspiration = Inspiration(
          inspirationID: inspirationId,
          title: inspirationData['title'],
          file_content_type: inspirationData['file_content_type'],
          file: inspirationData['file'],
          id: inspirationData['id'],
          likes: inspirationData['likes'],
          isliked: inspirationData['liked'],
          isdisliked: inspirationData['disliked'],
//          time: inspirationData['time'],

//          description: newsData['description'],
        );
        print(inspiration.isliked);
        fetchInspirations.add(inspiration);
      });
      _inspirations = fetchInspirations;
      print('nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
      for (int i = 0; i <= _inspirations.length; i++) {
        likeList.add(LikeObject(flag: _inspirations[i].isliked ? true : false));
      }

      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<bool> updateInspiration(String status, int id) {
    notifyListeners();
    print("in apiiiiiiiiiiiii");
    final Map<String, dynamic> LikeData = {'status': status};
    return http
        .post('https://app.jasonwolverson.net/api/inspirations/$id/likes',
            headers: {
              'Content-Type': 'application/json',
              'Auth-Token': _authenticatedUser.token,
            },
            body: json.encode(LikeData))
        .then((http.Response response) {
      print("api hiting");
      print(response.body);
      _isLoading = false;
//      final Inspiration likeInspirantions = Inspiration(
//        status: status,
//        id: selectedInspirations.id,
//        title: selectedInspirations.title,
//        inspirationID: selectedInspirations.inspirationID,
//      );
//      _inspirations.add(likeInspirantions);
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> AddComment(String description) async {
    print(description);
    print('ho');
    print(selectedInspirations.inspirationID);
    print('ho');
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> CommentData = {'description': description};

    try {
      final http.Response response = await http.post(
          'https://app.jasonwolverson.net/api/inspirations/${selectedInspirations.id}/comments',
          headers: {
            'Content-Type': 'application/json',
            'Auth-Token': _authenticatedUser.token,
          },
          body: json.encode(CommentData));

      print(response.body);
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      final Comment newComment = Comment(
        description: description,
      );
//        print(newReflect.id);
      _comments.add(newComment);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<Null> fetchInspirationComments() async {
    _isLoading = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
//    print(token);

    if (token != null) {
      final String userEmail = prefs.getString('userEmail');
      final String userGender = prefs.getString('userGender');
      final int userDob = prefs.getInt('userDob');
//      final String userId = prefs.getString('id');
      _authenticatedUser = User(
          email: userEmail,
          token: token,
          gender: userGender,
          date_of_birth: userDob);
      print(userEmail);
      print(token);
    }

    return http.get(
      'https://app.jasonwolverson.net/api/inspirations/${selectedInspirations.id}/comments',
      headers: {'Auth-Token': _authenticatedUser.token},
    ).then<Null>((http.Response response) {
      print(response.body);

      final List<Comment> fetchInspirationsComments = [];

      final Map<String, dynamic> inspirationsCommentListData =
          jsonDecode(response.body);
      print(inspirationsCommentListData);

      if (inspirationsCommentListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      inspirationsCommentListData
          .forEach((String commentId, dynamic commentData) {
        final Comment comment = Comment(
          commentID: commentId,
          description: commentData['description'],
        );
        print(comment.description);
        fetchInspirationsComments.add(comment);
      });
      _comments = fetchInspirationsComments;
      print(_comments);
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }

  Future<Map<String, dynamic>> checkSubscription() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    notifyListeners();
    Response response;
    try {
      final response = await http.get(
        'https://app.jasonwolverson.net/api/subscription_status',
        headers: {'Auth-Token': _authenticatedUser.token},
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> finalData = responseData['user'];
      print("respoceeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      print(finalData['subscription_status']);
      print(response.statusCode);
      if (response.statusCode == 200) {
        if (finalData['subscription_status'] == "active")
          return {'success': "true"};
        else
          return {'success': "false"};
      } else
        print("server Error");
      return {'data': 'server error'};
    } catch (e) {
      print(e);
      notifyListeners();
      print('helo error');
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> cancelSubscription() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.get('token');
    notifyListeners();
    Response response;
    try {
      final response = await http.get(
        'https://app.jasonwolverson.net/api/subscription_cancel_url',
        headers: {'Auth-Token': _authenticatedUser.token},
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> finalData = responseData['data'];
      if (response.statusCode == 200) {
        var result = await finalcancelSubscription(finalData);
        return {'success': true,'data': result};
//        else
//          return {'success' : "false"};
      } else
        print("server Error");
      return {'success':false,'data': 'null'};
    } catch (e) {
      print(e);
      notifyListeners();
      print('helo error');
      return {'success': false, 'data':'null'};
    }
  }

  Future<Map<String, dynamic>> finalcancelSubscription(
      var cancelSubscriptionData) async {
    Map<String, String> headers = {
      "merchant-id": cancelSubscriptionData['merchant-id'].toString(),
      "version": cancelSubscriptionData['version'],
      "timestamp": cancelSubscriptionData['timestamp'],
      "signature": cancelSubscriptionData['signature']
    };
    try {
      http.Response response = await http.put(
        cancelSubscriptionData['url'].toString(),
        headers: headers,
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
//      final Map<String, dynamic> finalData = responseData['user'];
      if (response.statusCode == 200) {
        return responseData;
      } else
        print("server Error");
      return {'data': 'server error'};
    } catch (e) {
      print(e);
      notifyListeners();
      print('helo error');
      return {'success': false};
    }
  }

  Future<bool> unlikeInspiration() {
    _isLoading = true;
    notifyListeners();

    return http.delete(
      'https://app.jasonwolverson.net/api/inspirations/${selectedInspirations.id}/likes',
      headers: {
        'Content-Type': 'application/json',
        'Auth-Token': _authenticatedUser.token,
      },
    ).then((http.Response response) {
      print(response.body);
      _isLoading = false;
//      print('hi');
      final Inspiration updatedInspiration = Inspiration(
//        reflectID: selectedReflect.reflectID,
//        userID: _authenticatedUser.token,
        id: selectedInspirations.id,
        inspirationID: selectedInspirations.inspirationID,
        likes: selectedInspirations.likes,
//        description: description,
//            image: image,
//            price: price,
//            userEmail: selectedProduct.userEmail,
//            userId: selectedProduct.userId
      );
      print(updatedInspiration.likes);
////        print('https://app.jasonwolverson.net/api/reflects/${selectedReflect.id}');
//      print(_likes[selectedInspirationsIndex]);
//      _inspirations[selectedInspirationsIndex] = updatedInspiration;
      print(updatedInspiration.likes);
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  void selectInspiration(String inspirationId) {
    _selInspirationId = inspirationId;
    notifyListeners();
  }
}

mixin NewsModel on ConnectedNewsModel {
  List<News> get allNews {
    return List.from(_news);
  }

  Future<Null> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
//    print(token);

    if (token != null) {
      final String userEmail = prefs.getString('userEmail');
//      final String userId = prefs.getString('id');
      _authenticatedUser = User(email: userEmail, token: token);
    }

    return http.get(
      'https://app.jasonwolverson.net/api/posts',
      headers: {'Auth-Token': _authenticatedUser.token},
    ).then<Null>((http.Response response) {
      print(response.body);

      final List<News> fetchNewList = [];

      final Map<String, dynamic> newsListData = jsonDecode(response.body);

      if (newsListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      newsListData.forEach((String newsId, dynamic newsData) {
        final News news = News(
          id: newsId,
          title: newsData['title'],
          description: newsData['description'],
        );
        print(news.description);
        fetchNewList.add(news);
      });
      _news = fetchNewList;
      print(_news);
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}

mixin EventModel on ConnectedNewsModel {
  List<Events> get allEvents {
    return List.from(_events);
  }

  Future<Null> fetchEvents() async {
    _isLoading = true;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
//    print(token);

    if (token != null) {
      final String userEmail = prefs.getString('userEmail');
//      final String userId = prefs.getString('id');
      _authenticatedUser = User(email: userEmail, token: token);
    }

    return http.get(
      'https://app.jasonwolverson.net/api/events',
      headers: {'Auth-Token': _authenticatedUser.token},
    )
//    return http .get('https://jsonplace
//    lder.typicode.com/photos',
//      headers: {'Auth-Token':_authenticatedUser.token},
//    )

        .then<Null>((http.Response response) {
      print(response.body);
//            print('hi');
//            print('${_authenticatedUser.token}');

      final List<Events> fetchEventList = [];

      final Map<String, dynamic> newsListData = jsonDecode(response.body);

//              var jsonData = json.decode(response.body);

//              print(newsListData);
      if (newsListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      print('working');

      newsListData.forEach((String newsId, dynamic newsData) {
        final Events events = Events(
            id: newsId,
            eventId: newsData['id'],
            title: newsData['title'],
            description: newsData['description'],
            scheduled_date: newsData['scheduled_date'],
            upcoming: newsData['upcoming'],
            price: newsData['price'].toString(),
            status: newsData['status'].toString());
        print(events.description);
        fetchEventList.add(events);
      });
      _events = fetchEventList;
      print(_events);
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return;
    });
  }
}

mixin ReflectModel on ConnectedNewsModel {
  bool isApiHit = false;

  List<Reflect> get allReflects {
    return List.from(_reflects);
  }

  List<Reflect> get displayedProducts {
//    if (_showFavorites) {
//      return _products.where((Product product) => product.isFavorite).toList();
//    }
    return List.from(_reflects);
  }

  int get selectedReflectIndex {
    return _reflects.indexWhere((Reflect reflect) {
      return reflect.reflectID == _selReflectId;
    });
  }

  String get selectedReflectId {
    return _selReflectId;
  }

  Reflect get selectedReflect {
    if (selectedReflectId == null) {
      return null;
    }

    return _reflects.firstWhere((Reflect reflect) {
      return reflect.reflectID == _selReflectId;
    });
  }

  Future<bool> addReflect(String title, String description) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    _isLoading = true;
    print("add");
    notifyListeners();
    final Map<String, dynamic> ReflectData = {
      'title': title,
      'description': description
    };

    try {
      final http.Response response =
          await http.post('https://app.jasonwolverson.net/api/reflects',
              headers: {
                'Content-Type': 'application/json',
                'Auth-Token': token,
              },
              body: json.encode(ReflectData));

      print("response  ${response.body}");
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      final Reflect newReflect = Reflect(
        reflectID: responseData['name'],
        title: title,
//            reflectID : responseData['id'],
        description: description,
//            userEmail: _authenticatedUser.email,
//            userId: _authenticatedUser.id
      );
//        print(newReflect.id);
      _reflects.add(newReflect);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      print(error);
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateReflect(String title, String description) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    _isLoading = true;
    notifyListeners();
    print('${selectedReflect.id}');
    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
//        'image':
//        'https://upload.wikimedia.org/wikipedia/commons/6/68/Chocolatebrownie.JPG',
//        'price': price,
//        'userEmail': selectedProduct.userEmail,
//        'userId': selectedProduct.userId
    };
    return http
        .put('https://app.jasonwolverson.net/api/reflects/${selectedReflect.id}',
            headers: {
              'Content-Type': 'application/json',
              'Auth-Token': token,
            },
            body: json.encode(updateData))
        .then((http.Response response) {
      print('${selectedReflect.reflectID}');
      _isLoading = false;
      final Reflect updatedReflect = Reflect(
        reflectID: selectedReflect.reflectID,
        title: title,
        id: selectedReflect.id,
        description: description,
//            image: image,
//            price: price,
//            userEmail: selectedProduct.userEmail,
//            userId: selectedProduct.userId
      );
//        print('https://app.jasonwolverson.net/api/reflects/${selectedReflect.id}');
      _reflects[selectedReflectIndex] = updatedReflect;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<bool> deleteReflect() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    _isLoading = true;
    print(selectedReflect.id);
    final deletedReflectId = selectedReflect.id;
    print(deletedReflectId);
    _reflects.removeAt(selectedReflectIndex);
    _selReflectId = null;
    notifyListeners();
    return http.delete(
      'https://app.jasonwolverson.net/api/reflects/${deletedReflectId}',
      headers: {
        'Content-Type': 'application/json',
        'Auth-Token': token,
      },
    ).then((http.Response response) {
      print(response.body);
      _isLoading = false;
      notifyListeners();
      return true;
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      return false;
    });
  }

  Future<Null> fetchReflects() async {
//    _isLoading = true;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");

    notifyListeners();
    return http.get(
      'https://app.jasonwolverson.net/api/reflects/',
      headers: {'Auth-Token': token},
    ).then<Null>((http.Response response) {
      final List<Reflect> fetchedReflectList = [];
      print("reflects = ${response.body}");
      final Map<String, dynamic> productListData = json.decode(response.body);

      print("reflects products  = $productListData");
      if (response.body.isNotEmpty) {
        print("print");
        _isLoading = false;
        this.isApiHit = true;
        notifyListeners();
        return;
      }

      productListData.forEach((String productId, dynamic productData) {
        final Reflect product = Reflect(
          reflectID: productId,
          title: productData['title'],
          description: productData['description'],
          id: productData['id'],
//            image: productData['image'],
//            price: productData['price'],
//            userEmail: productData['userEmail'],
//            userId: productData['userId']
        );
        fetchedReflectList.add(product);
      });
      _reflects = fetchedReflectList;
      _isLoading = false;
      this.isApiHit = true;
      notifyListeners();
      _selReflectId = null;
    }).catchError((error) {
      _isLoading = false;
      this.isApiHit = true;
      notifyListeners();
      return;
    });
  }

  void selectReflect(String reflectId) {
    _selReflectId = reflectId;
    notifyListeners();
  }
}

mixin UserModel on ConnectedNewsModel {
  User get user {
    return _authenticatedUser;
  }

//  print (_authenticatedUser);

  Future<Map<String, dynamic>> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'auth_token': true
    };
    print("inloginAPi");
    final http.Response response = await http.post(
      'https://app.jasonwolverson.net/api/auth/login',
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );
    print(response);
    final Map<String, dynamic> responseData = json.decode(response.body);
    print("inloginAPi");
    print(responseData);
    bool hasError = true;
    String message = 'Something went wrong.';
    print(responseData);
    print('access token is -> ${json.decode(response.body)['auth_token']}');
//        print('access token is -> ${data}');
    print((responseData.containsKey('auth_token')));
    if (responseData.containsKey(('auth_token'))) {
//      if (json.decode(response.body)['data']['user']['auth_token']) {
      hasError = false;
      message = 'Authentication succeeded!';
      _authenticatedUser = User(
          id: responseData['id'],
          email: email,
          token: responseData['auth_token']);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['auth_token']);
      prefs.setString('userEmail', email);
//      prefs.setString('gender', responseData['gender']);
//      prefs.setInt('date_of_birth', responseData['date_of_birth']);
      prefs.setInt('userId', responseData['id']);
    } else if (responseData['message'] == 'Invalid Email') {
      message = 'This email was not found.';
    } else if (responseData['message'] == 'Incorrect Password') {
      message = 'The password is invalid.';
    }
    _isLoading = false;
    notifyListeners();

    return {'success': !hasError, 'message': message};
  }

  Future<Map<String, dynamic>> signup(
      String email, String password, date_of_birth, gender) async {
    _isLoading = true;
    print(email);
    print(password);
    print(date_of_birth);
    print(gender);
    notifyListeners();
    final Map<String, dynamic> authData = {
      'user': {
        'email': email,
        'password': password,
        'date_of_birth': date_of_birth,
        'gender': gender,
        'auth_token': true,
      }
    };
    final http.Response response = await http.post(
      'https://app.jasonwolverson.net/api/users',
//    'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyDRNWISSlMAV8cduZYT9sEVKhRx6qdwJcc',
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
    );

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
    bool hasError = true;
    String message = 'Something went wrong.';
    print(responseData);
    print('access token is -> ${json.decode(response.body)['auth_token']}');
//        print('access token is -> ${data}');
    print((responseData.containsKey('auth_token')));
    if (responseData.containsKey(('auth_token'))) {
//      if (json.decode(response.body)['data']['user']['auth_token']) {
      hasError = false;
      message = 'Authentication succeeded!';
      _authenticatedUser = User(
          id: responseData['id'],
          email: email,
          token: responseData['auth_token']);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', responseData['auth_token']);
      prefs.setString('userEmail', email);
      prefs.setInt('userId', responseData['id']);
    } else if (responseData['message'] == 'Email has already been taken') {
      message = 'Email has already been taken.';
    } else if (responseData['message'] ==
        'Password is too short (minimum is 6 characters)') {
      message = 'Password is too short (minimum is 6 characters).';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

  void logout() async {
    _authenticatedUser = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
  }

  void autoAuthenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    if (token != null) {
      final String userEmail = prefs.getString('userEmail');
      _authenticatedUser = User(email: userEmail, token: token);

      notifyListeners();
    }
  }
}

mixin UtilityModel on ConnectedNewsModel {
  bool get isLoading {
    return _isLoading;
  }
}
