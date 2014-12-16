"
Resource with sample Ficus metalevel objects.
"
Class {
	#name : #FiShotResources,
	#superclass : #Object,
	#category : #'FicusRing-Tests'
}

{ #category : #resources }
FiShotResources >> classA [

	^ FiClass builder 
		theName: #A;
		layout: (FiFixedLayout withInstanceVariables: #(#a1 #a2));
		methods: { 
			FiMethod sourceCode: 'sum  ^ a1 + a2'.
			FiMethod sourceCode: 'sum42  ^ self sum + 42'. } asFiSet;
		new.
]

{ #category : #resources }
FiShotResources >> classB [

	^ FiClass builder 
		theName: #B;
		superclassName: #A;
		classPool: #(BConstants) asFiSet;
		layout: (FiFixedLayout withInstanceVariables: #(b1));
		methods: { 
			FiMethod sourceCode: 'sum  ^ super sum + b1'.
			FiMethod sourceCode: 'variableInSuper  ^ a1'.
			FiMethod sourceCode: 'defaultClass  ^ C'.
			} asFiSet;
		new.
]

{ #category : #resources }
FiShotResources >> classC [

	^ FiClass builder 
		theName: #C;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: { 
			FiMethod sourceCode: 'sum  ^ 0'.
			FiMethod sourceCode: 'undeclared  ^ undeclaredVar'.
			FiMethod sourceCode: 'sumAt: argument  ^ argument sum' 
			} asFiSet;
		new.
]

{ #category : #resources }
FiShotResources >> environmentWithClassesABC [

	^ { self packageXWithClassesABC } asFiSet
]

{ #category : #resources }
FiShotResources >> environmentWithClassesABCAndExtensionMethod [

	^ { self packageXWithClassesABC. self packageYWithExtensionMethod } asFiSet
]

{ #category : #resources }
FiShotResources >> extensionMethodsToX [

	^ FiExtensionMethods builder
		hostName: #A;
		methods: { 
			FiMethod sourceCode: 'sum43  ^ self sum42 + 1'. 
			} asFiSet;
		isMetaSide: false;
		new
]

{ #category : #resources }
FiShotResources >> packageXWithClassesABC [
	
	^ FiPackage builder
		theName: #X;
		contents: { self classA. self classB. self classC } asFiSet;
		new
]

{ #category : #resources }
FiShotResources >> packageYWithExtensionMethod [
	
	^ FiPackage builder
		theName: #Y;
		contents: { self extensionMethodsToX } asFiSet;
		new
]
