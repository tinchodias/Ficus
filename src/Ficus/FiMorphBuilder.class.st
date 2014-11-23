Class {
	#name : #FiMorphBuilder,
	#superclass : #Object,
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'Ficus-UI'
}

{ #category : #accessing }
FiMorphBuilder class >> default [

	^ defaultInstance ifNil: [ defaultInstance := self new ]
]

{ #category : #building }
FiMorphBuilder >> columnMorphWithAll: someMophs [

	^ PanelMorph new
		changeTableLayout;
		vResizing: #shrinkWrap;
		hResizing: #shrinkWrap;
		listDirection: #topToBottom;
		cellPositioning: #topLeft;
		cellInset: 8;
		addAllMorphs: someMophs;
		yourself
]

{ #category : #building }
FiMorphBuilder >> rowMorphWithAll: someMophs [

	^ PanelMorph new
		changeTableLayout;
		vResizing: #shrinkWrap;
		hResizing: #shrinkWrap;
		listDirection: #leftToRight;
		cellInset: 3;
		addAllMorphs: someMophs;
		yourself
]

{ #category : #building }
FiMorphBuilder >> stringMorphWith: aString [

	^ self 
		stringMorphWith: aString 
		color: Color black
]

{ #category : #building }
FiMorphBuilder >> stringMorphWith: aString color: aColor [

	^ aString asMorph
		lock: true;
		color: aColor;
		yourself
]

{ #category : #building }
FiMorphBuilder >> tagWith: aString color: aColor [

	| aText |
	aText := 
		aString asText
			addAttribute: (TextFontChange fontNumber: 1); 
			yourself.

	^ PanelMorph new
		changeTableLayout;
		addMorphBack: (aText asMorph lock: true; yourself);
		color: aColor;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap;
		layoutInset: 3@0;
		yourself
]
