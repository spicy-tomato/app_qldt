part of 'avatar_bloc.dart';

class AvatarState extends Equatable {
  final File file;

  const AvatarState({required this.file});

  AvatarState copyWith({File? file}) {
    return AvatarState(file: file ?? this.file);
  }

  @override
  List<Object> get props => [file];
}

class AvatarInitial extends AvatarState {
  AvatarInitial(avatarPath) : super(file: File(avatarPath));
}
