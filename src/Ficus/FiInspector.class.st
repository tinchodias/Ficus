"
I use Spec for inspecting FiShot instances in a tree-like view.
"
Class {
	#name : #FiInspector,
	#superclass : #Object,
	#category : #'Ficus-UI'
}

{ #category : #inspecting }
FiInspector class >> inspect: rootShot [

	^ TreeModel new
		title: 'Ficus Shot Inspector';
		roots: { #root -> rootShot };
		displayBlock: [ :assoc | 
			self panelMorphWithAll: { 
				(assoc key, ' ·') asMorph.
				(assoc value isShot 
					ifTrue: [  self stringMorphWith: ('a ', assoc value species asString) color: Color blue muchDarker ]
					ifFalse: [ self stringMorphWith: assoc value storeString color: Color red muchDarker ]) } ];
		childrenBlock: [ :assoc | 
			assoc value isShot 
				ifTrue: [ assoc value stepsAndValues sorted: [ :a :b | a key < b key ] ]
				ifFalse: [ #() ] ];
		openWithSpec
]

{ #category : #private }
FiInspector class >> panelMorphWithAll: someMophs [

	^ PanelMorph new
		changeTableLayout;
		vResizing: #shrinkWrap;
		hResizing: #shrinkWrap;
		listDirection: #leftToRight;
		cellInset: 3;
		addAllMorphs: someMophs;
		yourself
]

{ #category : #private }
FiInspector class >> stringMorphWith: aString color: aColor [

	^ aString asMorph
		color: aColor;
		yourself
]
