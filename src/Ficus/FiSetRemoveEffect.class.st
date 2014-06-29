Class {
	#name : #FiSetRemoveEffect,
	#superclass : #FiSetEffect,
	#category : #'Ficus-Model-Effects'
}

{ #category : #accessing }
FiSetRemoveEffect >> edit [

	^ self exclude: theValue
]

{ #category : #summary }
FiSetRemoveEffect >> hierarchicalSummary [
	
	^ { theValue 
		ficusDeepCollect: [ :shot :path :collectionFromChildren | 
			FiSummaryRemove builder 
				step: path step;
				oldValue: shot; 
				subSummary: collectionFromChildren;
				new ] 
		basePath: FiPath root / theValue defaultStep }
]

{ #category : #accessing }
FiSetRemoveEffect >> inverse [

	^ self include: theValue
]
