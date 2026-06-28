/// Prints a message to the output window. If multiple of the same message are outputted within
/// a certain timeframe, they are collected together to avoid spamming the output window. PLease
/// see `__SlowWarningConfig` for parameters.
/// 
/// @param string

function SlowWarning(_string)
{
    static _once = (function()
    {
        with({})
        {
            __occurrencesMap = ds_map_create();
            __seenArray      = [];
            
            time_source_start(time_source_create(time_source_global, SLOW_WARNING_DELAY, time_source_units_seconds, function()
            {
                var _occurrencesMap = __occurrencesMap;
                var _seenArray = __seenArray;
                
                var _i = 0;
                repeat(array_length(_seenArray))
                {
                    var _string = _seenArray[_i];
                    show_debug_message($"{_string} (x{_occurrencesMap[? _string]} within {SLOW_WARNING_DELAY} seconds)");
                    ++_i;
                }
                
                ds_map_clear(_occurrencesMap);
                array_resize(_seenArray, 0);
            },
            [], -1));
            
            return self;
        }
    })();
    
    static _occurrencesMap = _once.__occurrencesMap;
    static _seenArray      = _once.__seenArray;
    
    if (SLOW_WARNING_LEVEL >= 2)
    {
        show_debug_message(_string);
    }
    else if (SLOW_WARNING_LEVEL >= 1)
    {
        var _occurrences = _occurrencesMap[? _string];
        if (_occurrences > 0)
        {
            _occurrencesMap[? _string] = _occurrences + 1;
        }
        else
        {
            _occurrencesMap[? _string] = 1;
            array_push(_seenArray, _string);
            
            show_debug_message(_string);
        }
    }
}