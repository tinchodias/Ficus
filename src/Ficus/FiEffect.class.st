"
I represent an abstract edit effect on a shot. FiEdits know how to create effects.

See class comment of FiShot.
"
Class {
	#name : #FiEffect,
	#superclass : #FiFixedObject,
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #convenience }
FiEffect class >> fromAll: subEffects [

	^ subEffects
		ifEmpty: [ FiNoEffect new ]
		ifNotEmpty: [ subEffects size = 1
			ifTrue: [ subEffects anyOne ]
			ifFalse: [ 
				FiCompositeEffect builder
					children: subEffects asFiSet;
					new ] ]
]

{ #category : #converting }
FiEffect >> asSimpleEffects [

	^ self asSimpleEffectsAt: FiPath root
]

{ #category : #accessing }
FiEffect >> edit [

	^ self subclassResponsibility 
]

{ #category : #accessing }
FiEffect >> inverse [

	^ self subclassResponsibility 
]

{ #category : #testing }
FiEffect >> isNoEffect [

	^ false
]
