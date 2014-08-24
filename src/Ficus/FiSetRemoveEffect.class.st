Class {
	#name : #FiSetRemoveEffect,
	#superclass : #FiSetEffect,
	#instVars : [
		'oldValue'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #accessing }
FiSetRemoveEffect >> edit [

	^ self exclude: oldValue
]

{ #category : #summary }
FiSetRemoveEffect >> hierarchicalSummary [
	
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
FiSetRemoveEffect >> inverse [

	^ self include: oldValue
]

{ #category : #accessing }
FiSetRemoveEffect >> oldValue [

	^ oldValue
]

{ #category : #printing }
FiSetRemoveEffect >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: (oldValue printStringLimitedTo: 30);
		nextPut: $).
]
