Class {
	#name : #FiInspector,
	#superclass : #DynamicComposableModel,
	#instVars : [
		'treeModel',
		'rootAssociations',
		'iconByClassName'
	],
	#category : #'Ficus-UI'
}

{ #category : #inspecting }
FiInspector class >> inspect: aRootShot [

	^ (self newWith: { #root -> aRootShot })
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

	^ (self newWith: stepsAndValues associations) open; yourself
]

{ #category : #inspecting }
FiInspector class >> newWith: someAssociations [

	^ self basicNew
		initializeWith: someAssociations;
		yourself
]

{ #category : #private }
FiInspector >> dynamicLayout [

	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #treeModel ];
		yourself.

]

{ #category : #private }
FiInspector >> iconFor: aShot [

	aShot isShot ifFalse: [ ^ Smalltalk ui icons stringIcon ].

	^ Smalltalk ui icons perform: 
		(iconByClassName 
			at: aShot species name 
			ifAbsent: [ #smallHierarchyBrowserIcon "#nautilusIcon" "#emptyIcon" ])
]

{ #category : #initialization }
FiInspector >> initializeIconByClassName [

	iconByClassName := 
		Dictionary new
			"effects"
			at: #FiDictionaryAddEffect put: #changeAddIcon;
			at: #FiDictionaryRemoveEffect put: #changeRemoveIcon;
			at: #FiDictionaryUpdateEffect put: #changeUpdateIcon;

			at: #FiSetAddEffect put: #changeAddIcon;
			at: #FiSetRemoveEffect put: #changeRemoveIcon;
			at: #FiSetUpdateEffect put: #changeUpdateIcon;

			at: #FiReplace put: #changeUpdateIcon;
			
			"meta"
			at: #FiPackage put: #packageIcon;
			at: #FiClass put: #classIcon;
			at: #FiMetaclass put: #classIcon;
			at: #FiTrait put: #traitIcon;
			at: #FiMethod put: #testGreenIcon;
			
			"core"
			at: #FiSet put: #collectionIcon;
			at: #FiDictionary put: #collectionIcon;

			yourself.
	
]

{ #category : #initialization }
FiInspector >> initializePresenter [
	
	self 
		windowIcon: Smalltalk ui icons smallInspectItIcon;
		title: 'Ficus Inspector'.

	treeModel
		roots: rootAssociations;
		displayBlock: [ :assoc | 
			self panelMorphWithAll: { 
				(assoc key, ' ·') asMorph.
				(assoc value isShot 
					ifTrue: [  self stringMorphWith: ('a ', assoc value species asString) color: Color blue muchDarker ]
					ifFalse: [ self stringMorphWith: (assoc value printStringLimitedTo: 60) color: Color red muchDarker ]) } ];
		childrenBlock: [ :assoc | 
			assoc value isShot 
				ifTrue: [ assoc value stepsAndValues sorted: [ :a :b | a key < b key ] ]
				ifFalse: [ #() ] ];
		iconBlock: [ :assoc | self iconFor: assoc value ].

]

{ #category : #initialization }
FiInspector >> initializeWidgets [ 
	
	treeModel := self instantiate: TreeModel.
	self assign: treeModel to: #treeModel.


]

{ #category : #initialization }
FiInspector >> initializeWith: someAssociations [

	rootAssociations := someAssociations.

	self initializeIconByClassName.	
	self initialize.

]

{ #category : #opening }
FiInspector >> open [

	self
		extent: 700@600;
		openWithSpecLayout: self dynamicLayout.

	"It has no effect if applied before opening:"		
	treeModel expandAll

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
