Class {
	#name : #FiSetAddEffect,
	#superclass : #FiSetEffect,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #accessing }
FiSetAddEffect >> edit [

	^ FiInclude value: newValue
]

{ #category : #summary }
FiSetAddEffect >> hierarchicalSummary [
	
	^ { newValue 
		ficusDeepCollect: [ :shot :path :collectionFromChildren | 
			FiSummaryAdd builder 
				step: path step;
				newValue: shot; 
				subSummary: collectionFromChildren;
				new ] 
		basePath: FiPath root / newValue defaultStep }
]

{ #category : #accessing }
FiSetAddEffect >> inverse [

	^ FiExclude value: newValue
]

{ #category : #accessing }
FiSetAddEffect >> newValue [

	^ newValue
]

{ #category : #printing }
FiSetAddEffect >> printOn: aStream [

	super printOn: aStream.
	
	aStream 
		nextPut: $(;
		nextPutAll: (newValue printStringLimitedTo: 30);
		nextPut: $).
]
