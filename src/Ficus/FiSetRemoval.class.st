Class {
	#name : #FiSetRemoval,
	#superclass : #FiSetChange,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Model-Core-Changes'
}

{ #category : #converting }
FiSetRemoval >> asSimpleChangesAt: aBasePath [
	
	^ { oldValue 
			ficusDeepCollect: [ :shot :path :collectionFromChildren | 
				FiRemoval builder 
					path: path;
					oldValue: shot; 
					children: collectionFromChildren asFiSet;
					new ] 
			basePath: aBasePath / oldValue defaultStep } asFiSet
]

{ #category : #accessing }
FiSetRemoval >> edit [

	^ FiExclude value: oldValue
]

{ #category : #accessing }
FiSetRemoval >> inverse [

	^ FiInclude value: oldValue
]

{ #category : #accessing }
FiSetRemoval >> oldValue [

	^ oldValue
]

{ #category : #printing }
FiSetRemoval >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: (oldValue printStringLimitedTo: 30);
		nextPut: $).
]
