Class {
	#name : #FiEffectInspector2,
	#superclass : #DynamicComposableModel,
	#instVars : [
		'treeModel',
		'iconByClassName',
		'diffModel',
		'rootEffect'
	],
	#category : #'Ficus-UI'
}

{ #category : #inspecting }
FiEffectInspector2 class >> inspect: rootEffect [

	^ (self newWith: rootEffect) open; yourself
]

{ #category : #inspecting }
FiEffectInspector2 class >> newWith: aRootEffect [

	^ self basicNew
		initializeWith: aRootEffect;
		yourself
]

{ #category : #private }
FiEffectInspector2 >> columnMorphWithAll: someMophs [

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

{ #category : #private }
FiEffectInspector2 >> diffChunkMorphFor: aSummary at: aPath [ 

	^ self columnMorphWithAll: { 
		self pathMorphWith: aPath.
		self diffMorphFrom: aSummary oldValueString to: aSummary newValueString.
		}
]

{ #category : #private }
FiEffectInspector2 >> diffMorphFrom: aString to: otherString [

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

{ #category : #private }
FiEffectInspector2 >> dynamicLayout [

	^ SpecLayout composed
		newRow: [ :row |
			row 
				add: #treeModel origin: 0@0 corner: 0.3@1;
				addSplitter;
				add: #diffModel origin: 0.3@0 corner: 1@1];
		yourself.

]

{ #category : #private }
FiEffectInspector2 >> iconFor: aShot [

	aShot isShot ifFalse: [ ^ Smalltalk ui icons stringIcon ].

	^ Smalltalk ui icons perform: 
		(iconByClassName 
			at: aShot species name 
			ifAbsent: [ #smallHierarchyBrowserIcon "#nautilusIcon" "#emptyIcon" ])
]

{ #category : #initialization }
FiEffectInspector2 >> initializeIconByClassName [

	iconByClassName := 
		Dictionary new
			at: #FiSummaryAdd put: #changeAddIcon;
			at: #FiSummaryRemove put: #changeRemoveIcon;
			at: #FiSummaryUpdate put: #changeUpdateIcon;
			yourself.
	
]

{ #category : #initialization }
FiEffectInspector2 >> initializePresenter [
	
	self 
		windowIcon: Smalltalk ui icons smallInspectItIcon;
		title: 'Ficus Effects Inspector'.
 
	treeModel
		evenRowColor: Color white;
		roots: self treeRoots;
		displayBlock: [ :summary | summary step ];
		childrenBlock: [ :summary | summary subSummary ];
		iconBlock: [ :summary | self iconFor: summary ];
		whenSelectedItemChanged: [ :summary | self showDiffFor: summary value ].

	diffModel
		displayBlock: [ :morph | morph ]
]

{ #category : #initialization }
FiEffectInspector2 >> initializeWidgets [ 
	
	treeModel := self instantiate: TreeModel.
	self assign: treeModel to: #treeModel.

	diffModel := self instantiate: TreeModel.
	self assign: diffModel to: #diffModel.

]

{ #category : #initialization }
FiEffectInspector2 >> initializeWith: aRootEffect [

	rootEffect := aRootEffect.

	self initializeIconByClassName.	
	self initialize.

]

{ #category : #opening }
FiEffectInspector2 >> open [

	self
		extent: 800@600;
		openWithSpecLayout: self dynamicLayout.

	"It has no effect if applied before opening:"		
	treeModel expandAll

]

{ #category : #private }
FiEffectInspector2 >> pathMorphWith: aPath [

	^ ('/' join: (aPath steps collect: #asString)) asMorph
"		emphasis: 1;"
		color: Color darkGray;
		yourself
]

{ #category : #private }
FiEffectInspector2 >> showDiffFor: anEffect [ 

	anEffect ifNil: [ ^ diffModel roots: #() ].
	
	diffModel roots: (Array 
		streamContents: [ :stream |
			anEffect
				leavesDo: [ :aLeafSummary :aPath | 
					stream nextPut: (self diffChunkMorphFor: aLeafSummary at: aPath) ]
				basePath: FiPath root ] 
		limitedTo: 15).
]

{ #category : #private }
FiEffectInspector2 >> treeRoots [

	^ rootEffect hierarchicalSummary size = 1
		ifTrue: [ rootEffect hierarchicalSummary anyOne subSummary ] "TODO: avoiding #contents in a hacky way"
		ifFalse: [ rootEffect hierarchicalSummary ].
		

]
