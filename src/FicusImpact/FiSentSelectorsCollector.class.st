Class {
	#name : #FiSentSelectorsCollector,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'selectors'
	],
	#category : #'FicusImpact-AST'
}

{ #category : #initialization }
FiSentSelectorsCollector >> initialize [

	super initialize.
	
	selectors := IdentitySet new.
]

{ #category : #accessing }
FiSentSelectorsCollector >> selectors [
	
	^ selectors
]

{ #category : #visitor }
FiSentSelectorsCollector >> visitMessageNode: aMessageNode [

	| selectorString |
	selectorString := (String streamContents: [ :str | aMessageNode selectorParts do: [ :each | str nextPutAll: each value ]]).

	selectors add: selectorString asSymbol.
	
	super visitMessageNode: aMessageNode.
]
