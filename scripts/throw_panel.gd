extends Node2D

signal throw

#var _previous_angle = '0'
#var _previous_speed = '0' 

func throw():
    var angle = int($angle_input.text)
    var speed = int($speed_input.text)
    
    #_previous_angle = $angle_input.text
    #_previous_speed = $speed_input.text
    
    emit_signal("throw", angle, speed)

func _on_throw_panel_visibility_changed():
    if visible:
        $angle_input.placeholder_text = $angle_input.text
        $angle_input.text = ''        

        $speed_input.placeholder_text = $speed_input.text
        $speed_input.text = ''

        $angle_input.grab_focus()

func _on_angle_input_text_entered(_new_text):
    $speed_input.grab_focus()

func _on_speed_input_text_entered(_new_text):
    throw()
