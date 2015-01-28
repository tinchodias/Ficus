"
Resource with diverse Ficus metalevel objects, intended for tests. I answer a variant of my superclass.
"
Class {
	#name : #FiRingTestWithExtensionsResources,
	#superclass : #FiRingTestResources,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiRingTestWithExtensionsResources >> environmentWithAll [

	^ { self packageKernel. self packageX. self packageY. } asFiSet
]

{ #category : #resources }
FiRingTestWithExtensionsResources >> extensionMethodsToX [

	^ FiExtensionMethods builder
		hostName: #A;
		methods: { 
			FiMethod sourceCode: 'sum43  ^ self sum42 + 1'. 
			} asFiSet;
		isMetaSide: false;
		new
]

{ #category : #resources }
FiRingTestWithExtensionsResources >> packageY [
	
	^ FiPackage builder
		theName: #Y;
		contents: { self extensionMethodsToX } asFiSet;
		new
]
