"
Resource with diverse Ficus metalevel objects, intended for tests. 
"
Class {
	#name : #RFiRingTestResources,
	#superclass : #RFiBaseResources,
	#category : #'FicusRing-Tests'
}

{ #category : #resources }
RFiRingTestResources >> classA [

	^ FiClass builder 
		name: #A;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariableNames: #(#a1 #a2));
		classPool: #(SomeClassVariable) asFiSet;
		sharedPools: #(P) asFiSet;
		methods: { 
			FiMethod sourceCode: 'sum  ^ a1 + a2'.
			FiMethod sourceCode: 'sum42  ^ self sum + 42'. } asFiSet;
		metaclass: 
			(FiMetaclass builder
				layout: (FiFixedLayout withInstanceVariableNames: #(#a3));
				methods: {
					FiMethod sourceCode: 'initialize  SomeSharedPoolVariable := SomeClassVariable := a3 := A new'.  
				} asFiSet;
				new);
		new.
]

{ #category : #resources }
RFiRingTestResources >> classB [

	^ FiClass builder 
		name: #B;
		superclassName: #A;
		layout: (FiFixedLayout withInstanceVariableNames: #(b1));
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
RFiRingTestResources >> classC [

	^ FiClass builder 
		name: #C;
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
RFiRingTestResources >> classP [

	^ FiClass builder 
		name: #P;
		superclassName: #Object;
		layout: (FiFixedLayout withInstanceVariables: #());
		classPool: #(SomeSharedPoolVariable) asFiSet;
		methods: FiSet new;
		new.
]

{ #category : #resources }
RFiRingTestResources >> extensionMethodsToA [

	^ FiExtensionMethods builder
		hostName: #A;
		methods: { 
			FiMethod sourceCode: 'sum43  ^ self sum42 + 1'. 
			} asFiSet;
		isMetaSide: false;
		new
]

{ #category : #resources }
RFiRingTestResources >> extensionMethodsToAclass [

	^ FiExtensionMethods builder
		hostName: #A;
		methods: { 
			FiMethod sourceCode: 'metaSum43  ^ self new sum43'. 
			} asFiSet;
		isMetaSide: true;
		new
]

{ #category : #private }
RFiRingTestResources >> newFicusEnvironment [

	^ { self packageKernel. self packageX. self packageY. } asFiSet
]

{ #category : #resources }
RFiRingTestResources >> packageX [
	
	^ FiPackage builder
		name: #X;
		contents: { self classA. self classB. self classC. self classP } asFiSet;
		new
]

{ #category : #resources }
RFiRingTestResources >> packageY [
	
	^ FiPackage builder
		name: #Y;
		contents: { self extensionMethodsToA. self extensionMethodsToAclass } asFiSet;
		new
]

{ #category : #'resources - ring level' }
RFiRingTestResources >> ringClassA [

	^ self ringEnvironment classNamed: #A
]

{ #category : #'resources - ring level' }
RFiRingTestResources >> ringClassB [

	^ self ringEnvironment classNamed: #B
]

{ #category : #'resources - ring level' }
RFiRingTestResources >> ringClassC [

	^ self ringEnvironment classNamed: #C
]

{ #category : #'resources - ring level' }
RFiRingTestResources >> ringClassP [

	^ self ringEnvironment classNamed: #P
]
