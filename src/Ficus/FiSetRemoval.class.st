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
FiSetRemoval >> hierarchicalSummary [
	
	^ { oldValue 
		ficusDeepCollect: [ :shot :path :collectionFromChildren | 
			FiSummaryRemove builder 
				step: path step;
				oldValue: shot; 
				subSummary: collectionFromChildren;
				new ] 
		basePath: FiPath root / oldValue defaultStep }
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
