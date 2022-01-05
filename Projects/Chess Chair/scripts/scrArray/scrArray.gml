function Array() constructor
{
	arr = [];
	var i = 0; repeat(argument_count)
	{
		array_push(arr, argument[i]);
		i++;
	}
	static Add = function()
	{
		var i = 0; repeat(argument_count)
		{
			array_push(arr, argument[i]);
			i++
		}
		return self;
	}
	static Copy = function()
	{
		return self;
	}
	static Count = function(_el)
	{
		var num = 0;
		foreach(arr, function(val, ind)
		{
			if (val == _el)
			{
				num++;
			}
		})
		return num;
	}
	static Index = function(_ind)
	{
		return self.arr[_ind];
	}
	static Insert = function(ind)
	{
		var i = 1; repeat(argument_count - 1)
		{
			array_insert(self.arr, ind, argument[i])
		}
	}
	
	static Get = function()
	{
		return self.arr;
	}
	
	static to_string = function()
	{
		return string(arr[0]);
	}
}






