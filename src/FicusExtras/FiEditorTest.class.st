Class {
	#name : #FiEditorTest,
	#superclass : #TestCase,
	#instVars : [
		'aShot'
	],
	#category : #'FicusExtras-Tests-Editor'
}

{ #category : #tests }
FiEditorTest >> testFixedObject [

	| source result |
	source := FiRecipe title: 'Spaghetti' kind: 'Pasta'.
			
	result := 
		source editor
			kind: 'Italian food';
			result.
		
	self assert: source kind equals: 'Pasta'.
	self assert: result kind equals: 'Italian food'.
]
