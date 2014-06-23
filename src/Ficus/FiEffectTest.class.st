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

	| shot edit source reverted result editEffect |
	source := FiDictionary new.
	shot := FiClass named: #A.

	edit := source at: #A equal: shot.
	editEffect := source effectOf: edit.
	result := source resultOf: edit.

	reverted := result resultOf: editEffect inverse.
	
	self assert: source values isEmpty.
	self assert: result values asSet equals: { shot } asSet.
	self assert: reverted values isEmpty.

	self 
		assert: editEffect flattenedLeafEffects 
		equals: { FiPath root -> editEffect }.

]

{ #category : #'tests-shot' }
FiEffectTest >> testAddSharedPoolAndUpdateComment [

	| source editSharedPools editComment edit effect leafEffectOfEditSharedPools leafEffectOfEditComment |
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

	"These are the 'leaf effects' we expect of #flattenedEffects"
	leafEffectOfEditSharedPools := (source effectOf: editSharedPools) subEffect.
	leafEffectOfEditComment := (source effectOf: editComment) subEffect.
	
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
			}.
			
]

{ #category : #'tests-dictionary' }
FiEffectTest >> testNoEditClass [

	| shot edit source result intermediate editEffect reverted |
	source := FiDictionary new.
	shot := FiClass named: #A.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate at: #A equal: shot.
	editEffect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	reverted := result resultOf: editEffect inverse.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { shot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.

	self assert: editEffect flattenedLeafEffects isEmpty.
]

{ #category : #'tests-dictionary' }
FiEffectTest >> testRemoveClass [

	| edit source result shot intermediate reverted editEffect |
	source := FiDictionary new.
	shot := FiClass named: #A.

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate exclude: shot theName.
	editEffect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	reverted := result resultOf: editEffect inverse.
		
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values isEmpty.
	self assert: reverted values asSet equals: { shot } asSet.

	self 
		assert: editEffect flattenedLeafEffects 
		equals: { FiPath root -> editEffect }.

]

{ #category : #'tests-set' }
FiEffectTest >> testSetRemoveClass [

	| edit source result shot intermediate reverted editEffect |
	source := FiSet new.
	shot := FiClass named: #A.

	edit := source include: shot.
	intermediate := source resultOf: edit.

	edit := intermediate exclude: shot.
	editEffect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	reverted := result resultOf: editEffect inverse.
		
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values isEmpty.
	self assert: reverted values asSet equals: { shot } asSet.

	self 
		assert: editEffect flattenedLeafEffects 
		equals: { FiPath root -> editEffect }.

]

{ #category : #'tests-dictionary' }
FiEffectTest >> testUpdateClass [

	| shot otherShot edit source result intermediate editEffect reverted |
	source := FiDictionary new.
	shot := FiClass named: #A.
	otherShot := shot resultOf: (shot at: #comment equal: '42').

	edit := source at: #A equal: shot.
	intermediate := source resultOf: edit.

	edit := intermediate at: #A equal: otherShot.
	editEffect := intermediate effectOf: edit.
	result := intermediate resultOf: edit.

	reverted := result resultOf: editEffect inverse.
	
	self assert: source values isEmpty.
	self assert: intermediate values asSet equals: { shot } asSet.
	self assert: result values asSet equals: { otherShot } asSet.
	self assert: reverted values asSet equals: { shot } asSet.

	self flag: #todo. "For coherence with other dictionary effects, we should expect: FiPath root / -> a FiUpdateEffect"
	self 
		assert: editEffect flattenedLeafEffects 
		equals: { FiPath root / #A -> editEffect subEffect }.

]

{ #category : #'tests-shot' }
FiEffectTest >> testUpdateComment [

	| edit effect source |
	source := FiClass named: #A.

	edit :=  source at: #comment equal: '42'.
	effect := source effectOf: edit.
	
	self assert: effect oldValue equals: ''.
	self assert: effect edit equals: edit.
	
	self 
		assert: effect flattenedLeafEffects 
		equals: { FiPath root / #comment -> effect subEffect }.

]
