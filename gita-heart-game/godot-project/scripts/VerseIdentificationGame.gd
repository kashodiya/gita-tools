



extends Control

# Verse Identification Game - Player sees a verse and guesses chapter/verse number

@onready var instruction_label = $VBoxContainer/InstructionLabel
@onready var verse_label = $VBoxContainer/VerseContainer/VerseLabel
@onready var transliteration_label = $VBoxContainer/VerseContainer/TransliterationLabel
@onready var chapter_input = $VBoxContainer/InputContainer/ChapterContainer/ChapterInput
@onready var verse_input = $VBoxContainer/InputContainer/VerseContainer/VerseInput
@onready var submit_btn = $VBoxContainer/ButtonsContainer/SubmitBtn
@onready var next_btn = $VBoxContainer/ButtonsContainer/NextBtn
@onready var back_btn = $VBoxContainer/ButtonsContainer/BackBtn
@onready var feedback_label = $VBoxContainer/FeedbackLabel
@onready var score_label = $VBoxContainer/ScoreLabel
@onready var play_audio_btn = $VBoxContainer/ButtonsContainer/PlayAudioBtn

var current_verse = null
var is_answered = false

func _ready():
	setup_ui()
	connect_signals()
	load_new_verse()

func setup_ui():
	instruction_label.text = "Identify the chapter and verse number:"
	next_btn.visible = false
	play_audio_btn.visible = false
	update_score_display()
	
	# Set input constraints
	chapter_input.placeholder_text = "Chapter (1-18)"
	verse_input.placeholder_text = "Verse number"

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
	
	display_verse()
	reset_ui_for_new_verse()

func display_verse():
	if current_verse == null:
		return
	
	# Display verse based on selected language
	var verse_text = ""
	
	if GameManager.current_language == GameManager.Language.SANSKRIT:
		verse_text = current_verse.text
		# Show transliteration if available
		if current_verse.has("transliteration"):
			transliteration_label.text = current_verse.transliteration
			transliteration_label.visible = true
		else:
			transliteration_label.visible = false
	else:
		# Get translation in selected language
		var translations = DataManager.get_translations_for_verse(
			current_verse.id, 
			GameManager.get_current_language_code()
		)
		
		if translations.size() > 0:
			verse_text = translations[0].description
		else:
			# Fallback to Sanskrit if translation not available
			verse_text = current_verse.text
			feedback_label.text = "Translation not available, showing Sanskrit"
		
		transliteration_label.visible = false
	
	verse_label.text = verse_text

func reset_ui_for_new_verse():
	chapter_input.text = ""
	verse_input.text = ""
	chapter_input.editable = true
	verse_input.editable = true
	submit_btn.disabled = false
	submit_btn.visible = true
	next_btn.visible = false
	play_audio_btn.visible = false
	feedback_label.text = ""
	is_answered = false

func check_answer():
	var chapter_text = chapter_input.text.strip_edges()
	var verse_text = verse_input.text.strip_edges()
	
	if chapter_text.is_empty() or verse_text.is_empty():
		feedback_label.text = "Please enter both chapter and verse numbers"
		return
	
	var user_chapter = chapter_text.to_int()
	var user_verse = verse_text.to_int()
	
	var correct_chapter = current_verse.chapter_number
	var correct_verse = current_verse.verse_number
	
	var chapter_correct = user_chapter == correct_chapter
	var verse_correct = user_verse == correct_verse
	var fully_correct = chapter_correct and verse_correct
	
	GameManager.record_answer(fully_correct)
	show_feedback(chapter_correct, verse_correct, correct_chapter, correct_verse)

func show_feedback(chapter_correct: bool, verse_correct: bool, correct_chapter: int, correct_verse: int):
	is_answered = true
	chapter_input.editable = false
	verse_input.editable = false
	submit_btn.visible = false
	next_btn.visible = true
	play_audio_btn.visible = true
	
	var feedback_text = ""
	
	if chapter_correct and verse_correct:
		feedback_text = "Perfect! You identified the verse correctly!"
		feedback_label.modulate = Color.GREEN
	elif chapter_correct:
		feedback_text = "Good! Chapter is correct, but verse number is wrong.\n"
		feedback_text += "Correct answer: Chapter " + str(correct_chapter) + ", Verse " + str(correct_verse)
		feedback_label.modulate = Color.ORANGE
	elif verse_correct:
		feedback_text = "Good! Verse number is correct, but chapter is wrong.\n"
		feedback_text += "Correct answer: Chapter " + str(correct_chapter) + ", Verse " + str(correct_verse)
		feedback_label.modulate = Color.ORANGE
	else:
		feedback_text = "Not quite right.\n"
		feedback_text += "Correct answer: Chapter " + str(correct_chapter) + ", Verse " + str(correct_verse)
		feedback_label.modulate = Color.RED
	
	# Add chapter information
	var chapter_info = DataManager.get_chapter_by_number(correct_chapter)
	if chapter_info:
		feedback_text += "\n\nChapter: " + chapter_info.name_meaning
	
	feedback_label.text = feedback_text

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




