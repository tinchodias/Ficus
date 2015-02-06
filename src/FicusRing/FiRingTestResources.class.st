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
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #(#a1 #a2));
		classPool: #(SomeClassVariable) asFiSet;
		sharedPools: #(P) asFiSet;
		methods: { 
			FiMethod sourceCode: 'sum  ^ a1 + a2'.
			FiMethod sourceCode: 'sum42  ^ self sum + 42'. } asFiSet;
		metaclass: 
			(FiMetaclass builder
				layout: (FiFixedLayout withInstanceVariables: #(#a3));
				methods: {
					FiMethod sourceCode: 'initialize  SomeClassVariable := a3 := A new'.  
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
			FiMethod sourceCode: 'readSomeSharedPoolVariable  ^ SomeSharedPoolVariable'.
			FiMethod sourceCode: 'defaultClass  ^ C'.
			} asFiSet;
		new.
]

{ #category : #resources }
FiRingTestResources >> classC [

	^ FiClass builder 
		theName: #C;
		superclassName: #Object;
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

{ #category : #resources }
FiRingTestResources >> classP [

	^ FiClass builder 
		theName: #P;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		classPool: #(SomeSharedPoolVariable) asFiSet;
		methods: FiSet new;
		new.
]

{ #category : #resources }
FiRingTestResources >> extensionMethodsToX [

	^ FiExtensionMethods builder
		hostName: #A;
		methods: { 
			FiMethod sourceCode: 'sum43  ^ self sum42 + 1'. 
			} asFiSet;
		isMetaSide: false;
		new
]

{ #category : #private }
FiRingTestResources >> newFicusEnvironment [

	^ { self packageKernel. self packageX. self packageY. } asFiSet
]

{ #category : #resources }
FiRingTestResources >> packageX [
	
	^ FiPackage builder
		theName: #X;
		contents: { self classA. self classB. self classC. self classP } asFiSet;
		new
]

{ #category : #resources }
FiRingTestResources >> packageY [
	
	^ FiPackage builder
		theName: #Y;
		contents: { self extensionMethodsToX } asFiSet;
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

{ #category : #'resources - ring level' }
FiRingTestResources >> ringClassP [

	^ self ficusRGEnvironment classNamed: #P
]
