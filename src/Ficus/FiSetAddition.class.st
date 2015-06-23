Class {
	#name : #FiSetAddition,
	#superclass : #FiSetChange,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus-Model-Core-Changes'
}

{ #category : #converting }
FiSetAddition >> asSimpleChangesAt: aBasePath [
	
	^ { newValue 
			ficusDeepCollect: [ :shot :path :collectionFromChildren | 
				FiAddition builder 
					path: path;
					newValue: shot; 
					children: collectionFromChildren asFiSet;
					new ] 
			basePath: aBasePath / newValue defaultStep } asFiSet
]

{ #category : #accessing }
FiSetAddition >> edit [

	^ FiInclude value: newValue
]

{ #category : #accessing }
FiSetAddition >> inverse [

	^ FiExclude value: newValue
]

{ #category : #accessing }
FiSetAddition >> newValue [

	^ newValue
]

{ #category : #printing }
FiSetAddition >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: (newValue printStringLimitedTo: 30);
		nextPut: $).
]
