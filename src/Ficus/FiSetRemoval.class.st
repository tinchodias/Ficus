Class {
	#name : #FiSetRemoval,
	#superclass : #FiSetEffect,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #accessing }
FiSetRemoval >> edit [

	^ FiExclude value: oldValue
]

{ #category : #summary }
FiSetRemoval >> hierarchicalSummaryFrom: aBasePath [
	
	^ { oldValue 
			ficusDeepCollect: [ :shot :path :collectionFromChildren | 
				FiSummaryRemove builder 
					path: path;
					oldValue: shot; 
					subSummary: collectionFromChildren;
					new ] 
			basePath: aBasePath / oldValue defaultStep }
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
