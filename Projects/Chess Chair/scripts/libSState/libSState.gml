/// @script libSState
#macro STATE_MACHINES		global.__stateMachines
#macro MAX_STATE_HISTORY	10

global.__stateMachines		= {};

/// @description
/// @param {bool} [_autorun]
/// @returns {nil} 
function StateMachine(_autorun=false) constructor
{
	owner					= other.id;
	autorun					= _autorun;
	states					= {};
	activeState				= undefined;
	name					= "fsm-" + string(other.id);
	history					= [];
	STATE_MACHINES[$ name]	= self;
	


	/// @param {struct.State} _state
	static Add = function(_state)
	{
		variable_struct_set(states, _state.name, _state);
	}
	
	///@param {string}		_name
	static Init = function(_name)
	{
		activeState = variable_struct_get(states, _name);
		activeState.enter();
		array_push(history ,_name);
	}
	
	static Step = function()
	{
		activeState.step();
	}
	static StepEnd = function()
	{
		activeState.step_end();
	}
	static StepBegin = function()
	{
		activeState.step_begin();
	}
	static Draw = function()
	{
		activeState.draw();
	}
	
	///@param {string} _name
	static Change = function(_name)
	{
		activeState.leave();
		activeState = variable_struct_get(states, _name);
		array_push(history, _name);
		activeState.enter();		
	}
	
	///@param {string} _name
	static StateIs = function(_name)
	{
		return activeState.name == _name ? true : false;
	}
	
	static GetCurrentState = function()
	{
		return activeState.name;	
	}
	
	static toString = function()
	{
		return ("{ " + self.name + " }");	
	}
}

///@param {string} _name State name
function State(_name) constructor 
{
	owner		= other.id;
	name		= _name;
	enter		= method(owner, function() {});
	step_begin	= method(owner, function() {});
	step		= method(owner, function() {});
	step_end	= method(owner, function() {});
	leave		= method(owner, function() {});
	draw		= function() { draw_self(); };
	draw_gui	= method(owner, function() {});
}
