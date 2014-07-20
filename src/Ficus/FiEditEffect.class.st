"
I represent an abstract edit effect on a shot. FiEdits know how to create effects.
"
Class {
	#name : #FiEditEffect,
	#superclass : #FiFixedObject,
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiEditEffect >> edit [

	^ self subclassResponsibility 
]

{ #category : #accessing }
FiEditEffect >> flattenedLeafEffects [
	
	^ Array streamContents: [ :stream |
		self 
			leafEffectsDo: [ :anEffect :editPath | stream nextPut: editPath -> anEffect ]
			basePath: FiPath root ]

]

{ #category : #accessing }
FiEditEffect >> inverse [

	^ self subclassResponsibility 
]

{ #category : #testing }
FiEditEffect >> isNoEffect [

	^ false
]

{ #category : #enumerating }
FiEditEffect >> leafEffectsDo: aBlockClosure basePath: aPath [ 
	
	^ aBlockClosure 
		value: self 
		value: aPath
]
