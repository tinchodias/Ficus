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
	#name : #FiRGShotResource,
	#superclass : #Object,
	#category : #FicusRing
}

{ #category : #resources }
FiRGShotResource >> classA [

	^ self environmentWithClassesAB classNamed: #A
]

{ #category : #resources }
FiRGShotResource >> classB [

	^ self environmentWithClassesAB classNamed: #B
]

{ #category : #resources }
FiRGShotResource >> environmentWithClassesAB [

	^ FiRGEnvironment new
		environmentShot: FiShotResource new environmentWithClassesAB;
		yourself.

]
