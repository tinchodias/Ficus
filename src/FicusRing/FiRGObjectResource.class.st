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
	#name : #FiRGObjectResource,
	#superclass : #Object,
	#category : #'FicusRing-Tests'
}

{ #category : #resources }
FiRGObjectResource >> classA [

	^ self environmentWithClassesABC classNamed: #A
]

{ #category : #resources }
FiRGObjectResource >> classB [

	^ self environmentWithClassesABC classNamed: #B
]

{ #category : #resources }
FiRGObjectResource >> classC [

	^ self environmentWithClassesABC classNamed: #C
]

{ #category : #resources }
FiRGObjectResource >> environmentWithClassesABC [

	^ FiRGEnvironment new
		environmentShot: FiShotResource new environmentWithClassesABC;
		yourself.

]
