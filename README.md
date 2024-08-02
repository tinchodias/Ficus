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

