"
Resource with sample objects.

Example:


environment := FiPShotResource new environmentWithClassesAB.
DiffModel new
	showOptions: true;
	leftText: (environment classNamed: #A) methods anyOne sourceCode;
	rightText: (environment classNamed: #B) methods anyOne sourceCode;
	contextClass: (environment classNamed: #B);
	openWithSpec.
	

"
Class {
	#name : #FiRGObjectRingTestResources,
	#superclass : #Object,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiRGObjectRingTestResources >> classA [

	^ self environmentWithAll classNamed: #A
]

{ #category : #resources }
FiRGObjectRingTestResources >> classB [

	^ self environmentWithAll classNamed: #B
]

{ #category : #resources }
FiRGObjectRingTestResources >> classC [

	^ self environmentWithAll classNamed: #C
]

{ #category : #resources }
FiRGObjectRingTestResources >> environmentWithAll [

	^ FiRGEnvironment new
		environmentShot: FiRingTestResources new environmentWithAll;
		yourself.

]
