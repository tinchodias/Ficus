# Ficus

Ficus provides a framework for defining tree-like immutable objects in Pharo. 

It support first-class edits, which represent operations that can be applied to Ficus objects. 

It also supports first-class changes, which represent the change after applying an edit to a Ficus object.


## History

This is a subset of the original project (from 2015) is in master branch.


## Install

The following script installs Ficus in [Pharo](https://pharo.org/download):

```smalltalk
Metacello new
	baseline: 'Ficus2';
	repository: 'github://tinchodias/Ficus:mini/src';
	load
```

## License

This code is licensed under the [MIT license](./LICENSE).
