"
I represent a path in a shot. See my concrete subclasses.
"
Class {
	#name : #FiPath,
	#superclass : #Object,
	#category : #'Ficus-Model-Paths'
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

{ #category : #ston }
FiPath class >> fromStream: aStream [

	| result |
	result := FiPath root.

	[ aStream atEnd ] whileFalse: [
		result := result / aStream next ].

	^ result
]

{ #category : #'instance creation' }
FiPath class >> root [
	^ FiRootPath instance
]

{ #category : #ston }
FiPath class >> stonName [
	"Encode my instances using a different class name."

	^ FiPath name
]

{ #category : #accessing }
FiPath >> / anObject [
	
	^ FiRelativePath 
		on: self 
		step: anObject
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
