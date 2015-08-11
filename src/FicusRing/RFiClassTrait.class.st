Class {
	#name : #RFiClassTrait,
	#superclass : #RFiAbstractTrait,
	#instVars : [
		'instanceSide'
	],
	#category : #'FicusRing-Core'
}

{ #category : #polymorphism }
RFiClassTrait >> definition [
	^String streamContents: [:stream |
		stream
			nextPutAll: instanceSide name;
			nextPutAll: ' clasTrait';
			crtab;
			nextPutAll: 'uses: ';
			nextPutAll: self traitCompositionString]
]

{ #category : #'initialize - release' }
RFiClassTrait >> environment [

	^ instanceSide environment
]

{ #category : #polymorphism }
RFiClassTrait >> ficusTrait [
	
	^ instanceSide ficusTrait classTrait
]

{ #category : #'initialize - release' }
RFiClassTrait >> instanceSide: aRFiTrait [

	instanceSide := aRFiTrait
]
