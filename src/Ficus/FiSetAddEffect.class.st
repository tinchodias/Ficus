Class {
	#name : #FiSetAddEffect,
	#superclass : #FiSetEffect,
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiSetAddEffect >> edit [

	^ self include: theValue
]

{ #category : #summary }
FiSetAddEffect >> hierarchicalSummary [
	
	^ { theValue 
		ficusDeepCollect: [ :shot :path :collectionFromChildren | 
			FiSummaryAdd builder 
				step: path step;
				newValue: shot; 
				subSummary: collectionFromChildren;
				new ] 
		basePath: FiPath root / theValue defaultStep }
]

{ #category : #accessing }
FiSetAddEffect >> inverse [

	^ self exclude: theValue
]
