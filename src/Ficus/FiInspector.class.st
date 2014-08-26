Class {
	#name : #FiInspector,
	#superclass : #ComposableModel,
	#instVars : [
		'treeModel',
		'iconByClassName'
	],
	#category : #'Ficus-UI'
}

{ #category : #specs }
FiInspector class >> defaultSpec [
	<spec>

	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #treeModel ];
		yourself.

]

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

	^ self new
		rootAssociations: someAssociations;
		yourself
]

{ #category : #accessing }
FiInspector >> emptyRoots [

	self rootAssociations: #()
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
FiInspector >> initialize [

	super initialize.

	self initializeIconByClassName.	

]

{ #category : #initialization }
FiInspector >> initializeIconByClassName [

	iconByClassName := 
		Dictionary new
			"effects"
			at: #FiDictionaryAddition put: #changeAddIcon;
			at: #FiDictionaryRemoval put: #changeRemoveIcon;
			at: #FiDictionaryUpdate put: #changeUpdateIcon;

			at: #FiSetAddition put: #changeAddIcon;
			at: #FiSetRemoval put: #changeRemoveIcon;
			at: #FiSetUpdate put: #changeUpdateIcon;

			at: #FiReplacement put: #changeUpdateIcon;
			
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
	
	self instantiateModels: #(
		treeModel TreeModel)


]

{ #category : #opening }
FiInspector >> open [

	self
		extent: 700@600;
		openWithSpec.

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

{ #category : #accessing }
FiInspector >> rootAssociations: someAssociations [

	treeModel roots: someAssociations
]

{ #category : #accessing }
FiInspector >> rootShot: aShot [

	self rootAssociations: { #root -> aShot }
]

{ #category : #private }
FiInspector >> stringMorphWith: aString color: aColor [

	^ aString asMorph
		color: aColor;
		yourself
]

{ #category : #accessing }
FiInspector >> treeModel [

	^ treeModel
]
