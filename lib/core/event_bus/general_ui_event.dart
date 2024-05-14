abstract class GeneralUiEvent {}

class UIShowSnackbar extends GeneralUiEvent {
  final String message;

  UIShowSnackbar(this.message);
}
