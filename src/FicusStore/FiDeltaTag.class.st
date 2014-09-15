Class {
	#name : #FiDeltaTag,
	#superclass : #FiFixedObject,
	#instVars : [
		'origin',
		'priorDefaultStep',
		'path',
		'contents'
	],
	#category : #'FicusStore-Models'
}

{ #category : #examples }
FiDeltaTag class >> exampleStoreFor: store [

	| tags tagsStore |
	tags := { 
		FiDeltaTag builder 
			origin: store historyNodes second origin;
			priorDefaultStep: store historyNodes second priors asArray first defaultStep;
			path: #contents asFicusPath; 
			contents: 'Code formatting';
			new.
		FiDeltaTag builder 
			origin: store historyNodes third origin;
			priorDefaultStep: store historyNodes third priors asArray first defaultStep;
			path: #contents asFicusPath; 
			contents: 'Bug-fixing';
			new.
	 }.

	tagsStore := FiMemoryStore new.
	tagsStore commitSnapshot: FiSet new priors: FiSet new.

	1 to: tags size do: [ :index |
		tagsStore 
			commitSnapshot: (FiSet withValues: (tags first: index)) 
			priors: (FiSet withValues: {tagsStore headHistoryNode}) ].

	^ tagsStore
]

{ #category : #testing }
FiDeltaTag >> appliesToOrigin: anOrigin prior: aPriorDefaultStep summaryPath: aPath [

	^ (self origin contains: anOrigin) and: [ aPriorDefaultStep = priorDefaultStep and: [ aPath = path ] ]
]

{ #category : #accessing }
FiDeltaTag >> contents [
	
	^ contents
]

{ #category : #accessing }
FiDeltaTag >> origin [
	
	^ origin
]

{ #category : #accessing }
FiDeltaTag >> path [
	
	^ path
]

{ #category : #accessing }
FiDeltaTag >> priorDefaultStep [
	
	^ priorDefaultStep
]
