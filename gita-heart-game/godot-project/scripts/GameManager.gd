

extends Node

# Singleton for managing game state and settings
# This will be autoloaded to be accessible from anywhere

signal language_changed(new_language)
signal score_changed(new_score)
signal game_mode_changed(new_mode)

enum Language {
	SANSKRIT,
	ENGLISH,
	HINDI
}

enum GameMode {
	MENU,
	VERSE_COMPLETION,
	VERSE_IDENTIFICATION,
	CHAPTER_SEQUENCE
}

var current_language = Language.ENGLISH
var current_game_mode = GameMode.MENU
var current_score = 0
var games_played = 0
var correct_answers = 0
var enable_scoring = true

# Language settings
var language_names = {
	Language.SANSKRIT: "Sanskrit",
	Language.ENGLISH: "English", 
	Language.HINDI: "Hindi"
}

var language_codes = {
	Language.SANSKRIT: "sanskrit",
	Language.ENGLISH: "english",
	Language.HINDI: "hindi"
}

func _ready():
	print("GameManager initialized")

func set_language(new_language: Language):
	if new_language != current_language:
		current_language = new_language
		language_changed.emit(new_language)
		print("Language changed to: ", language_names[new_language])

func get_current_language_code():
	return language_codes[current_language]

func get_current_language_name():
	return language_names[current_language]

func set_game_mode(mode: GameMode):
	current_game_mode = mode
	game_mode_changed.emit(mode)
	print("Game mode changed to: ", get_game_mode_name(mode))

func add_score(points: int):
	if enable_scoring:
		current_score += points
		score_changed.emit(current_score)

func reset_score():
	current_score = 0
	games_played = 0
	correct_answers = 0
	score_changed.emit(current_score)

func record_answer(is_correct: bool):
	games_played += 1
	if is_correct:
		correct_answers += 1
		add_score(10)  # Base score for correct answer

func get_accuracy():
	if games_played == 0:
		return 0.0
	return float(correct_answers) / float(games_played) * 100.0

func get_game_mode_name(mode: GameMode = current_game_mode):
	match mode:
		GameMode.VERSE_COMPLETION:
			return "Verse Completion"
		GameMode.VERSE_IDENTIFICATION:
			return "Verse Identification"
		GameMode.CHAPTER_SEQUENCE:
			return "Chapter Sequence"
		_:
			return "Main Menu"

func toggle_scoring(enabled: bool):
	enable_scoring = enabled
	if not enabled:
		reset_score()

# Debug functions
func print_game_stats():
	print("=== Game Statistics ===")
	print("Current Mode: ", get_game_mode_name())
	print("Language: ", get_current_language_name())
	print("Score: ", current_score)
	print("Games Played: ", games_played)
	print("Correct Answers: ", correct_answers)
	print("Accuracy: ", "%.1f" % get_accuracy(), "%")
	print("Scoring Enabled: ", enable_scoring)
	print("=====================")


