// How long to wait before flushing the cache, measured in seconds. When the cache is flushed,
// any identical warnings that have been collected together will be outputted.
#macro SLOW_WARNING_DELAY  2

// How often to output warning messages. Must be one of the following values:
// `0` = Output no warning messages at all
// `1` = Collect together warning messages and output every so often
// `2` = Output warning messages immediately as they occur for every warning
#macro SLOW_WARNING_LEVEL  1