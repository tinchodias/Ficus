Class {
	#name : #FiTag,
	#superclass : #FiFixedObject,
	#instVars : [
		'origin',
		'priorDefaultStep',
		'path',
		'contents'
	],
	#category : #'FicusStore-Tags-Model'
}

{ #category : #examples }
FiTag class >> exampleStoreFor: store [

	| tags tagsStore |
	tags := { 
		FiTag builder 
			origin: store historyNodes second origin;
			priorDefaultStep: store historyNodes second priors asArray first defaultStep;
			path: #(contents) asFiPath; 
			contents: 'Code formatting';
			new.
		FiTag builder 
			origin: store historyNodes third origin;
			priorDefaultStep: store historyNodes third priors asArray first defaultStep;
			path: #(contents) asFiPath; 
			contents: 'Bug-fixing';
			new.
	 }.

	tagsStore := FiMemoryStore new.
	tagsStore commitSnapshot: FiSet new priors: FiSet new.

	1 to: tags size do: [ :index |
		tagsStore 
			commitSnapshot: (tags first: index) asFiSet 
			priors: {tagsStore headHistoryNode} asFiSet ].

	^ tagsStore
]

{ #category : #testing }
FiTag >> appliesToOrigin: anOrigin prior: aPriorDefaultStep path: aPath [

	^ (self origin contains: anOrigin) and: [ 
		aPriorDefaultStep = priorDefaultStep and: [ 
		aPath = path ] ]
]

{ #category : #accessing }
FiTag >> contents [
	
	^ contents
]

{ #category : #accessing }
FiTag >> origin [
	
	^ origin
]

{ #category : #accessing }
FiTag >> path [
	
	^ path
]

{ #category : #accessing }
FiTag >> priorDefaultStep [
	
	^ priorDefaultStep
]
