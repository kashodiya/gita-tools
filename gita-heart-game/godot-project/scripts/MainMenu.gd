

extends Control

# Main Menu scene script

@onready var title_label = $VBoxContainer/TitleLabel
@onready var language_option = $VBoxContainer/SettingsContainer/LanguageContainer/LanguageOption
@onready var scoring_checkbox = $VBoxContainer/SettingsContainer/ScoringContainer/ScoringCheckbox
@onready var verse_completion_btn = $VBoxContainer/GameModesContainer/VerseCompletionBtn
@onready var verse_identification_btn = $VBoxContainer/GameModesContainer/VerseIdentificationBtn
@onready var chapter_sequence_btn = $VBoxContainer/GameModesContainer/ChapterSequenceBtn
@onready var score_label = $VBoxContainer/ScoreContainer/ScoreLabel

func _ready():
	setup_ui()
	connect_signals()
	update_score_display()

func setup_ui():
	# Setup language dropdown
	language_option.clear()
	language_option.add_item("English")
	language_option.add_item("Sanskrit") 
	language_option.add_item("Hindi")
	language_option.selected = GameManager.current_language
	
	# Setup scoring checkbox
	scoring_checkbox.button_pressed = GameManager.enable_scoring
	
	# Wait for data to load before enabling buttons
	if not DataManager.is_data_loaded:
		disable_game_buttons()
		DataManager.data_loaded.connect(_on_data_loaded)
	else:
		enable_game_buttons()

func connect_signals():
	# Connect button signals
	verse_completion_btn.pressed.connect(_on_verse_completion_pressed)
	verse_identification_btn.pressed.connect(_on_verse_identification_pressed)
	chapter_sequence_btn.pressed.connect(_on_chapter_sequence_pressed)
	
	# Connect settings signals
	language_option.item_selected.connect(_on_language_changed)
	scoring_checkbox.toggled.connect(_on_scoring_toggled)
	
	# Connect game manager signals
	GameManager.score_changed.connect(_on_score_changed)

func disable_game_buttons():
	verse_completion_btn.disabled = true
	verse_identification_btn.disabled = true
	chapter_sequence_btn.disabled = true
	verse_completion_btn.text = "Loading..."
	verse_identification_btn.text = "Loading..."
	chapter_sequence_btn.text = "Loading..."

func enable_game_buttons():
	verse_completion_btn.disabled = false
	verse_identification_btn.disabled = false
	chapter_sequence_btn.disabled = false
	verse_completion_btn.text = "Verse Completion"
	verse_identification_btn.text = "Verse Identification"
	chapter_sequence_btn.text = "Chapter Sequence"

func update_score_display():
	if GameManager.enable_scoring:
		score_label.text = "Score: " + str(GameManager.current_score)
		score_label.visible = true
	else:
		score_label.visible = false

# Signal handlers
func _on_data_loaded():
	enable_game_buttons()
	print("Data loaded, game buttons enabled")

func _on_verse_completion_pressed():
	GameManager.set_game_mode(GameManager.GameMode.VERSE_COMPLETION)
	get_tree().change_scene_to_file("res://scenes/VerseCompletionGame.tscn")

func _on_verse_identification_pressed():
	GameManager.set_game_mode(GameManager.GameMode.VERSE_IDENTIFICATION)
	get_tree().change_scene_to_file("res://scenes/VerseIdentificationGame.tscn")

func _on_chapter_sequence_pressed():
	GameManager.set_game_mode(GameManager.GameMode.CHAPTER_SEQUENCE)
	get_tree().change_scene_to_file("res://scenes/ChapterSequenceGame.tscn")

func _on_language_changed(index: int):
	var new_language = GameManager.Language.values()[index]
	GameManager.set_language(new_language)

func _on_scoring_toggled(enabled: bool):
	GameManager.toggle_scoring(enabled)
	update_score_display()

func _on_score_changed(new_score: int):
	update_score_display()


