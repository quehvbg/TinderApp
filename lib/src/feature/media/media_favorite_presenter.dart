import 'package:tinder/src/data/model/user_data.dart';
import 'package:tinder/src/utils/dependency_injection.dart';

abstract class FavoritePageContract {
  void unFavorite(User user);
  void showFavorires(List<User> users);
  void showError(String message);
}

class FavoritePagePresenter {
  FavoritePageContract _view;
  UserRepository _repository;

  FavoritePagePresenter(this._view) {
    _repository = new Injector().userRepository;
  }

  void loadFavoritePeople() {
    assert(_view != null);
    _repository.getAllUser().then((users) {
      _view.showFavorires(users);
    }).catchError((onError) {
      _view.showError(onError.toString());
    });
  }
}
