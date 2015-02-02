"
I hold useful methods for building Morphs.
"
Class {
	#name : #FiMorphBuilder,
	#superclass : #Object,
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'FicusStore-UI-Others'
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
FiMorphBuilder >> diffMorphFrom: aString to: otherString [

"	^ (DiffMorph from: aString to: otherString)
			showOptions: false;
			width: 400;
			height: 200;
			yourself
"
	^ (TextDiffBuilder 
		buildDisplayPatchFrom: aString
		to: otherString) asMorph
		lock: true;
		yourself

]

{ #category : #building }
FiMorphBuilder >> pathMorphWith: aPath [

	| separator |
	separator := 
		'  /  ' asText 
			addAttribute: (TextColor color: Color lightGray); 
			addAttribute: (TextFontChange fontNumber: 1); 
			yourself. 
	
	^ (separator join: (aPath steps collect: [ :each | 
			each asString asText 
				addAttribute: (TextColor color: Color darkGray); 
				addAttribute: (TextFontChange fontNumber: 2); 
				yourself ])) 
		asMorph
		lock: true;
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
FiMorphBuilder >> tagWith: aString backgroundColor: backgroundColor [

	^ self 
		tagWith: aString 
		backgroundColor: backgroundColor 
		fontColor: Color black
]

{ #category : #building }
FiMorphBuilder >> tagWith: aString backgroundColor: backgroundColor fontColor: aColor [

	| aText |
	aText := 
		aString asText
			addAttribute: (TextFontChange fontNumber: 1); 
			addAttribute: (TextColor color: aColor);
			yourself.

	^ PanelMorph new
		changeTableLayout;
		addMorphBack: (aText asMorph lock: true; yourself);
		color: backgroundColor;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap;
		layoutInset: 3@0;
		yourself
]
