
extends Node

# Singleton for managing Gita data
# This will be autoloaded to be accessible from anywhere

signal data_loaded

var verses_data = []
var chapters_data = []
var translations_data = []
var authors_data = []
var languages_data = []

var is_data_loaded = false

func _ready():
	load_all_data()

func load_all_data():
	print("Loading Gita data...")
	
	# Load verses
	var verses_file = FileAccess.open("res://data/verse.json", FileAccess.READ)
	if verses_file:
		var verses_json = verses_file.get_as_text()
		verses_file.close()
		var json = JSON.new()
		var parse_result = json.parse(verses_json)
		if parse_result == OK:
			verses_data = json.data
			print("Loaded ", verses_data.size(), " verses")
		else:
			print("Error parsing verses.json: ", json.get_error_message())
	
	# Load chapters
	var chapters_file = FileAccess.open("res://data/chapters.json", FileAccess.READ)
	if chapters_file:
		var chapters_json = chapters_file.get_as_text()
		chapters_file.close()
		var json = JSON.new()
		var parse_result = json.parse(chapters_json)
		if parse_result == OK:
			chapters_data = json.data
			print("Loaded ", chapters_data.size(), " chapters")
		else:
			print("Error parsing chapters.json: ", json.get_error_message())
	
	# Load translations
	var translations_file = FileAccess.open("res://data/translation.json", FileAccess.READ)
	if translations_file:
		var translations_json = translations_file.get_as_text()
		translations_file.close()
		var json = JSON.new()
		var parse_result = json.parse(translations_json)
		if parse_result == OK:
			translations_data = json.data
			print("Loaded ", translations_data.size(), " translations")
		else:
			print("Error parsing translation.json: ", json.get_error_message())
	
	# Load authors
	var authors_file = FileAccess.open("res://data/authors.json", FileAccess.READ)
	if authors_file:
		var authors_json = authors_file.get_as_text()
		authors_file.close()
		var json = JSON.new()
		var parse_result = json.parse(authors_json)
		if parse_result == OK:
			authors_data = json.data
			print("Loaded ", authors_data.size(), " authors")
		else:
			print("Error parsing authors.json: ", json.get_error_message())
	
	# Load languages
	var languages_file = FileAccess.open("res://data/languages.json", FileAccess.READ)
	if languages_file:
		var languages_json = languages_file.get_as_text()
		languages_file.close()
		var json = JSON.new()
		var parse_result = json.parse(languages_json)
		if parse_result == OK:
			languages_data = json.data
			print("Loaded ", languages_data.size(), " languages")
		else:
			print("Error parsing languages.json: ", json.get_error_message())
	
	is_data_loaded = true
	data_loaded.emit()
	print("All Gita data loaded successfully!")

# Helper functions to get data
func get_random_verse():
	if verses_data.size() > 0:
		return verses_data[randi() % verses_data.size()]
	return null

func get_verse_by_id(verse_id: int):
	for verse in verses_data:
		if verse.id == verse_id:
			return verse
	return null

func get_verse_by_chapter_and_number(chapter: int, verse_number: int):
	for verse in verses_data:
		if verse.chapter_number == chapter and verse.verse_number == verse_number:
			return verse
	return null

func get_chapter_by_number(chapter_number: int):
	for chapter in chapters_data:
		if chapter.chapter_number == chapter_number:
			return chapter
	return null

func get_translations_for_verse(verse_id: int, language: String = "english"):
	var result = []
	for translation in translations_data:
		if translation.verse_id == verse_id and translation.lang == language:
			result.append(translation)
	return result

func get_all_chapter_names():
	var names = []
	for chapter in chapters_data:
		names.append({
			"number": chapter.chapter_number,
			"name": chapter.name_meaning,
			"sanskrit": chapter.name
		})
	return names

# Split verse text into parts (padas)
func split_verse_into_parts(verse_text: String):
	# Remove extra whitespace and split by line breaks
	var cleaned_text = verse_text.strip_edges()
	var lines = cleaned_text.split("\n")
	var parts = []
	
	for line in lines:
		var trimmed = line.strip_edges()
		if trimmed.length() > 0 and not trimmed.begins_with("।।"):
			parts.append(trimmed)
	
	return parts

func get_verse_parts(verse):
	if verse and verse.has("text"):
		return split_verse_into_parts(verse.text)
	return []

