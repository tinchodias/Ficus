"
A FiEnvironmentEditsTest is xxxxxxxxx.

"
Class {
	#name : #FiEffectTest,
	#superclass : #TestCase,
	#category : #'Ficus-Tests'
}

{ #category : #'tests-dictionary' }
FiEffectTest >> testAddClass [

	| shot edit source result effect summary |
	source := FiDictionary new.
	shot := FiClass named: #A.

	edit := source at: #A equal: shot.
	effect := source effectOf: edit.
	result := source resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (source exclude: #A).
	
	self assert: source values isEmpty.
	self assert: result values asSet equals: { shot } asSet.
	self assert: (result resultOf: effect inverse) values isEmpty.

	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root -> effect }.

	self flag: #todo. "refactor"
	summary := effect hierarchicalSummary.
	self assert: summary isCollection.
	self assert: summary size equals: 1.
	self assert: (summary anyOne isKindOf: FiSummaryAdd).
	self assert: summary anyOne step equals: #A.
	self assert: summary anyOne subSummary isNotEmpty.
	self assert: (summary anyOne subSummary allSatisfy: [ :each | each isKindOf: FiSummaryAdd ]).

]

{ #category : #'tests-shot' }
FiEffectTest >> testAddSharedPoolAndUpdateComment [

	| source editSharedPools editComment edit effect leafEffectOfEditSharedPools leafEffectOfEditComment result |
	source := FiClass named: #A.

	editSharedPools := 
		source 
			at: #sharedPools
			edit: [ :sharedPools | sharedPools include: #X ].
	editComment := 
		source
			at: #comment
			equal: '42'.

	edit := source edits: { editSharedPools. editComment }.			
	effect := source effectOf: edit.
	result := source resultOf: edit.

	"These are the 'leaf effects' we expect of #flattenedEffects"
	leafEffectOfEditSharedPools := (source effectOf: editSharedPools) subEffect.
	leafEffectOfEditComment := (source effectOf: editComment) subEffect.

	self assert: effect edit equals: edit.
	self 
		assert: effect inverse 
		equals: (result edits: {(source effectOf: editSharedPools) inverse. (source effectOf: editComment) inverse }).
	
	self flag: #todo. "Smells bad that both oldValues are the old comment..."
	self assert: (source effectOf: editComment) edit equals: editComment.
	self assert: (source effectOf: editComment) oldValue equals: ''.
	self assert: leafEffectOfEditComment edit equals: editComment edit.
	self assert: leafEffectOfEditComment oldValue equals: ''.
	
	
	self 
		assert: leafEffectOfEditSharedPools flattenedLeafEffects 
		equals: { FiPath root -> leafEffectOfEditSharedPools }.

	self 
		assert: leafEffectOfEditComment flattenedLeafEffects 
		equals: { FiPath root -> leafEffectOfEditComment }.
			
	self 
		assert: effect flattenedLeafEffects 
		equals: { 
			FiPath root / #sharedPools -> leafEffectOfEditSharedPools.
			FiPath root / #comment -> leafEffectOfEditComment.
			} .

	self 
		assert: effect hierarchicalSummary asSet
		equals: {
			(FiSummaryUpdate builder 
				step: #sharedPools;
				oldValue: source sharedPools; 
				newValue: result sharedPools; 
				subSummary: { 
					(FiSummaryAdd builder 
						step: #X; 
						newValue: #X; 
						subSummary: #();
						new). };
				new).
			(FiSummaryUpdate builder 
				step: #comment;
				oldValue: ''; 
				newValue: '42'; 
				subSummary: #();
				new)} asSet
]

{ #category : #'tests-dictionary' }
FiEffectTest >> testNoEffect [

	| shot edit source result intermediate effect |
	source := FiDictionary new.
	shot := FiClass named: #A.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate at: #A equal: shot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: effect edit equals: FiNoEdit new.
	self assert: effect inverse equals: FiNoEdit new.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { shot } asSet.

	self assert: effect flattenedLeafEffects isEmpty.
]

{ #category : #'tests-dictionary' }
FiEffectTest >> testRemoveClass [

	| edit source result shot intermediate reverted effect summary |
	source := FiDictionary new.
	shot := FiClass named: #A.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate exclude: shot theName.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result at: #A equal: shot).

	reverted := result resultOf: effect inverse.
		
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values isEmpty.
	self assert: reverted values asSet equals: { shot } asSet.

	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root -> effect }.

	self flag: #todo. "refactor"
	summary := effect hierarchicalSummary.
	self assert: summary isCollection.
	self assert: summary size equals: 1.
	self assert: (summary anyOne isKindOf: FiSummaryRemove).
	self assert: summary anyOne step equals: #A.
	self assert: summary anyOne subSummary isNotEmpty.
	self assert: (summary anyOne subSummary allSatisfy: [ :each | each isKindOf: FiSummaryRemove ]).

]

{ #category : #'tests-set' }
FiEffectTest >> testSetAddClass [

	| shot edit source result effect summary |
	source := FiSet new.
	shot := FiClass named: #A.

	edit := source include: shot.
	effect := source effectOf: edit.
	result := source resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result exclude: shot).
	
	self assert: source values isEmpty.
	self assert: result values asSet equals: { shot } asSet.
	self assert: (result resultOf: effect inverse) values isEmpty.

	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root -> effect }.

	self flag: #todo. "refactor"
	summary := effect hierarchicalSummary.
	self assert: summary isCollection.
	self assert: summary size equals: 1.
	self assert: (summary anyOne isKindOf: FiSummaryAdd).
	self assert: summary anyOne step equals: #A.
	self assert: summary anyOne subSummary isNotEmpty.
	self assert: (summary anyOne subSummary allSatisfy: [ :each | each isKindOf: FiSummaryAdd ]).

]

{ #category : #'tests-set' }
FiEffectTest >> testSetNoEffect [

	| shot edit source result intermediate effect reverted |
	source := FiSet new.
	shot := FiClass named: #A.

	edit := source include: shot.
	intermediate := source resultOf: edit.

	edit := intermediate include: shot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	reverted := result resultOf: effect inverse.

	self assert: effect edit equals: FiNoEdit new.
	self assert: effect inverse equals: FiNoEdit new.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { shot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.

	self assert: effect flattenedLeafEffects isEmpty.
]

{ #category : #'tests-set' }
FiEffectTest >> testSetRemoveClass [

	| edit source result shot intermediate reverted effect summary |
	source := FiSet new.
	shot := FiClass named: #A.

	edit := source include: shot.
	intermediate := source resultOf: edit.

	edit := intermediate exclude: shot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result include: shot).

	reverted := result resultOf: effect inverse.
		
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values isEmpty.
	self assert: reverted values asSet equals: { shot } asSet.

	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root -> effect }.

	self flag: #todo. "refactor"
	summary := effect hierarchicalSummary.
	self assert: summary isCollection.
	self assert: summary size equals: 1.
	self assert: (summary anyOne isKindOf: FiSummaryRemove).
	self assert: summary anyOne step equals: #A.
	self assert: summary anyOne subSummary isNotEmpty.
	self assert: (summary anyOne subSummary allSatisfy: [ :each | each isKindOf: FiSummaryRemove ]).

]

{ #category : #'tests-set' }
FiEffectTest >> testSetUpdateClass [

	| shot otherShot edit source result intermediate effect reverted summary |
	source := FiSet new.
	shot := FiClass named: #A.
	otherShot := shot resultOf: (shot at: #comment equal: '42').

	edit := source include: shot.
	intermediate := source resultOf: edit.

	edit := intermediate include: otherShot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result include: shot).

	reverted := result resultOf: effect inverse.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { otherShot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.

	self flag: #todo. "For coherence with other set effects, we should expect: FiPath root / -> a FiUpdateEffect"
	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root / #A / #comment -> effect subEffect subEffect }.

	self flag: #todo. "refactor"
	summary := effect hierarchicalSummary.
	self assert: summary isCollection.
	self assert: summary size equals: 1.
	self assert: (summary anyOne isKindOf: FiSummaryUpdate).
	self assert: summary anyOne step equals: #A.
	self assert: summary anyOne subSummary isNotEmpty.
	self assert: (summary anyOne subSummary allSatisfy: [ :each | each isKindOf: FiSummaryUpdate ]).

]

{ #category : #'tests-shot' }
FiEffectTest >> testShotNoEffect [

	| edit effect source result |
	source := FiClass named: #A.

	edit :=  source at: #theName equal: #A.
	effect := source effectOf: edit.
	result := source resultOf: edit.
	
	self assert: effect edit equals: FiNoEdit new.
	self assert: effect inverse equals: FiNoEdit new.
	
	self assert: effect flattenedLeafEffects isEmpty

]

{ #category : #'tests-dictionary' }
FiEffectTest >> testUpdateClass [

	| shot otherShot edit source result intermediate effect reverted |
	source := FiDictionary new.
	shot := FiClass named: #A.
	otherShot := shot resultOf: (shot at: #comment equal: '42').

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate at: #A equal: otherShot.
	effect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result at: #A equal: shot).

	reverted := result resultOf: effect inverse.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { otherShot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.

	self flag: #todo. "For coherence with other dictionary effects, we should expect: FiPath root / -> a FiUpdateEffect"
	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root / #A -> effect subEffect }.

	self 
		assert: effect hierarchicalSummary asArray
		equals: 
			{ FiSummaryUpdate builder 
				step: #A;
				oldValue: shot; 
				newValue: otherShot; 
				subSummary: #();
				new }
]

{ #category : #'tests-shot' }
FiEffectTest >> testUpdateComment [

	| edit effect source result |
	source := FiClass named: #A.

	edit :=  source at: #comment equal: '42'.
	effect := source effectOf: edit.
	result := source resultOf: edit.
	
	self assert: effect oldValue equals: ''.
	self assert: effect edit equals: edit.
	self assert: effect inverse equals: (result at: #comment equal: '').
	
	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root / #comment -> effect subEffect }.

	self 
		assert: effect hierarchicalSummary asArray
		equals: 
			{ FiSummaryUpdate builder 
				step: #comment;
				oldValue: ''; 
				newValue: '42'; 
				subSummary: #();
				new }

]
