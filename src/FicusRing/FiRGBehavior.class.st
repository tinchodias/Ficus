Class {
	#name : #FiRGBehavior,
	#superclass : #FiRGShot,
	#category : #'FicusRing-Core'
}

{ #category : #polymorphism }
FiRGBehavior >> selectorsAndMethodsDo: selectorAndMethodBlock [
	"Evaluate selectorAndMethodBlock with two arguments for each selector/method pair in my method dictionary."

	^ self methods do: [ :each | 
		selectorAndMethodBlock value: each selector value: each ]
]
