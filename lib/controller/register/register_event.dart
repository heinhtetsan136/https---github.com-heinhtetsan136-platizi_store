abstract class RegisterBaseEvent {
  const RegisterBaseEvent();
}

class RegisterEvent extends RegisterBaseEvent {
  const RegisterEvent();
}

class RegisterPickPhotoEvent extends RegisterBaseEvent {
  const RegisterPickPhotoEvent();
}
