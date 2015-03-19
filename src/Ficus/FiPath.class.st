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

{ #category : #'instance creation' }
FiPath class >> fromSequenceableCollection: aCollection [

	^ aCollection 
		inject: FiPath root 
		into: [ :path :step | path / step ]
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

{ #category : #testing }
FiPath >> beginsWith: aPath [
	
	^ self steps beginsWith: aPath steps
]

{ #category : #testing }
FiPath >> canBeResolvedOn: anObject [
	
	^ self 
		resolvedOn: anObject 
		ifPresent: [ true ]
		ifAbsent: [ false ]
]

{ #category : #accessing }
FiPath >> length [

	^ self steps size
]

{ #category : #resolving }
FiPath >> resolvedOn: anObject [

	^ self subclassResponsibility
]

{ #category : #resolving }
FiPath >> resolvedOn: anObject ifAbsent: absentBlockClosure [ 

	^ self subclassResponsibility
]

{ #category : #resolving }
FiPath >> resolvedOn: anObject ifPresent: presentBlockClosure ifAbsent: absentBlockClosure [

	^ self subclassResponsibility
]

{ #category : #resolving }
FiPath >> resolvedOn: anObject targetCollect: targetBlockClosure stepCollect: stepBlockClosure [

	^ self subclassResponsibility
]

{ #category : #accessing }
FiPath >> steps [
	"Answer the collection of steps of this path."

	^ self subclassResponsibility
]

{ #category : #ston }
FiPath >> stonOn: stonWriter [
	
	stonWriter 
		writeObject: self 
		streamShortList: [ :list |
			self steps do: [ :each | list add: each ] ]
]
