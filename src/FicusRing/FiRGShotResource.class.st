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
	#category : #'FicusRing-Tests'
}

{ #category : #resources }
FiRGShotResource >> classA [

	^ self environmentWithClassesABC classNamed: #A
]

{ #category : #resources }
FiRGShotResource >> classB [

	^ self environmentWithClassesABC classNamed: #B
]

{ #category : #resources }
FiRGShotResource >> classC [

	^ self environmentWithClassesABC classNamed: #C
]

{ #category : #resources }
FiRGShotResource >> environmentWithClassesABC [

	^ FiRGEnvironment new
		environmentShot: FiShotResource new environmentWithClassesABC;
		yourself.

]
