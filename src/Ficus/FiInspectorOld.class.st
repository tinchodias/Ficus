Class {
	#name : #FiInspectorOld,
	#superclass : #ComposableModel,
	#instVars : [
		'treeModel',
		'iconByClassName'
	],
	#category : #'Ficus-UI'
}

{ #category : #specs }
FiInspectorOld class >> defaultSpec [
	<spec>

	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #treeModel ];
		yourself.

]

{ #category : #inspecting }
FiInspectorOld class >> inspect: aRootShot [

	^ (self newWith: { #root -> aRootShot })
		open;
		yourself
]

{ #category : #inspecting }
FiInspectorOld class >> inspectEffect: rootEffect [

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
FiInspectorOld class >> newWith: someAssociations [

	^ self new
		rootAssociations: someAssociations;
		yourself
]

{ #category : #accessing }
FiInspectorOld >> emptyRoots [

	self rootAssociations: #()
]

{ #category : #private }
FiInspectorOld >> iconFor: aShot [

	aShot isShot ifFalse: [ ^ Smalltalk ui icons stringIcon ].

	^ Smalltalk ui icons perform: 
		(iconByClassName 
			at: aShot species name 
			ifAbsent: [ #smallHierarchyBrowserIcon "#nautilusIcon" "#emptyIcon" ])
]

{ #category : #initialization }
FiInspectorOld >> initialize [

	super initialize.

	self initializeIconByClassName.	

]

{ #category : #initialization }
FiInspectorOld >> initializeIconByClassName [

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
			
			"core"
			at: #FiSet put: #collectionIcon;
			at: #FiDictionary put: #collectionIcon;

			yourself.
	
]

{ #category : #initialization }
FiInspectorOld >> initializePresenter [
	
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
FiInspectorOld >> initializeWidgets [ 
	
	self instantiateModels: #(
		treeModel TreeModel)


]

{ #category : #opening }
FiInspectorOld >> open [

	self
		extent: 700@600;
		openWithSpec.

	"It has no effect if applied before opening:"		
	treeModel expandAll

]

{ #category : #private }
FiInspectorOld >> panelMorphWithAll: someMophs [

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
FiInspectorOld >> rootAssociations: someAssociations [

	treeModel roots: someAssociations
]

{ #category : #accessing }
FiInspectorOld >> rootShot: aShot [

	self rootAssociations: { #root -> aShot }
]

{ #category : #private }
FiInspectorOld >> stringMorphWith: aString color: aColor [

	^ aString asMorph
		color: aColor;
		yourself
]

{ #category : #accessing }
FiInspectorOld >> treeModel [

	^ treeModel
]
