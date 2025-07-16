# Ficus

Ficus provides a framework for defining tree-like immutable objects in Pharo. 

It support first-class edits, which represent operations that can be applied to Ficus objects. 

It also supports first-class changes, which represent the change after applying an edit to a Ficus object.


## History

This is a subset of the original project (from 2015) is in [master](https://github.com/tinchodias/Ficus/tree/master) branch.


## Install

The following script installs Ficus in [Pharo](https://pharo.org/download):

```smalltalk
Metacello new
	baseline: 'Ficus';
	repository: 'github://tinchodias/Ficus:mini/src';
	load
```

Browse all tests as examples.

## License

This code is licensed under the [MIT license](./LICENSE).
