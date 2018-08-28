Class {
	#name : #FiSpot,
	#superclass : #Object,
	#category : #'Ficus2-Updates-Paths'
}

{ #category : #accessing }
FiSpot >> / anObject [
	
	^ FiRelativePath 
		on: self 
		step: anObject
]

{ #category : #converting }
FiSpot >> asPathOn: anObject [

	^ self subclassResponsibility
]

{ #category : #printing }
FiSpot >> asShortPrintStrings [

	^ self subclassResponsibility
]

{ #category : #resolving }
FiSpot >> resolvedOn: anObject [

	^ (self asPathOn: anObject) resolvedOn: anObject
]
