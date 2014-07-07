"
I represent a path in a shot. See my concrete subclasses.
"
Class {
	#name : #FiPath,
	#superclass : #Object,
	#category : #'Ficus-Paths'
}

{ #category : #debugger }
FiPath class >> canonicalArgumentName [
	^ (self class = FiPath class) 
		ifTrue: [ super canonicalArgumentName ]
		ifFalse: [ 'aPath' ]
]

{ #category : #ston }
FiPath class >> fromSton: stonReader [

	| result |
	result := FiPath root.
	stonReader parseListDo: [ :each :index |
		result := result / each ].

	^ result
]

{ #category : #'instance creation' }
FiPath class >> root [
	^ FiRoot instance
]

{ #category : #accessing }
FiPath >> / anObject [
	
	^ FiRelative 
		on: self 
		step: anObject
]

{ #category : #converting }
FiPath >> asFicusPath [ 

	^ self
]

{ #category : #accessing }
FiPath >> length [

	^ self steps size
]

{ #category : #accessing }
FiPath >> resolvedOn: anObject [

	^ self subclassResponsibility
]

{ #category : #ston }
FiPath >> stonOn: stonWriter [
	
	stonWriter 
		writeObject: self 
		streamShortList: [ :list |
			self steps do: [ :each | list add: each ] ]
]
