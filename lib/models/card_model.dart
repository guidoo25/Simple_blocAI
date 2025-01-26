import 'package:equatable/equatable.dart';

class Card extends Equatable {
  final String imageUrl;
  final String description;
  final int damage;
  final bool isPlayer;

  const Card({
    required this.imageUrl,
    required this.description,
    this.damage = 0,
    this.isPlayer = true,
  });

  @override
  List<Object?> get props => [imageUrl, description, damage, isPlayer];

  Card copyWith({
    String? imageUrl,
    String? description,
    int? damage,
    bool? isPlayer,
  }) {
    return Card(
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      damage: damage ?? this.damage,
      isPlayer: isPlayer ?? this.isPlayer,
    );
  }
}

class GameState extends Equatable {
  final List<Card> playerCards;
  final List<Card> enemyCards;
  final bool isGameActive;
  final bool isPlayerTurn;

  const GameState({
    this.playerCards = const [],
    this.enemyCards = const [],
    this.isGameActive = false,
    this.isPlayerTurn = true,
  });

  @override
  List<Object?> get props =>
      [playerCards, enemyCards, isGameActive, isPlayerTurn];

  GameState copyWith({
    List<Card>? playerCards,
    List<Card>? enemyCards,
    bool? isGameActive,
    bool? isPlayerTurn,
  }) {
    return GameState(
      playerCards: playerCards ?? this.playerCards,
      enemyCards: enemyCards ?? this.enemyCards,
      isGameActive: isGameActive ?? this.isGameActive,
      isPlayerTurn: isPlayerTurn ?? this.isPlayerTurn,
    );
  }
}
