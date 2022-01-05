/// @description
fileName = "save";
Save = function(_rs)
{
	var _highscore = max(global.score, global.highScore);
	
	// Root Struct
	var _rootstruct = 
	{
		highScore : _highscore
	};
	//_rootstruct = _rs;
	
	// Save to json
	var _json = json_stringify(_rootstruct);
	//var _json = snap_to_json(_rootstruct, true);
	
	save_string(_json, fileName);
}

Load = function(_file)
{
	if (!file_exists(_file)) return;
	
	// Load JSON
	var _json = load_string(_file);
	var _rootstruct = json_parse(_json);
	//var _rootstruct = snap_from_json(_json);
	
	global.highScore = _rootstruct.highScore;
}
	