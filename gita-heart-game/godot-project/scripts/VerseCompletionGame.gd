


extends Control

# Verse Completion Game - Player sees one part of verse and completes the rest

@onready var instruction_label = $VBoxContainer/InstructionLabel
@onready var given_part_label = $VBoxContainer/VerseContainer/GivenPartLabel
@onready var input_container = $VBoxContainer/VerseContainer/InputContainer
@onready var input_field = $VBoxContainer/VerseContainer/InputContainer/InputField
@onready var submit_btn = $VBoxContainer/ButtonsContainer/SubmitBtn
@onready var next_btn = $VBoxContainer/ButtonsContainer/NextBtn
@onready var back_btn = $VBoxContainer/ButtonsContainer/BackBtn
@onready var feedback_label = $VBoxContainer/FeedbackLabel
@onready var score_label = $VBoxContainer/ScoreLabel
@onready var transliteration_label = $VBoxContainer/VerseContainer/TransliterationLabel
@onready var play_audio_btn = $VBoxContainer/ButtonsContainer/PlayAudioBtn

var current_verse = null
var verse_parts = []
var given_part_index = 0
var missing_parts = []
var is_answered = false

func _ready():
	setup_ui()
	connect_signals()
	load_new_verse()

func setup_ui():
	instruction_label.text = "Complete the missing parts of this verse:"
	next_btn.visible = false
	play_audio_btn.visible = false
	update_score_display()

func connect_signals():
	submit_btn.pressed.connect(_on_submit_pressed)
	next_btn.pressed.connect(_on_next_pressed)
	back_btn.pressed.connect(_on_back_pressed)
	play_audio_btn.pressed.connect(_on_play_audio_pressed)
	GameManager.score_changed.connect(_on_score_changed)

func load_new_verse():
	current_verse = DataManager.get_random_verse()
	if current_verse == null:
		feedback_label.text = "Error: Could not load verse data"
		return
	
	verse_parts = DataManager.get_verse_parts(current_verse)
	if verse_parts.size() < 2:
		# Try another verse if this one doesn't have enough parts
		load_new_verse()
		return
	
	# Randomly select which part to show (give one, ask for others)
	given_part_index = randi() % verse_parts.size()
	missing_parts = []
	for i in range(verse_parts.size()):
		if i != given_part_index:
			missing_parts.append(i)
	
	display_verse()
	reset_ui_for_new_verse()

func display_verse():
	if verse_parts.size() == 0:
		return
	
	# Show the given part
	given_part_label.text = "Given: " + verse_parts[given_part_index]
	
	# Show transliteration if available and language is Sanskrit
	if GameManager.current_language == GameManager.Language.SANSKRIT and current_verse.has("transliteration"):
		transliteration_label.text = "Transliteration: " + current_verse.transliteration
		transliteration_label.visible = true
	else:
		transliteration_label.visible = false
	
	# Setup input for missing parts
	var missing_text = "Complete the missing parts:\n"
	for i in range(missing_parts.size()):
		missing_text += str(i + 1) + ". _______________\n"
	
	input_field.placeholder_text = "Enter the missing parts separated by new lines"

func reset_ui_for_new_verse():
	input_field.text = ""
	input_field.editable = true
	submit_btn.disabled = false
	submit_btn.visible = true
	next_btn.visible = false
	play_audio_btn.visible = false
	feedback_label.text = ""
	is_answered = false

func check_answer():
	var user_input = input_field.text.strip_edges()
	if user_input.is_empty():
		feedback_label.text = "Please enter your answer"
		return
	
	var user_parts = user_input.split("\n")
	var correct_count = 0
	var total_missing = missing_parts.size()
	
	# Check each missing part
	for i in range(min(user_parts.size(), total_missing)):
		var user_part = user_parts[i].strip_edges()
		var correct_part = verse_parts[missing_parts[i]]
		
		# Simple similarity check (can be improved)
		if is_similar_text(user_part, correct_part):
			correct_count += 1
	
	var is_correct = correct_count == total_missing
	GameManager.record_answer(is_correct)
	
	show_feedback(is_correct, correct_count, total_missing)

func is_similar_text(user_text: String, correct_text: String) -> bool:
	# Simple similarity check - remove punctuation and compare
	var user_clean = user_text.to_lower().strip_edges()
	var correct_clean = correct_text.to_lower().strip_edges()
	
	# Remove common Sanskrit punctuation
	user_clean = user_clean.replace("।", "").replace("॥", "")
	correct_clean = correct_clean.replace("।", "").replace("॥", "")
	
	# Check if they're similar (exact match or contains most words)
	if user_clean == correct_clean:
		return true
	
	# Check word similarity (at least 70% words match)
	var user_words = user_clean.split(" ")
	var correct_words = correct_clean.split(" ")
	var matching_words = 0
	
	for word in user_words:
		if word in correct_words:
			matching_words += 1
	
	var similarity = float(matching_words) / float(max(user_words.size(), correct_words.size()))
	return similarity >= 0.7

func show_feedback(is_correct: bool, correct_count: int, total_count: int):
	is_answered = true
	input_field.editable = false
	submit_btn.visible = false
	next_btn.visible = true
	play_audio_btn.visible = true
	
	if is_correct:
		feedback_label.text = "Excellent! You got all parts correct!"
		feedback_label.modulate = Color.GREEN
	else:
		feedback_label.text = "You got " + str(correct_count) + " out of " + str(total_count) + " parts correct.\n\nCorrect answer:\n"
		for i in range(missing_parts.size()):
			feedback_label.text += str(i + 1) + ". " + verse_parts[missing_parts[i]] + "\n"
		feedback_label.modulate = Color.ORANGE

func update_score_display():
	if GameManager.enable_scoring:
		score_label.text = "Score: " + str(GameManager.current_score)
		score_label.visible = true
	else:
		score_label.visible = false

# Signal handlers
func _on_submit_pressed():
	if not is_answered:
		check_answer()

func _on_next_pressed():
	load_new_verse()

func _on_back_pressed():
	GameManager.set_game_mode(GameManager.GameMode.MENU)
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_play_audio_pressed():
	# TODO: Implement audio playback
	print("Playing audio for verse ", current_verse.chapter_number, ".", current_verse.verse_number)
	feedback_label.text += "\n[Audio playback not yet implemented]"

func _on_score_changed(new_score: int):
	update_score_display()



