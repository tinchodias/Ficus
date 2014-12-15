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
	#name : #FiRGObjectResources,
	#superclass : #Object,
	#category : #'FicusRing-Tests'
}

{ #category : #resources }
FiRGObjectResources >> classA [

	^ self environmentWithClassesABC classNamed: #A
]

{ #category : #resources }
FiRGObjectResources >> classB [

	^ self environmentWithClassesABC classNamed: #B
]

{ #category : #resources }
FiRGObjectResources >> classC [

	^ self environmentWithClassesABC classNamed: #C
]

{ #category : #resources }
FiRGObjectResources >> environmentWithClassesABC [

	^ FiRGEnvironment new
		environmentShot: FiShotResources new environmentWithClassesABC;
		yourself.

]

{ #category : #resources }
FiRGObjectResources >> environmentWithClassesABCAndExtensionMethod [

	^ FiRGEnvironment new
		environmentShot: FiShotResources new environmentWithClassesABCAndExtensionMethod;
		yourself.

]
