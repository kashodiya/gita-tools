




extends Control

# Chapter Sequence Game - Player arranges chapter names in correct order

@onready var instruction_label = $VBoxContainer/InstructionLabel
@onready var chapters_container = $VBoxContainer/ChaptersContainer
@onready var submit_btn = $VBoxContainer/ButtonsContainer/SubmitBtn
@onready var next_btn = $VBoxContainer/ButtonsContainer/NextBtn
@onready var back_btn = $VBoxContainer/ButtonsContainer/BackBtn
@onready var feedback_label = $VBoxContainer/FeedbackLabel
@onready var score_label = $VBoxContainer/ScoreLabel

var chapter_buttons = []
var correct_order = []
var current_order = []
var is_answered = false
var selected_button = null

func _ready():
	setup_ui()
	connect_signals()
	load_new_game()

func setup_ui():
	instruction_label.text = "Arrange the chapter names in the correct order (1-18):"
	next_btn.visible = false
	update_score_display()

func connect_signals():
	submit_btn.pressed.connect(_on_submit_pressed)
	next_btn.pressed.connect(_on_next_pressed)
	back_btn.pressed.connect(_on_back_pressed)
	GameManager.score_changed.connect(_on_score_changed)

func load_new_game():
	clear_previous_game()
	
	# Get random subset of chapters (5-8 chapters for manageable gameplay)
	var all_chapters = DataManager.get_all_chapter_names()
	var num_chapters = randi_range(5, 8)
	
	# Select random chapters
	var selected_chapters = []
	var available_chapters = all_chapters.duplicate()
	
	for i in range(num_chapters):
		var random_index = randi() % available_chapters.size()
		selected_chapters.append(available_chapters[random_index])
		available_chapters.remove_at(random_index)
	
	# Sort by chapter number to get correct order
	selected_chapters.sort_custom(func(a, b): return a.number < b.number)
	correct_order = selected_chapters.duplicate()
	
	# Shuffle for display
	selected_chapters.shuffle()
	current_order = selected_chapters.duplicate()
	
	create_chapter_buttons()
	reset_ui_for_new_game()

func clear_previous_game():
	# Remove existing buttons
	for button in chapter_buttons:
		if button and is_instance_valid(button):
			button.queue_free()
	chapter_buttons.clear()

func create_chapter_buttons():
	# Create a grid container for better layout
	var grid = GridContainer.new()
	grid.columns = 2
	chapters_container.add_child(grid)
	
	for i in range(current_order.size()):
		var chapter = current_order[i]
		var button = Button.new()
		button.text = str(chapter.number) + ". " + chapter.name
		button.custom_minimum_size = Vector2(300, 50)
		button.pressed.connect(_on_chapter_button_pressed.bind(i))
		
		grid.add_child(button)
		chapter_buttons.append(button)

func reset_ui_for_new_game():
	submit_btn.disabled = false
	submit_btn.visible = true
	next_btn.visible = false
	feedback_label.text = ""
	is_answered = false
	selected_button = null
	update_button_styles()

func _on_chapter_button_pressed(index: int):
	if is_answered:
		return
	
	if selected_button == null:
		# First selection
		selected_button = index
		update_button_styles()
	elif selected_button == index:
		# Deselect
		selected_button = null
		update_button_styles()
	else:
		# Swap chapters
		swap_chapters(selected_button, index)
		selected_button = null
		update_button_styles()

func swap_chapters(index1: int, index2: int):
	# Swap in current_order array
	var temp = current_order[index1]
	current_order[index1] = current_order[index2]
	current_order[index2] = temp
	
	# Update button texts
	update_button_texts()

func update_button_texts():
	for i in range(chapter_buttons.size()):
		if chapter_buttons[i] and is_instance_valid(chapter_buttons[i]):
			var chapter = current_order[i]
			chapter_buttons[i].text = str(chapter.number) + ". " + chapter.name

func update_button_styles():
	for i in range(chapter_buttons.size()):
		if chapter_buttons[i] and is_instance_valid(chapter_buttons[i]):
			if i == selected_button:
				chapter_buttons[i].modulate = Color.YELLOW
			else:
				chapter_buttons[i].modulate = Color.WHITE

func check_answer():
	var correct_count = 0
	var total_chapters = current_order.size()
	
	for i in range(total_chapters):
		if current_order[i].number == correct_order[i].number:
			correct_count += 1
	
	var is_perfect = correct_count == total_chapters
	GameManager.record_answer(is_perfect)
	
	show_feedback(is_perfect, correct_count, total_chapters)

func show_feedback(is_perfect: bool, correct_count: int, total_count: int):
	is_answered = true
	submit_btn.visible = false
	next_btn.visible = true
	
	# Disable all buttons
	for button in chapter_buttons:
		if button and is_instance_valid(button):
			button.disabled = true
	
	var feedback_text = ""
	
	if is_perfect:
		feedback_text = "Excellent! You arranged all chapters in perfect order!"
		feedback_label.modulate = Color.GREEN
	else:
		feedback_text = "You got " + str(correct_count) + " out of " + str(total_count) + " chapters in correct position.\n\n"
		feedback_text += "Correct order:\n"
		for i in range(correct_order.size()):
			var chapter = correct_order[i]
			feedback_text += str(i + 1) + ". Chapter " + str(chapter.number) + ": " + chapter.name + "\n"
		feedback_label.modulate = Color.ORANGE
	
	feedback_label.text = feedback_text
	
	# Highlight correct/incorrect positions
	highlight_button_correctness()

func highlight_button_correctness():
	for i in range(chapter_buttons.size()):
		if chapter_buttons[i] and is_instance_valid(chapter_buttons[i]):
			if current_order[i].number == correct_order[i].number:
				chapter_buttons[i].modulate = Color.GREEN
			else:
				chapter_buttons[i].modulate = Color.RED

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
	load_new_game()

func _on_back_pressed():
	GameManager.set_game_mode(GameManager.GameMode.MENU)
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_score_changed(new_score: int):
	update_score_display()





