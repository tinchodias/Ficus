Class {
	#name : #FiSetRemoval,
	#superclass : #FiSetEffect,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #converting }
FiSetRemoval >> asSimpleEffectAt: aBasePath [
	
	^ { oldValue 
			ficusDeepCollect: [ :shot :path :collectionFromChildren | 
				FiRemoval builder 
					path: path;
					oldValue: shot; 
					children: collectionFromChildren;
					new ] 
			basePath: aBasePath / oldValue defaultStep }
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
