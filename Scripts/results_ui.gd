extends Control

@onready var silver_textfield: LineEdit = $VBoxContainer/SilverHBoxContainer/SilverTextfield
@onready var gold_textfield: LineEdit = $VBoxContainer/GoldHBoxContainer/GoldTextfield

func set_results(silver, gold):
	silver_textfield.text = str(silver)
	gold_textfield.text = str(gold)

func _on_silver_copy_to_clipboard_button_pressed() -> void:
	DisplayServer.clipboard_set(str(silver_textfield))

func _on_gold_copy_to_clipboard_button_pressed() -> void:
	DisplayServer.clipboard_set(str(gold_textfield))
