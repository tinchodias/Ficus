Class {
	#name : #FiInspector,
	#superclass : #DynamicComposableModel,
	#instVars : [
		'treeModel',
		'rootShot'
	],
	#category : #'Ficus-UI'
}

{ #category : #inspecting }
FiInspector class >> inspect: aRootShot [

	^ self basicNew
		initializeWith: aRootShot;
		open;
		yourself
]

{ #category : #inspecting }
FiInspector class >> inspectEffect: rootEffect [

	| stepsAndSets stepsAndValues |	
	stepsAndSets := 
		rootEffect flattenedLeafEffects
			inject: Dictionary new
			into: [ :dict :each | 
				(dict 
					at: each key asString
					ifAbsentPut: [ OrderedCollection new ])
					add: each value.
				dict ].

	stepsAndValues := 
		stepsAndSets associations 
			inject: Dictionary new
			into: [ :dict :each | 
				dict 
					at: each key
					put: (FiSet withValues: each value).
				dict ].

	^ self inspect: (FiDictionary newFromStepsAndValues: stepsAndValues)
]

{ #category : #private }
FiInspector >> dynamicLayout [

	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #treeModel ];
		yourself.

]

{ #category : #initialization }
FiInspector >> initializePresenter [
	
	self 
		windowIcon: Smalltalk ui icons smallInspectItIcon;
		title: 'Ficus Inspector'.

	treeModel
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
				ifFalse: [ #() ] ].
]

{ #category : #initialization }
FiInspector >> initializeWidgets [ 
	
	treeModel := self instantiate: TreeModel.
	self assign: treeModel to: #treeModel.


]

{ #category : #initialization }
FiInspector >> initializeWith: aRootShot [

	rootShot := aRootShot.
	
	self initialize.

]

{ #category : #opening }
FiInspector >> open [

	^ self
"		extent: 900@800;"
		openWithSpecLayout: self dynamicLayout
]

{ #category : #private }
FiInspector >> panelMorphWithAll: someMophs [

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
FiInspector >> refreshSpecLayout [

	self needFullRebuild: true.
	self needRebuild: false.
 	self buildWithSpecLayout: self dynamicLayout
]

{ #category : #private }
FiInspector >> stringMorphWith: aString color: aColor [

	^ aString asMorph
		color: aColor;
		yourself
]
