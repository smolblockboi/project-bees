class_name ProductionTimer extends Timer


signal started
signal timer_ticked

var last_tick : int


func _ready() -> void:
	started.connect(get_parent()._on_production_started)
	timeout.connect(get_parent()._on_production_finished)
	
	timer_ticked.connect(get_parent()._on_production_ticked)


func _physics_process(delta: float) -> void:
	if !is_stopped():
		if time_left != wait_time:
			if (int(time_left) != last_tick):
				last_tick = int(time_left)
				timer_ticked.emit()


func is_production_active():
	return get_time_left() > 0.0


func start_production():
	start()
	started.emit()
