"
I represent a  class trait.
"
Class {
	#name : #RFiClassTrait,
	#superclass : #RFiAbstractTrait,
	#instVars : [
		'instanceSide'
	],
	#category : #'FicusRing-Core'
}

{ #category : #accessing }
RFiClassTrait >> asMetamodelSpot [
	
	^ FiBehaviorSpot 
		name: self theNonMetaClass name
		isMetaSide: true
		packageName: self package name
]

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

{ #category : #testing }
RFiClassTrait >> isMeta [
	
	^ true
]

{ #category : #polymorphism }
RFiClassTrait >> theMetaClass [
	
	^ self
]

{ #category : #polymorphism }
RFiClassTrait >> theNonMetaClass [
	
	^ instanceSide
]
