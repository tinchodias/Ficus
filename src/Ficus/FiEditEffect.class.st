"
I represent an abstract edit effect on a shot. FiEdits know how to create effects.

See class comment of FiShot.
"
Class {
	#name : #FiEditEffect,
	#superclass : #FiFixedObject,
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #convenience }
FiEditEffect class >> fromAll: subEffects [

	self flag: #todo. "Avoid this IFs using double dispatch like #composedWith: ?"

	^ subEffects
		ifEmpty: [ FiNoEffect new ]
		ifNotEmpty: [ subEffects size = 1
			ifTrue: [ subEffects anyOne ]
			ifFalse: [ 
				FiCompositeEffect builder
					subEffects: subEffects asFiSet;
					new ] ]
]

{ #category : #converting }
FiEditEffect >> asSimpleEffects [

	^ self asSimpleEffectAt: FiPath root
]

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
