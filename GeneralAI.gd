extends Node

# made by Johnnyfantastic. https://github.com/Johnnyfantastic6-lab/Godot-GeneralAI

class_name GeneralAI

export var input_amount: int = 3
export var output_amount: int = 2
export var extra_neuron_amount: int = 3
export var connection_amount: int = 5

class Connection:
	var weight: float = 1.0
	
	var in_index: int
	var out_index: int
	
	var enabled: bool

class Neuron:
	var bias: float = 0.0
	var value: float = 0.0
	var new_value: float = 0.0

var neuron_storage_array: Array = []
var connection_storage_array: Array = []

var input_indices: Array = []
var output_indices: Array = []

func _ready() -> void:
	create_default()
	#$Visualizer.receive_brain(neuron_storage_array, connection_storage_array)

func create_default() -> void:
	for i in (input_amount + output_amount + extra_neuron_amount):
		add_neuron()
	for i in connection_amount:
		add_connection()
	generate_input_indices()
	generate_output_indices()

func generate_input_indices() -> void:
	var allowed: Array = []
	for i in input_amount:
		allowed.append(i-1)
	for i in input_amount:
		var rand = randi() % allowed.size()
		input_indices.append(allowed[rand])
		allowed.remove(rand)

func generate_output_indices() -> void:
	var allowed: Array = []
	for i in output_amount:
		allowed.append(i-1)
	for i in output_amount:
		var rand = randi() % allowed.size()
		output_indices.append(allowed[rand])
		allowed.remove(rand)

func add_neuron() -> void:
	var new_neuron = Neuron.new()
	neuron_storage_array.append(new_neuron)

# call this after add_neuron() or else it wont work.
func add_connection() -> void:
	var new_connection = Connection.new()
	new_connection.in_index = randi() % neuron_storage_array.size()
	new_connection.out_index = randi() % neuron_storage_array.size()
	new_connection.weight = rand_range(-2,2)
	connection_storage_array.append(new_connection)

func toggle_connection(index) -> void:
	connection_storage_array[index].enabled = !connection_storage_array[index].enabled

# god i hate godot array syntax
func activate_connection(index) -> void:
	if connection_storage_array[index].enabled:
	# all one line
		(neuron_storage_array[connection_storage_array[index].out_index].new_value +=
			neuron_storage_array[connection_storage_array[index].in_index].value *
			connection_storage_array[index].weight)

func change_neuron_bias(index: int, value: float) -> void:
	neuron_storage_array[index].bias = value

func change_neuron_value(index: int, value: float) -> void:
	neuron_storage_array[index].value = value

func get_output(input: Array) -> Array:
	if input_indices.size() != input.size():
		push_error("input_indices.size() != input.size()!")
	
	for i in input_indices.size():
		change_neuron_value(input_indices[i - 1], input[i - 1])
	
	for i in connection_storage_array.size():
		activate_connection(i - 1)
	
	for neuron in neuron_storage_array:
		neuron.new_value = tanh(neuron.new_value) + neuron.bias
		neuron.value = neuron.new_value
	
	var output_values: Array = []
	
	for index in output_indices:
		output_values.append(neuron_storage_array[index].value)
	
	return output_values

func mutate_brain() -> void:
	for connection in connection_storage_array:
		connection.weight += rand_range(-0.1,0.1)
		if rand_range(0,1) < 0.1:
			connection.enabled = !connection.enabled
		if rand_range(0,1) < 0.05:
			connection.in_index = randi() % input_amount
		if rand_range(0,1) < 0.05:
			connection.out_index = randi() % input_amount
	for neuron in neuron_storage_array:
		neuron.bias += rand_range(-0.1,0.1)
	if rand_range(0,1) < 0.01:
		add_neuron()
	if rand_range(0,1) < 0.05:
		add_connection()

