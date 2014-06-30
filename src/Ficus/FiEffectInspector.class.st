Class {
	#name : #FiEffectInspector,
	#superclass : #DynamicComposableModel,
	#instVars : [
		'treeModel',
		'iconByClassName',
		'diffModel',
		'diffSelectorBySummaryClassName',
		'rootEffect'
	],
	#category : #'Ficus-UI'
}

{ #category : #inspecting }
FiEffectInspector class >> inspect: rootEffect [

	^ (self newWith: rootEffect) open; yourself
]

{ #category : #inspecting }
FiEffectInspector class >> newWith: aRootEffect [

	^ self basicNew
		initializeWith: aRootEffect;
		yourself
]

{ #category : #private }
FiEffectInspector >> dynamicLayout [

	^ SpecLayout composed
		newRow: [ :row |
			row 
				add: #treeModel origin: 0@0 corner: 0.3@1;
				addSplitter;
				add: #diffModel origin: 0.3@0 corner: 1@1];
		yourself.

]

{ #category : #private }
FiEffectInspector >> iconFor: aShot [

	aShot isShot ifFalse: [ ^ Smalltalk ui icons stringIcon ].

	^ Smalltalk ui icons perform: 
		(iconByClassName 
			at: aShot species name 
			ifAbsent: [ #smallHierarchyBrowserIcon "#nautilusIcon" "#emptyIcon" ])
]

{ #category : #initialization }
FiEffectInspector >> initializeDiffSelectorByClassName [

	diffSelectorBySummaryClassName := 
		Dictionary new
			at: #FiSummaryAdd put: #showAddDiff:;
			at: #FiSummaryRemove put: #showRemoveDiff:;
			at: #FiSummaryUpdate put: #showUpdateDiff:;
			yourself.
	
]

{ #category : #initialization }
FiEffectInspector >> initializeIconByClassName [

	iconByClassName := 
		Dictionary new
			at: #FiSummaryAdd put: #changeAddIcon;
			at: #FiSummaryRemove put: #changeRemoveIcon;
			at: #FiSummaryUpdate put: #changeUpdateIcon;
			yourself.
	
]

{ #category : #initialization }
FiEffectInspector >> initializePresenter [
	
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

]

{ #category : #initialization }
FiEffectInspector >> initializeWidgets [ 
	
	treeModel := self instantiate: TreeModel.
	self assign: treeModel to: #treeModel.

	diffModel := self instantiate: DiffModel.
	self assign: diffModel to: #diffModel.

]

{ #category : #initialization }
FiEffectInspector >> initializeWith: aRootEffect [

	rootEffect := aRootEffect.

	self initializeIconByClassName.	
	self initializeDiffSelectorByClassName.
	self initialize.

]

{ #category : #opening }
FiEffectInspector >> open [

	self
		extent: 800@600;
		openWithSpecLayout: self dynamicLayout.

	"It has no effect if applied before opening:"		
	treeModel expandAll

]

{ #category : #initialization }
FiEffectInspector >> printStringFor: anObject [

	^ anObject isString 
		ifTrue: [ anObject ]
		ifFalse: [ '' ]
]

{ #category : #initialization }
FiEffectInspector >> showAddDiff: summaryAdd [

	diffModel
		leftText: '';
		rightText: (self printStringFor: summaryAdd newValue).
]

{ #category : #private }
FiEffectInspector >> showDefaultDiff: aSummary [

	^ self showEmptyDiff
]

{ #category : #private }
FiEffectInspector >> showDiffFor: anEffect [ 

	self 
		perform: 
			(diffSelectorBySummaryClassName
				at: anEffect species name
				ifAbsent: [ #showDefaultDiff: ])
		withArguments: { anEffect }
]

{ #category : #private }
FiEffectInspector >> showEmptyDiff [

	diffModel
		leftText: '';
		rightText: ''.
]

{ #category : #initialization }
FiEffectInspector >> showRemoveDiff: summaryRemove [

	diffModel
		leftText: (self printStringFor: summaryRemove oldValue);
		rightText: ''.
]

{ #category : #initialization }
FiEffectInspector >> showUpdateDiff: summaryUpdate [

	diffModel
		leftText: (self printStringFor: summaryUpdate oldValue);
		rightText: (self printStringFor: summaryUpdate newValue).
]

{ #category : #private }
FiEffectInspector >> treeRoots [

	^ rootEffect hierarchicalSummary size = 1
		ifTrue: [ rootEffect hierarchicalSummary anyOne subSummary ] "TODO: avoiding #contents in a hacky way"
		ifFalse: [ rootEffect hierarchicalSummary ].
		

]
