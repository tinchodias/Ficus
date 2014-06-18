"
I use Spec for inspecting FiShot instances in a tree-like view.
"
Class {
	#name : #FiInspector,
	#superclass : #Object,
	#category : #'Ficus-UI'
}

{ #category : #inspecting }
FiInspector class >> inspect: rootShot [

	^ TreeModel new
		title: 'Ficus Shot Inspector';
		roots: { #root -> rootShot };
		displayBlock: [ :assoc | assoc key, ': ', (assoc value printStringLimitedTo: 30) ];
		childrenBlock: [ :assoc | 
			assoc value isShot 
				ifTrue: [ assoc value stepsAndValues]
				ifFalse: [ #() ] ];
		openWithSpec
]
