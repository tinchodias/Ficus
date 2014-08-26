Class {
	#name : #FiInspector2,
	#superclass : #ComposableModel,
	#instVars : [
		'treeModel',
		'contentsModel',
		'iconByClassName',
		'currentSelection'
	],
	#category : #'Ficus-UI'
}

{ #category : #specs }
FiInspector2 class >> defaultSpec [
	<spec>

	^ SpecLayout composed
		newColumn: [ :column |
			column 
				add: #treeModel origin: 0@0 corner: 1@0.6;
				addSplitter;
				add: #contentsModel origin: 0@0.6 corner: 1@1];
		yourself.

]

{ #category : #inspecting }
FiInspector2 class >> inspect: aRootShot [

	^ (self newWith: { #root -> aRootShot })
		open;
		yourself
]

{ #category : #inspecting }
FiInspector2 class >> inspectEffect: rootEffect [

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
FiInspector2 class >> newWith: someAssociations [

	^ self new
		rootAssociations: someAssociations;
		yourself
]

{ #category : #accessing }
FiInspector2 >> contentsModel [

	^ contentsModel
]

{ #category : #accessing }
FiInspector2 >> emptyRoots [

	self rootAssociations: #()
]

{ #category : #private }
FiInspector2 >> iconFor: aShot [

	aShot isShot ifFalse: [ ^ Smalltalk ui icons stringIcon ].

	^ Smalltalk ui icons perform: 
		(iconByClassName 
			at: aShot species name 
			ifAbsent: [ #smallHierarchyBrowserIcon "#nautilusIcon" "#emptyIcon" ])
]

{ #category : #initialization }
FiInspector2 >> initialize [

	super initialize.

	self initializeIconByClassName.	

]

{ #category : #initialization }
FiInspector2 >> initializeIconByClassName [

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
FiInspector2 >> initializePresenter [
	
	self 
		windowIcon: Smalltalk ui icons smallInspectItIcon;
		title: 'Ficus Inspector'.

	contentsModel
		displayBlock: [ :morph | morph ].
		
	treeModel
		evenRowColor: treeModel oddRowColor;
		displayBlock: [ :assoc | assoc key asMorph ];
		childrenBlock: [ :assoc | 
			assoc value isShot 
				ifTrue: [ assoc value stepsAndValues sorted: [ :a :b | a key < b key ] ]
				ifFalse: [ #() ] ];
		iconBlock: [ :assoc | self iconFor: assoc value ];
		autoDeselection:true;
		whenRootsChanged: [ 
			self flag: #fix. "Workaround: Spec in Pharo3 does not trigger that selection changed 
				when it changed due to roots update."
			self showContentsFor: nil ];
		whenSelectedItemChanged: [ :assocOrNil | 
			self showContentsFor: assocOrNil ].


]

{ #category : #initialization }
FiInspector2 >> initializeWidgets [ 
	
	self instantiateModels: #(
		treeModel			TreeModel
		contentsModel	TreeModel)


]

{ #category : #opening }
FiInspector2 >> open [

	self
		extent: 700@600;
		openWithSpec.

	"It has no effect if applied before opening:"		
	treeModel expandAll

]

{ #category : #private }
FiInspector2 >> panelMorphWithAll: someMophs [

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
FiInspector2 >> rootAssociations: someAssociations [

	treeModel roots: someAssociations
]

{ #category : #accessing }
FiInspector2 >> rootShot: aShot [

	self rootAssociations: { #root -> aShot }
]

{ #category : #initialization }
FiInspector2 >> showContentsFor: assocOrNil [

	self flag: #fix. "Workaround: Spec in Pharo3 triggers several times the same event."
	currentSelection = assocOrNil ifTrue: [ ^ self ].
	currentSelection := assocOrNil.

	assocOrNil ifNil: [ ^ contentsModel roots: #() ].
	
	contentsModel roots: {assocOrNil value asString asText asMorph lock: true; yourself}

]

{ #category : #private }
FiInspector2 >> stringMorphWith: aString color: aColor [

	^ aString asMorph
		color: aColor;
		yourself
]

{ #category : #accessing }
FiInspector2 >> treeModel [

	^ treeModel
]
