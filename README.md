# Ficus

⚠️ Outdated code, recovered from smalltalkhub ⚠️

This repository contains a family of experiments:

Ficus provides a framework for defining tree-like immutable objects. It support first-class edits, which represent operations that can be applied to Ficus objects. It also supports first-class changes, which represent the change after applying an edit to a Ficus object.

FicusMetamodel defines a Ficus model (i.e. tree-like immutable objects) to represent Pharo metalevel objects.

RingFicus defines wrappers for FicusMetamodel which are polymorphic to real Pharo metalevel objects. In a nutshell, it's like the original Ring but with more isolation and more lightweight.

Also check Yrupe project, a serializer for Ficus objects.

## Loading in Pharo 5 or 6

```
Metacello new
    smalltalkhubUser: 'MartinDias' project: 'Ficus';
    configuration: #Ficus; 
    version: #development;
    load.
```

## Example of RingFicus

```
environment := RFiFragileBaseClassProblemResources5A new ringEnvironment.
environment allClasses.
environment browse.
```


## History

This repsitory was migrated from SmalltalkHub with an semi-automatic tool.
* Source repository: http://smalltalkhub.com/MartinDias/Ficus/
* Migration tool: https://github.com/pharo-contributions/git-migration

Script:
```smalltalk
migration := GitMigration on: 'MartinDias/Ficus'.
migration onEmptyMessage: [ :info | 'empty commit message' ].
migration downloadAllVersions.
migration populateCaches.
migration allAuthors. "#('Anonymous' 'CamilleTeruel' 'ChristopheDemarey' 'GuillermoPolito' 'MartinDIas' 'MartinDias' 'PabloTesone' 'SkipLentz' 'YuriyTymchuk' 'md')"
migration authors: {
	'MartinDias' -> #('Martín Dias' '<tinchodias@gmail.com>').
	'MartinDIas' -> #('Martín Dias' '<tinchodias@gmail.com>').
	'md' -> #('Martín Dias' '<tinchodias@gmail.com>').
	'Anonymous' -> #('Martín Dias' '<tinchodias@gmail.com>').
	'CamilleTeruel' -> #('Camille Teruel' '<camille.teruel@gmail.com>').
	'SkipLentz' -> #('Balletie' '<skip_meesie@hotmail.com>').
	'GuillermoPolito' -> #('Guille Polito' '<guillermopolito@gmail.com>').
	'PabloTesone' -> #('Pablo Tesone' '<tesonep@gmail.com>').
	'ChristopheDemarey' -> #('Christophe Demarey' '<christophe.demarey@inria.fr>').
	'YuriyTymchuk' -> #('Yuriy Tymchuk' '<uko@unikernel.net>')
 }.
migration
	fastImportCodeToDirectory: 'src'
	initialCommit: '93e8f1e1983ab81d8fe3440daca9b64bfee340b5'
	to: 'ficusImport.txt'
```
