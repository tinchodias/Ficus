Class {
	#name : #FiSetAddition,
	#superclass : #FiSetEffect,
	#instVars : [
		'newValue'
	],
	#category : #'Ficus-Model-Core-Effects'
}

{ #category : #converting }
FiSetAddition >> asSimpleEffectsAt: aBasePath [
	
	^ { newValue 
			ficusDeepCollect: [ :shot :path :collectionFromChildren | 
				FiAddition builder 
					path: path;
					newValue: shot; 
					children: collectionFromChildren;
					new ] 
			basePath: aBasePath / newValue defaultStep }
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
