"
Resource with diverse Ficus metalevel objects, intended for tests.
"
Class {
	#name : #FiRingTestResources,
	#superclass : #FiBaseResources,
	#category : #'FicusRing-Examples'
}

{ #category : #resources }
FiRingTestResources >> classA [

	^ FiClass builder 
		theName: #A;
		layout: (FiFixedLayout withInstanceVariables: #(#a1 #a2));
		classPool: #(SomeClassVariable) asFiSet;
		methods: { 
			FiMethod sourceCode: 'sum  ^ a1 + a2'.
			FiMethod sourceCode: 'sum42  ^ self sum + 42'. } asFiSet;
		metaclass: 
			(FiMetaclass builder
				layout: (FiFixedLayout withInstanceVariables: #(#a3));
				methods: {
					FiMethod sourceCode: 'initialize  SomeClassVariable := a3 := 42'.  
				} asFiSet;
				new);
		new.
]

{ #category : #resources }
FiRingTestResources >> classB [

	^ FiClass builder 
		theName: #B;
		superclassName: #A;
		layout: (FiFixedLayout withInstanceVariables: #(b1));
		methods: { 
			FiMethod sourceCode: 'initialize  b1 := 0'.
			FiMethod sourceCode: 'resetAll  b1 := a1 := a2 := 0'.
			FiMethod sourceCode: 'sum  ^ super sum + b1'.
			FiMethod sourceCode: 'variableInSuper  ^ a1'.
			FiMethod sourceCode: 'readSomeClassVariable  ^ SomeClassVariable'.
			FiMethod sourceCode: 'defaultClass  ^ C'.
			} asFiSet;
		new.
]

{ #category : #resources }
FiRingTestResources >> classC [

	^ FiClass builder 
		theName: #C;
		layout: (FiFixedLayout withInstanceVariables: #());
		methods: { 
			FiMethod sourceCode: 'sum  ^ 0.0'.
			FiMethod sourceCode: 'returnSelf  ^ self'.
			FiMethod sourceCode: 'string  ^ ''a string'''.
			FiMethod sourceCode: 'array1  ^ #(1 2)'.
			FiMethod sourceCode: 'array2  ^ {1. 2}'.
			FiMethod sourceCode: 'undeclared  ^ undeclaredVar'.
			FiMethod sourceCode: 'sumAt: argument  ^ argument sum'.
			FiMethod sourceCode: 'sumTmp  |tmp| tmp := self sum. ^tmp+tmp'.
			} asFiSet;
		new.
]

{ #category : #private }
FiRingTestResources >> newFicusEnvironment [

	^ { self packageKernel. self packageX. } asFiSet
]

{ #category : #resources }
FiRingTestResources >> packageX [
	
	^ FiPackage builder
		theName: #X;
		contents: { self classA. self classB. self classC } asFiSet;
		new
]

{ #category : #'resources - ring level' }
FiRingTestResources >> ringClassA [

	^ self ficusRGEnvironment classNamed: #A
]

{ #category : #'resources - ring level' }
FiRingTestResources >> ringClassB [

	^ self ficusRGEnvironment classNamed: #B
]

{ #category : #'resources - ring level' }
FiRingTestResources >> ringClassC [

	^ self ficusRGEnvironment classNamed: #C
]
