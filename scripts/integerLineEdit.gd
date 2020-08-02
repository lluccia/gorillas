tool
extends LineEdit

var previousCaretPosition : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
    placeholder_text = String(0)

func _on_LineEdit_text_changed(new_text):
    text = String(int(new_text))

    if caret_position >= text.length():
        caret_position = text.length()
    else:
        caret_position = previousCaretPosition + 1

    previousCaretPosition = caret_position


