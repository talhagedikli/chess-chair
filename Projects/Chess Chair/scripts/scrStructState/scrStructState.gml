#macro STATE_MACHINES		global.__stateMachines
#macro MAX_STATE_HISTORY	10

global.__stateMachines		= {};

function StateMachine() constructor
{
	states					= {};
	activeState				= undefined;
	name					= "fsm" + string(other.id);
	history					= [];
	STATE_MACHINES[$ name]	= self;
	///@param {struct.State} _state
	static Add = function(_state)
	{
		states[$ _state.name] = _state;
	}
	
	static Init = function(_name)
	{
		activeState = states[$ _name];
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
	
	static Change = function(_name)
	{
		activeState.leave();
		activeState = states[$ _name];
		array_push(history, _name);
		activeState.enter();		
	}
	
	static StateIs = function(_name)
	{
		return activeState.name == _name ? true : false;
	}
	
	static GetCurrentState = function()
	{
		return activeState.name;	
	}
}

function State(_name = "") constructor 
{
	owner		= other.id;
	name		= _name;
	enter		= function() {};
	step_begin	= function() {};
	step		= function() {};
	step_end	= function() {};
	leave		= function() {};
	draw		= function() { draw_self(); };
	draw_gui	= function() { };
	return self;
}
