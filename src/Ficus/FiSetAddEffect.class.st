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

	^ self include: newValue
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

	^ self exclude: newValue
]

{ #category : #accessing }
FiSetAddEffect >> newValue [

	^ newValue
]
