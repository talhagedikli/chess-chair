function Typewriter(_text, _spd = 0.25) constructor
{
	text	= _text;
	char	= 1;
	charSpd = _spd;
	len		= string_length(text);
	static write = function(_text = text)
	{
		if (text != _text)
		{
			text = _text;
			len		= string_length(text);
		}
		if (char < len)
		{
			char += charSpd;
		}
		return string_copy(text, 1, char);
	}
	static reset = function(_text = text)
	{
		text = _text;
		char = 1;
	}
}
