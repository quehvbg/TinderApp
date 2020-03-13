import 'package:tinder/src/data/model/user_data.dart';
import 'package:tinder/src/utils/dependency_injection.dart';

abstract class MediaPageContract {
  void showPeople(User user);
  void showFavoritePeople();
  void showError(String message);
}

class MediaPagePresenter {
  MediaPageContract _view;
  UserRepository _repository;

  MediaPagePresenter(this._view) {
    _repository = new Injector().userRepository;
  }

  void nextPeople() {
    assert(_view != null);
    _repository.fetchUser().then((user) {
      _view.showPeople(user);
    }).catchError((onError) {
      _view.showError(onError.toString());
    });
  }

  void addFavorite(User user) {
    print("Add to favorite");
    _repository.createUser(user);
    _repository.fetchUser().then((user) {
      _view.showPeople(user);
    }).catchError((onError) {
      _view.showError(onError.toString());
    });
  }
}
