function array_shuffled(arr)
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

function array_shuffle(arr)
{
	array_sort(arr, function() {
		return irandom_range(-1, 1);
	});
}

function array_reverse(arr)
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

function array_safe(_array, _value)
{
	var i = 0; repeat(array_length(_array))
	{
		if (_array[i] == _value)
		{
			return false;
			break;
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
			break;
		}
		i++;
	}
	return true;
}