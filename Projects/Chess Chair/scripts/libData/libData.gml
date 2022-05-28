///@param {array} arr
function array_shuffle1(arr)
{
	var len = array_length(arr);
	for (var i = 0; i < len; i++)
	{
		var r = irandom(len-1);
		
		var arr1 = arr[i];
		var arr2 = arr[r];
		
		arr[i] = arr2;
		arr[r] = arr1;
	}
	return arr;
}


///@param {array} arr
function array_shuffle(arr)
{
	array_sort(arr, function() {
		return irandom_range(-1, 1);
	});
}

///@param {array} arr
function array_reverse1(arr)
{
	var l = array_length(arr);
	var a = array_create(l);
	var i = 0; repeat(l)
	{
		a[i] = arr[(l-1) - i];
		i++;
	}
	return a;
}
///@param {array} _array
function array_reverse(_array)
{
	return na.slice(_array, 0, na.size(_array), -1);
}

///@param {array}	_array
///@param {*}		_value
function array_safe(_array, _value)
{
	var i = 0; repeat(array_length(_array))
	{
		if (_array[i] == _value)
		{
			return false;
		}
		i++;
	}
	return true;
}

function ds_list_safe(_list, _value)
{
	var i = 0; repeat(ds_list_size(_list))
	{
		if (_list[| i] == _value)
		{
			return false;
		}
		i++;
	}
	return true;
}