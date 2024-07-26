import 'package:flutter/foundation.dart';

class SharedData extends ChangeNotifier {
  String _birthdayData = ""; //사전정보 생년월일
  String _genderData = ""; //사전정보 성별
  String _positionData = ""; //사전정보 보호자/피보호자
  String _nicknameData = ""; //사전정보 닉네임
  List<String?> _interestData = []; //사전정보 관심사
  List<String?> _gominData = []; //사전정보 고민
  String _myanswerData = "답변을 입력해주세요."; //나의답변저장...? 굳이???? 삭제 예정
  String _questionData = "";
  String _connectCode = "";

  String get birthdayData => _birthdayData;
  String get genderData => _genderData;
  String get positionData => _positionData;
  String get nicknameData => _nicknameData;
  List<String?> get interestData => _interestData;
  List<String?> get gominData => _gominData;
  String get myanswerData => _myanswerData;
  String get questionData => _questionData;
  String get connectCode => _connectCode;

  void updateBirthdayData(String newData) {
    _birthdayData = newData;
    notifyListeners();
    print('updateBirthdayData_provider: $_birthdayData');
  }

  void updateGenderData(String newData) {
    _genderData = newData;
    notifyListeners();
    print('updateGenderData_provider: $_genderData');
  }

  void updatePositionData(String newData) {
    _positionData = newData;
    notifyListeners();
    print('updatePositionData_provider: $_positionData');
  }

  void updateNicknameData(String newData) {
    _nicknameData = newData;
    notifyListeners();
    print('updateNicknameData_provider: $_nicknameData');
  }

  void updateInterestData(List<String?> newData) {
    _interestData = newData;
    notifyListeners();
    print('updateInterestData_provider: $_interestData');
  }

  void updateGominData(List<String?> newData) {
    _gominData = newData;
    notifyListeners();
    print('updateGominData_provider: $_gominData');
  }

  void updateMyAnswerData(String newData) {
    _myanswerData = newData;
    notifyListeners();
    print('updateMyAnswerData_provider: $_myanswerData');
  }

  void updateQuestionData(String newData) {
    _questionData = newData;
    notifyListeners();
    print('updateQuestionData_provider: $_questionData');
  }

  void updateConnectCode(String newData) {
    _connectCode = newData;
    notifyListeners();
    print('updateQuestionData_provider: $_questionData');
  }
}

class UserIdManager {
  static final UserIdManager _instance = UserIdManager._internal();

  int? _userId; //from kakao

  factory UserIdManager() {
    return _instance;
  }

  UserIdManager._internal();

  int? get userId => _userId;

  void setUserId(int id) {
    _userId = id;
  }
}

class AccessTokenManager {
  static final AccessTokenManager _instance = AccessTokenManager._internal();

  String? _accessToken;

  factory AccessTokenManager() {
    return _instance;
  }

  AccessTokenManager._internal();

  String? get accessToken => _accessToken;

  void setAccessToken(String code) {
    _accessToken = code;
  }
}

class QuestionManager {
  static final QuestionManager _instance = QuestionManager._internal();

  String? _question = "질문을 불러오지 못했습니다.";
  int? _questionId;
  String _currentQuestion = '';
  bool _questionDone = false;
  List<String> _answerList = [];
  List<int> _userIds = [];

  factory QuestionManager() {
    return _instance;
  }

  QuestionManager._internal();

  String? get question => _question;
  int? get questionId => _questionId;
  String get currentQuestion => _currentQuestion;
  bool get questionDone => _questionDone;
  List<String> get answerList => _answerList;
  List<int> get userIds => _userIds;

  void setQuestion(String question) {
    _question = question;
    print('질문이 성공적으로 매니저에 저장되었습니다.');
  }

  void setQuestionId(int questionId) {
    _questionId = questionId;
  }

  void updateCurrentQuestion(String question) {
    _currentQuestion = question;
  }

  void updateQuestionDone(bool status) {
    _questionDone = status;
  }

  void updateAnswerList(List<String> answers, List<int> userIds) {
    _answerList = answers;
    _userIds = userIds;
  }
}

class CommentManager {
  static final CommentManager _instance = CommentManager._internal();

  factory CommentManager() {
    return _instance;
  }

  CommentManager._internal();
}

class FamilyManager {
  static final FamilyManager _instance = FamilyManager._internal();

  String? _familyCode;
  String? _ownerCode;
  int? _familyId;
  int? _count;
  List<String> _familyList = [];
  List<int> _userIds = [];
  bool _isCodeConnected = false;

  factory FamilyManager() {
    return _instance;
  }

  FamilyManager._internal();

  String? get familyCode => _familyCode; //유저가 생성한 코드
  String? get ownerCode => _ownerCode; //가족 리스트에 연결된 코드, 둘이 같으면 오너, 다르면 구성원
  int? get familyId => _familyId;
  int? get count => _count;
  List<String> get familyList => _familyList;
  List<int> get userIds => _userIds;
  bool get isCodeConnected => _isCodeConnected;

  void updateFamilyCode(String code) {
    _familyCode = code;
  }

  void updateFamilyId(int id) {
    _familyId = id;
  }

  void updateFamilyList(List<String> nicknames, List<int> userIds, int count) {
    _familyList = nicknames;
    _userIds = userIds;
    _count = count;

    print("가족 리스트가 업데이트 되었어요.");
  }

  void updateOwnerCode(String code) {
    _ownerCode = code;
  }

  void updateCodeConnected(bool isCodeConnected) {
    _isCodeConnected = isCodeConnected;
  }
}
