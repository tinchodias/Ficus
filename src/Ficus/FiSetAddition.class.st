Class {
	#name : #FiSetAddition,
	#superclass : #FiSetEffect,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #accessing }
FiSetAddition >> edit [

	^ FiInclude value: newValue
]

{ #category : #summary }
FiSetAddition >> hierarchicalSummaryFrom: aBasePath [
	
	^ { newValue 
		ficusDeepCollect: [ :shot :path :collectionFromChildren | 
			FiSummaryAdd builder 
				path: path;
				newValue: shot; 
				subSummary: collectionFromChildren;
				new ] 
		basePath: aBasePath / newValue defaultStep }
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
